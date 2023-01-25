(** Disambiguation of the parser syntax to the external syntax.

    Elements of the syntax for Beluga require the symbol table for
    disambiguation. This module contains stateful functions for elaborating
    the context-free parser syntax to the data-dependent external syntax. The
    logic for the symbol lookups is repeated in the indexing phase to the
    approximate syntax.

    The "Beluga Language Specification" document contains additional details
    as to which syntactic structures have ambiguities. *)

open Support
open Beluga_syntax
open Common_disambiguation

(** {1 Exceptions} *)

(** {2 Exceptions for meta-type disambiguation} *)

exception Illegal_context_meta_type

exception Illegal_substitution_or_context_contextual_type

(** {2 Exceptions for meta-object disambiguation} *)

exception Illegal_missing_dollar_modifier_meta_object

exception Illegal_hash_modifier_meta_object

exception Expected_meta_object

(** {2 Exceptions for meta-pattern disambiguation} *)

exception Illegal_missing_dollar_modifier_meta_pattern

exception Illegal_hash_modifier_meta_pattern

exception Expected_meta_pattern

(** {2 Exceptions for schema disambiguation} *)

exception Illegal_unnamed_block_element_type

(** {2 Exceptions for meta-context disambiguation} *)

exception Expected_contextual_type

exception Expected_plain_or_renaming_substitution_type

exception Expected_contextual_type_or_schema

exception Illegal_missing_meta_type_annotation

(** {1 Disambiguation} *)

module type META_DISAMBIGUATION = sig
  (** @closed *)
  include State.STATE

  (** {1 Disambiguation} *)

  val disambiguate_meta_typ : Synprs.meta_thing -> Synext.meta_typ t

  val disambiguate_meta_object : Synprs.meta_thing -> Synext.meta_object t

  val disambiguate_schema : Synprs.schema_object -> Synext.schema t

  val with_disambiguated_meta_context :
    Synprs.meta_context_object -> (Synext.meta_context -> 'a t) -> 'a t
end

module type META_PATTERN_DISAMBIGUATION = sig
  (** @closed *)
  include State.STATE

  (** {1 Disambiguation} *)

  val disambiguate_meta_pattern :
    Synprs.meta_thing -> Synext.Meta.Pattern.t t
end

module Make
    (Bindings_state : BINDINGS_STATE)
    (Clf_disambiguation : Clf_disambiguation.CLF_DISAMBIGUATION
                            with type state = Bindings_state.state) :
  META_DISAMBIGUATION with type state = Bindings_state.state = struct
  include Bindings_state
  include Clf_disambiguation

  (** {1 Disambiguation} *)

  let rec disambiguate_meta_typ meta_thing =
    match meta_thing with
    | Synprs.Meta.Thing.RawContext { location; _ } ->
        Error.raise_at1 location Illegal_context_meta_type
    | Synprs.Meta.Thing.RawSchema { location; schema } ->
        let* schema' = disambiguate_schema schema in
        return
          (Synext.Meta.Typ.Context_schema { location; schema = schema' })
    | Synprs.Meta.Thing.RawTurnstile
        { location; context; object_; variant = `Plain }
    (* Contextual type *) ->
        with_disambiguated_clf_context context (fun context' ->
            match object_ with
            | { Synprs.CLF.Context_object.objects = [ (Option.None, typ) ]
              ; head = Synprs.CLF.Context_object.Head.None _
              ; _
              } ->
                let* typ' = disambiguate_clf_typ typ in
                return
                  (Synext.Meta.Typ.Contextual_typ
                     { location; context = context'; typ = typ' })
            | { Synprs.CLF.Context_object.location; _ } ->
                Error.raise_at1 location
                  Illegal_substitution_or_context_contextual_type)
    | Synprs.Meta.Thing.RawTurnstile
        { location; context; object_; variant = `Hash }
    (* Parameter type *) ->
        with_disambiguated_clf_context context (fun context' ->
            match object_ with
            | { Synprs.CLF.Context_object.objects = [ (Option.None, typ) ]
              ; head = Synprs.CLF.Context_object.Head.None _
              ; _
              } ->
                let* typ' = disambiguate_clf_typ typ in
                return
                  (Synext.Meta.Typ.Parameter_typ
                     { location; context = context'; typ = typ' })
            | { Synprs.CLF.Context_object.location; _ } ->
                Error.raise_at1 location
                  Illegal_substitution_or_context_contextual_type)
    | Synprs.Meta.Thing.RawTurnstile
        { location; context; object_; variant = `Dollar }
    (* Plain substitution type *) ->
        with_disambiguated_clf_context context (fun domain' ->
            with_disambiguated_clf_context object_ (fun range' ->
                return
                  (Synext.Meta.Typ.Plain_substitution_typ
                     { location; domain = domain'; range = range' })))
    | Synprs.Meta.Thing.RawTurnstile
        { location; context; object_; variant = `Dollar_hash }
    (* Renaming substitution type *) ->
        with_disambiguated_clf_context context (fun domain' ->
            with_disambiguated_clf_context object_ (fun range' ->
                return
                  (Synext.Meta.Typ.Renaming_substitution_typ
                     { location; domain = domain'; range = range' })))

  and disambiguate_meta_object meta_thing =
    match meta_thing with
    | Synprs.Meta.Thing.RawSchema { location; _ } ->
        Error.raise_at1 location Expected_meta_object
    | Synprs.Meta.Thing.RawTurnstile { location; variant = `Hash; _ } ->
        Error.raise_at1 location Illegal_hash_modifier_meta_object
    | Synprs.Meta.Thing.RawContext { location; context } (* Context *) ->
        with_disambiguated_clf_context context (fun context' ->
            return
              (Synext.Meta.Object.Context { location; context = context' }))
    | Synprs.Meta.Thing.RawTurnstile
        { location; context; object_; variant = `Plain }
    (* Contextual term *) ->
        with_disambiguated_clf_context context (fun context' ->
            let { Synprs.CLF.Context_object.head; objects; _ } = object_ in
            match (head, objects) with
            | Synprs.CLF.Context_object.Head.None _, [ (Option.None, term) ]
              ->
                let* term' = disambiguate_clf_term term in
                return
                  (Synext.Meta.Object.Contextual_term
                     { location; context = context'; term = term' })
            | _ ->
                Error.raise_at1 location
                  Illegal_missing_dollar_modifier_meta_object)
    | Synprs.Meta.Thing.RawTurnstile
        { location; context; object_; variant = `Dollar }
    (* Plain substitution *) ->
        with_disambiguated_clf_context context (fun domain' ->
            let* range' = disambiguate_clf_substitution object_ in
            return
              (Synext.Meta.Object.Plain_substitution
                 { location; domain = domain'; range = range' }))
    | Synprs.Meta.Thing.RawTurnstile
        { location; context; object_; variant = `Dollar_hash }
    (* Renaming substitution *) ->
        with_disambiguated_clf_context context (fun domain' ->
            let* range' = disambiguate_clf_substitution object_ in
            return
              (Synext.Meta.Object.Renaming_substitution
                 { location; domain = domain'; range = range' }))

  and with_disambiguated_clf_bindings_list :
        'a.
           (Identifier.t * Synprs.clf_object) list
        -> ((Identifier.t * Synext.clf_typ) list -> 'a t)
        -> 'a t =
   fun bindings f ->
    match bindings with
    | [] -> f []
    | (identifier, typ) :: xs ->
        let* typ' = disambiguate_clf_typ typ in
        with_lf_term_variable identifier
          (with_disambiguated_clf_bindings_list xs (fun ys ->
               f ((identifier, typ') :: ys)))

  and with_disambiguated_clf_bindings_list1 :
        'a.
           (Identifier.t * Synprs.clf_object) List1.t
        -> ((Identifier.t * Synext.clf_typ) List1.t -> 'a t)
        -> 'a t =
   fun bindings f ->
    let (List1.T ((identifier, typ), xs)) = bindings in
    let* typ' = disambiguate_clf_typ typ in
    with_lf_term_variable identifier
      (with_disambiguated_clf_bindings_list xs (fun ys ->
           f (List1.from (identifier, typ') ys)))

  and disambiguate_schema_block_clause :
         (Identifier.t option * Synprs.clf_object) List1.t
      -> [ `Record of (Identifier.t * Synext.clf_typ) List1.t
         | `Unnamed of Synext.clf_typ
         ]
         t =
   fun block ->
    (* Schema block-clauses are dependent, meaning that bound variables on
       the left of a declaration may appear in the type of a binding on the
       right. Bindings may not recursively refer to themselves.*)
    match block with
    | List1.T ((Option.None, typ), []) ->
        let* typ' = disambiguate_clf_typ typ in
        return (`Unnamed typ')
    | block ->
        let bindings =
          List1.map
            (function
              | Option.None, typ ->
                  Error.raise_at1
                    (Synprs.location_of_clf_object typ)
                    Illegal_unnamed_block_element_type
              | Option.Some identifier, typ -> (identifier, typ))
            block
        in
        with_disambiguated_clf_bindings_list1 bindings (fun bindings' ->
            return (`Record bindings'))

  and disambiguate_schema schema_object =
    match schema_object with
    | Synprs.Meta.Schema_object.Raw_constant { location; identifier } ->
        return (Synext.Meta.Schema.Constant { location; identifier })
    | Synprs.Meta.Schema_object.Raw_alternation { location; schemas } ->
        let* schemas' = traverse_list2 disambiguate_schema schemas in
        return
          (Synext.Meta.Schema.Alternation { location; schemas = schemas' })
    | Synprs.Meta.Schema_object.Raw_element { location; some; block } -> (
        match some with
        | Option.None ->
            let* block' = disambiguate_schema_block_clause block in
            return
              (Synext.Meta.Schema.Element
                 { location; some = Option.none; block = block' })
        | Option.Some some ->
            with_disambiguated_clf_bindings_list1 some (fun some' ->
                let* block' = disambiguate_schema_block_clause block in
                return
                  (Synext.Meta.Schema.Element
                     { location; some = Option.some some'; block = block' }))
        )

  and with_disambiguated_meta_context_binding :
        'a.
           (Identifier.t * [ `Dollar | `Hash | `Plain ])
           * Synprs.meta_thing option
        -> (Identifier.t * Synext.meta_typ -> 'a t)
        -> 'a t =
   fun binding f ->
    match binding with
    | (identifier, `Plain), Option.Some meta_type
    (* Plain meta-variable binding *) -> (
        let* meta_type' = disambiguate_meta_typ meta_type in
        match meta_type' with
        | Synext.Meta.Typ.Context_schema _ ->
            with_context_variable identifier (f (identifier, meta_type'))
        | Synext.Meta.Typ.Contextual_typ _ ->
            with_meta_variable identifier (f (identifier, meta_type'))
        | _ ->
            Error.raise_at1
              (Synext.location_of_meta_type meta_type')
              Expected_contextual_type_or_schema)
    | (identifier, `Hash), Option.Some meta_type
    (* Parameter variable binding *) -> (
        let* meta_type' = disambiguate_meta_typ meta_type in
        match meta_type' with
        | Synext.Meta.Typ.Contextual_typ _ ->
            with_parameter_variable identifier (f (identifier, meta_type'))
        | _ ->
            Error.raise_at1
              (Synext.location_of_meta_type meta_type')
              Expected_contextual_type)
    | (identifier, `Dollar), Option.Some meta_type
    (* Plain substitution or renaming substitution variable binding *) -> (
        let* meta_type' = disambiguate_meta_typ meta_type in
        match meta_type' with
        | Synext.Meta.Typ.Plain_substitution_typ _
        | Synext.Meta.Typ.Renaming_substitution_typ _ ->
            with_substitution_variable identifier
              (f (identifier, meta_type'))
        | _ ->
            Error.raise_at1
              (Synext.location_of_meta_type meta_type')
              Expected_plain_or_renaming_substitution_type)
    | (identifier, _identifier_modifier), Option.None (* Missing meta-type *)
      ->
        Error.raise_at1
          (Identifier.location identifier)
          Illegal_missing_meta_type_annotation

  and with_disambiguated_meta_context_bindings_list :
        'a.
           ((Identifier.t * [ `Dollar | `Hash | `Plain ])
           * Synprs.meta_thing option)
           list
        -> ((Identifier.t * Synext.meta_typ) list -> 'a t)
        -> 'a t =
   fun bindings f ->
    match bindings with
    | [] -> f []
    | binding :: bindings ->
        with_disambiguated_meta_context_binding binding (fun binding' ->
            with_disambiguated_meta_context_bindings_list bindings
              (fun bindings' -> f (binding' :: bindings')))

  and with_disambiguated_meta_context :
        'a.
        Synprs.meta_context_object -> (Synext.meta_context -> 'a t) -> 'a t =
   fun context_object f ->
    let { Synprs.Meta.Context_object.location; bindings } = context_object in
    (* Meta-contexts are dependent, meaning that bound variables on the left
       of a declaration may appear in the type of a binding on the right.
       Bindings may not recursively refer to themselves. *)
    with_disambiguated_meta_context_bindings_list bindings (fun bindings' ->
        f { Synext.Meta.Context.location; bindings = bindings' })
end

module Make_pattern_disambiguator
    (Bindings_state : BINDINGS_STATE)
    (Disambiguation_state : PATTERN_DISAMBGUATION_STATE
                              with module S = Bindings_state)
    (Clf_pattern_disambiguator : Clf_disambiguation
                                 .CLF_PATTERN_DISAMBIGUATION
                                   with type state =
                                     Disambiguation_state.state) :
  META_PATTERN_DISAMBIGUATION with type state = Disambiguation_state.state =
struct
  include Disambiguation_state
  include Clf_pattern_disambiguator

  let disambiguate_meta_pattern meta_thing =
    match meta_thing with
    | Synprs.Meta.Thing.RawSchema { location; _ } ->
        Error.raise_at1 location Expected_meta_pattern
    | Synprs.Meta.Thing.RawTurnstile { location; variant = `Hash; _ } ->
        Error.raise_at1 location Illegal_hash_modifier_meta_pattern
    | Synprs.Meta.Thing.RawContext { location; context } (* Context *) ->
        with_disambiguated_clf_context_pattern context (fun context' ->
            return
              (Synext.Meta.Pattern.Context { location; context = context' }))
    | Synprs.Meta.Thing.RawTurnstile
        { location; context; object_; variant = `Plain }
    (* Contextual term *) ->
        with_disambiguated_clf_context_pattern context (fun context' ->
            let { Synprs.CLF.Context_object.head; objects; _ } = object_ in
            match (head, objects) with
            | Synprs.CLF.Context_object.Head.None _, [ (Option.None, term) ]
              ->
                let* term' = disambiguate_clf_term_pattern term in
                return
                  (Synext.Meta.Pattern.Contextual_term
                     { location; context = context'; term = term' })
            | _ ->
                Error.raise_at1 location
                  Illegal_missing_dollar_modifier_meta_pattern)
    | Synprs.Meta.Thing.RawTurnstile
        { location; context; object_; variant = `Dollar }
    (* Plain substitution pattern *) ->
        with_disambiguated_clf_context_pattern context (fun domain' ->
            let* range' = disambiguate_clf_substitution_pattern object_ in
            return
              (Synext.Meta.Pattern.Plain_substitution
                 { location; domain = domain'; range = range' }))
    | Synprs.Meta.Thing.RawTurnstile
        { location; context; object_; variant = `Dollar_hash }
    (* Renaming substitution pattern *) ->
        with_disambiguated_clf_context_pattern context (fun domain' ->
            let* range' = disambiguate_clf_substitution_pattern object_ in
            return
              (Synext.Meta.Pattern.Renaming_substitution
                 { location; domain = domain'; range = range' }))
end