open Support
open Beluga_syntax

[@@@warning "+A-4-44"]

exception Bound_lf_type_constant of Qualified_identifier.t

exception Bound_lf_term_constant of Qualified_identifier.t

exception Bound_lf_variable of Qualified_identifier.t

exception Bound_meta_variable of Qualified_identifier.t

exception Bound_parameter_variable of Qualified_identifier.t

exception Bound_substitution_variable of Qualified_identifier.t

exception Bound_context_variable of Qualified_identifier.t

exception Bound_contextual_variable of Qualified_identifier.t

exception Bound_schema_constant of Qualified_identifier.t

exception Bound_computation_variable of Qualified_identifier.t

exception Bound_computation_inductive_type_constant of Qualified_identifier.t

exception
  Bound_computation_stratified_type_constant of Qualified_identifier.t

exception
  Bound_computation_coinductive_type_constant of Qualified_identifier.t

exception
  Bound_computation_abbreviation_type_constant of Qualified_identifier.t

exception Bound_computation_term_constructor of Qualified_identifier.t

exception Bound_computation_term_destructor of Qualified_identifier.t

exception Bound_module of Qualified_identifier.t

exception Bound_program_constant of Qualified_identifier.t

exception Expected_lf_typ_constant

exception Expected_lf_term_constant

exception Expected_schema_constant

exception Expected_computation_inductive_type_constant

exception Expected_computation_stratified_type_constant

exception Expected_computation_coinductive_type_constant

exception Expected_computation_abbreviation_type_constant

exception Expected_computation_term_constructor

exception Expected_computation_term_destructor

exception Expected_program_constant

exception Expected_module

exception Expected_lf_variable

exception Expected_meta_variable

exception Expected_parameter_variable

exception Expected_substitution_variable

exception Expected_context_variable

exception Expected_computation_variable

exception Illegal_free_lf_variable

exception Illegal_free_meta_variable

exception Illegal_free_parameter_variable

exception Illegal_free_substitution_variable

exception Illegal_free_context_variable

exception Illegal_free_computation_variable

exception Unknown_lf_variable_index

exception Unknown_meta_variable_index

exception Unknown_parameter_variable_index

exception Unknown_substitution_variable_index

exception Unknown_context_variable_index

exception Unknown_computation_variable_index

exception Duplicate_pattern_variables of Identifier.t List2.t

let () =
  Error.register_exception_printer (function
    | Bound_lf_type_constant qualified_identifier ->
        Format.dprintf "%a is a bound LF type constant."
          Qualified_identifier.pp qualified_identifier
    | Bound_lf_term_constant qualified_identifier ->
        Format.dprintf "%a is a bound LF term constant."
          Qualified_identifier.pp qualified_identifier
    | Bound_lf_variable qualified_identifier ->
        Format.dprintf "%a is a bound LF term variable."
          Qualified_identifier.pp qualified_identifier
    | Bound_meta_variable qualified_identifier ->
        Format.dprintf "%a is a bound meta-variable." Qualified_identifier.pp
          qualified_identifier
    | Bound_parameter_variable qualified_identifier ->
        Format.dprintf "%a is a bound parameter variable."
          Qualified_identifier.pp qualified_identifier
    | Bound_substitution_variable qualified_identifier ->
        Format.dprintf "%a is a bound substitution variable."
          Qualified_identifier.pp qualified_identifier
    | Bound_context_variable qualified_identifier ->
        Format.dprintf "%a is a bound context variable."
          Qualified_identifier.pp qualified_identifier
    | Bound_contextual_variable qualified_identifier ->
        Format.dprintf "%a is a bound contextual variable."
          Qualified_identifier.pp qualified_identifier
    | Bound_schema_constant qualified_identifier ->
        Format.dprintf "%a is a bound schema constant."
          Qualified_identifier.pp qualified_identifier
    | Bound_computation_variable qualified_identifier ->
        Format.dprintf "%a is a bound computation variable."
          Qualified_identifier.pp qualified_identifier
    | Bound_computation_inductive_type_constant qualified_identifier ->
        Format.dprintf
          "%a is a bound computation-level inductive type constant."
          Qualified_identifier.pp qualified_identifier
    | Bound_computation_stratified_type_constant qualified_identifier ->
        Format.dprintf
          "%a is a bound computation-level stratified type constant."
          Qualified_identifier.pp qualified_identifier
    | Bound_computation_coinductive_type_constant qualified_identifier ->
        Format.dprintf
          "%a is a bound computation-level coinductive type constant."
          Qualified_identifier.pp qualified_identifier
    | Bound_computation_abbreviation_type_constant qualified_identifier ->
        Format.dprintf
          "%a is a bound computation-level abbreviation type constant."
          Qualified_identifier.pp qualified_identifier
    | Bound_computation_term_constructor qualified_identifier ->
        Format.dprintf "%a is a bound computation-level term constructor."
          Qualified_identifier.pp qualified_identifier
    | Bound_computation_term_destructor qualified_identifier ->
        Format.dprintf "%a is a bound computation-level term destructor."
          Qualified_identifier.pp qualified_identifier
    | Bound_module qualified_identifier ->
        Format.dprintf "%a is a bound module." Qualified_identifier.pp
          qualified_identifier
    | Bound_program_constant qualified_identifier ->
        Format.dprintf "%a is a bound program." Qualified_identifier.pp
          qualified_identifier
    | Expected_lf_typ_constant ->
        Format.dprintf "Expected an LF type-level constant."
    | Expected_lf_term_constant ->
        Format.dprintf "Expected an LF term-level constant."
    | Expected_schema_constant ->
        Format.dprintf "Expected a schema constant."
    | Expected_computation_inductive_type_constant ->
        Format.dprintf "Expected an inductive computation type constant."
    | Expected_computation_stratified_type_constant ->
        Format.dprintf "Expected a stratified computation type constant."
    | Expected_computation_coinductive_type_constant ->
        Format.dprintf "Expected a coinductive computation type constant."
    | Expected_computation_abbreviation_type_constant ->
        Format.dprintf "Expected an abbreviation computation type constant."
    | Expected_computation_term_constructor ->
        Format.dprintf "Expected a computation constructor constant."
    | Expected_computation_term_destructor ->
        Format.dprintf "Expected a computation destructor constant."
    | Expected_program_constant ->
        Format.dprintf "Expected a computation program constant."
    | Expected_module -> Format.dprintf "Expected a module constant."
    | Expected_lf_variable -> Format.dprintf "Expected an LF variable."
    | Expected_meta_variable -> Format.dprintf "Expected a meta-variable."
    | Expected_parameter_variable ->
        Format.dprintf "Expected a parameter variable."
    | Expected_substitution_variable ->
        Format.dprintf "Expected a substitution variable."
    | Expected_context_variable ->
        Format.dprintf "Expected a context variable."
    | Expected_computation_variable ->
        Format.dprintf "Expected a computation-level variable."
    | Illegal_free_lf_variable ->
        Format.dprintf "This free LF variable is illegal."
    | Illegal_free_meta_variable ->
        Format.dprintf "This free meta-variable is illegal."
    | Illegal_free_parameter_variable ->
        Format.dprintf "This free parameter variable is illegal."
    | Illegal_free_substitution_variable ->
        Format.dprintf "This free substitution variable is illegal."
    | Illegal_free_context_variable ->
        Format.dprintf "This free context variable is illegal."
    | Illegal_free_computation_variable ->
        Format.dprintf "This free computation-level variable is illegal."
    | Unknown_lf_variable_index ->
        Format.dprintf
          "The de Bruijn index of this LF variable is unexpectedly unknown."
    | Unknown_meta_variable_index ->
        Format.dprintf
          "The de Bruijn index of this meta-variable is unexpectedly \
           unknown."
    | Unknown_parameter_variable_index ->
        Format.dprintf
          "The de Bruijn index of this parameter variable is unexpectedly \
           unknown."
    | Unknown_substitution_variable_index ->
        Format.dprintf
          "The de Bruijn index of this substitution variable is \
           unexpectedly unknown."
    | Unknown_context_variable_index ->
        Format.dprintf
          "The de Bruijn index of this context variable is unexpectedly \
           unknown."
    | Unknown_computation_variable_index ->
        Format.dprintf
          "The de Bruijn index of this computation variable is unexpectedly \
           unknown."
    | Duplicate_pattern_variables _ ->
        Format.dprintf "Illegal duplicate pattern variables."
    | exn -> Error.raise_unsupported_exception_printing exn)

(** Abstract definition of de Bruijn levels.

    A de Bruin level indexes a variable from the bottom of the context when
    viewed as a stack. In other words, the de Bruin level of a variable in a
    context represented as a list is the 0-based index of that variable in
    the list.

    If variable [x] has de Bruijn level [l] in a context [psi], then the de
    Bruijn index of [x] is [length(psi) - l]. *)
module type LEVEL = sig
  type t

  val of_int : Int.t -> t

  val to_int : t -> Int.t
end

(** Concrete definition of de Bruijn levels. *)
module Level = struct
  type t = int

  let of_int = Fun.id

  let to_int = Fun.id
end

(** Concrete definition of de Bruijn levels for the context of LF-bound
    variables.

    The context of LF-bound variables is typically denoted [cPsi]. If
    variable [x] is in [cPsi] with level [l], then the de Bruijn index of [x]
    is [length(cPsi) - l]. *)
module Lf_level : LEVEL = Level

(** Concrete definition of de Bruijn levels for the context of meta-level
    bound variables.

    The context of meta-level bound variables is typically denoted [cD]. If
    variable [x] is in [cD] with level [l], then the de Bruijn index of [x]
    is [length(cD) - l]. *)
module Meta_level : LEVEL = Level

(** Concrete definition of de Bruijn levels for the context of
    computation-level bound variables.

    The context of computation-level bound variables is typically denoted
    [cG]. If variable [x] is in [cG] with level [l], then the de Bruijn index
    of [x] is [length(cG) - l]. *)
module Comp_level : LEVEL = Level

(** Concrete definition of entries in the store for indexing.

    Variables are stored with their associated de Bruijn level because
    variables in [cPsi], [cD] and [cG] share the same namespace. This avoids
    explicitly representing those contexts as lists. Additionally, we do not
    have to pollute the namespace with fresh variables generated for binders
    that omit their identifier, like the LF term-level abstraction [\_. x]. *)
module Entry = struct
  type t =
    { binding_location : Location.t
    ; desc : desc
    }

  and desc =
    | Lf_variable of
        { lf_level : Lf_level.t Option.t
              (** The de Bruijn level of the LF variable. If it is
                  [Option.None], then this is a free variable, whose level is
                  unknown. *)
        }
    | Meta_variable of
        { meta_level : Meta_level.t Option.t
              (** The de Bruijn level of the meta-variable. If it is
                  [Option.None], then this is a free variable, whose level is
                  unknown. *)
        }
    | Parameter_variable of
        { meta_level : Meta_level.t Option.t
              (** The de Bruijn level of the parameter variable. If it is
                  [Option.None], then this is a free variable, whose level is
                  unknown. *)
        }
    | Substitution_variable of
        { meta_level : Meta_level.t Option.t
              (** The de Bruijn level of the substitution variable. If it is
                  [Option.None], then this is a free variable, whose level is
                  unknown. *)
        }
    | Context_variable of
        { meta_level : Meta_level.t Option.t
              (** The de Bruijn level of the context variable. If it is
                  [Option.None], then this is a free variable, whose level is
                  unknown. *)
        }
    | Contextual_variable of
        { meta_level : Meta_level.t Option.t
              (** The de Bruijn level of the contextual variable. If it is
                  [Option.None], then this is a free variable, whose level is
                  unknown. *)
        }
        (** A contextual variable is either a meta, parameter, substitution,
            or context variable. Contextual variables are introduced
            ambiguously by [mlam]-expressions. *)
    | Computation_variable of
        { comp_level : Comp_level.t Option.t
              (** The de Bruijn level of the computation-level variable. If
                  it is [Option.None], then this is a free variable, whose
                  level is unknown. *)
        }
    | Lf_type_constant of { cid : Id.cid_typ }
    | Lf_term_constant of { cid : Id.cid_term }
    | Schema_constant of { cid : Id.cid_schema }
    | Computation_inductive_type_constant of { cid : Id.cid_comp_typ }
    | Computation_stratified_type_constant of { cid : Id.cid_comp_typ }
    | Computation_coinductive_type_constant of { cid : Id.cid_comp_cotyp }
    | Computation_abbreviation_type_constant of { cid : Id.cid_comp_typdef }
    | Computation_term_constructor of { cid : Id.cid_comp_const }
    | Computation_term_destructor of { cid : Id.cid_comp_dest }
    | Program_constant of { cid : Id.cid_prog }
    | Module of { cid : Id.module_id }

  let[@inline] binding_location ?location identifier =
    match location with
    | Option.Some binding_location -> binding_location
    | Option.None -> Identifier.location identifier

  let[@inline] make_entry ?location identifier desc =
    let binding_location = binding_location ?location identifier in
    { binding_location; desc }

  let[@inline] make_lf_variable_entry ?location identifier ~lf_level =
    make_entry ?location identifier (Lf_variable { lf_level })

  let[@inline] make_meta_variable_entry ?location identifier ~meta_level =
    make_entry ?location identifier (Meta_variable { meta_level })

  let[@inline] make_parameter_variable_entry ?location identifier ~meta_level
      =
    make_entry ?location identifier (Parameter_variable { meta_level })

  let[@inline] make_substitution_variable_entry ?location identifier
      ~meta_level =
    make_entry ?location identifier (Substitution_variable { meta_level })

  let[@inline] make_context_variable_entry ?location identifier ~meta_level =
    make_entry ?location identifier (Context_variable { meta_level })

  let[@inline] make_contextual_variable_entry ?location identifier
      ~meta_level =
    make_entry ?location identifier (Contextual_variable { meta_level })

  let[@inline] make_computation_variable_entry ?location identifier
      ~comp_level =
    make_entry ?location identifier (Computation_variable { comp_level })

  let[@inline] make_lf_type_constant_entry ?location identifier cid =
    make_entry ?location identifier (Lf_type_constant { cid })

  let[@inline] make_lf_term_constant_entry ?location identifier cid =
    make_entry ?location identifier (Lf_term_constant { cid })

  let[@inline] make_schema_constant_entry ?location identifier cid =
    make_entry ?location identifier (Schema_constant { cid })

  let[@inline] make_computation_inductive_type_constant_entry ?location
      identifier cid =
    make_entry ?location identifier
      (Computation_inductive_type_constant { cid })

  let[@inline] make_computation_stratified_type_constant_entry ?location
      identifier cid =
    make_entry ?location identifier
      (Computation_stratified_type_constant { cid })

  let[@inline] make_computation_coinductive_type_constant_entry ?location
      identifier cid =
    make_entry ?location identifier
      (Computation_coinductive_type_constant { cid })

  let[@inline] make_computation_abbreviation_type_constant_entry ?location
      identifier cid =
    make_entry ?location identifier
      (Computation_abbreviation_type_constant { cid })

  let[@inline] make_computation_term_constructor_entry ?location identifier
      cid =
    make_entry ?location identifier (Computation_term_constructor { cid })

  let[@inline] make_computation_term_destructor_entry ?location identifier
      cid =
    make_entry ?location identifier (Computation_term_destructor { cid })

  let[@inline] make_program_constant_entry ?location identifier cid =
    make_entry ?location identifier (Program_constant { cid })

  let[@inline] make_module_entry ?location identifier cid =
    make_entry ?location identifier (Module { cid })

  let actual_binding_exn identifier { binding_location; desc } =
    Error.located_exception1 binding_location
      (match desc with
      | Lf_variable _ -> Bound_lf_variable identifier
      | Meta_variable _ -> Bound_meta_variable identifier
      | Parameter_variable _ -> Bound_parameter_variable identifier
      | Substitution_variable _ -> Bound_substitution_variable identifier
      | Context_variable _ -> Bound_context_variable identifier
      | Contextual_variable _ -> Bound_contextual_variable identifier
      | Computation_variable _ -> Bound_computation_variable identifier
      | Lf_type_constant _ -> Bound_lf_type_constant identifier
      | Lf_term_constant _ -> Bound_lf_term_constant identifier
      | Schema_constant _ -> Bound_schema_constant identifier
      | Computation_inductive_type_constant _ ->
          Bound_computation_inductive_type_constant identifier
      | Computation_stratified_type_constant _ ->
          Bound_computation_stratified_type_constant identifier
      | Computation_coinductive_type_constant _ ->
          Bound_computation_coinductive_type_constant identifier
      | Computation_abbreviation_type_constant _ ->
          Bound_computation_abbreviation_type_constant identifier
      | Computation_term_constructor _ ->
          Bound_computation_term_constructor identifier
      | Computation_term_destructor _ ->
          Bound_computation_term_destructor identifier
      | Program_constant _ -> Bound_program_constant identifier
      | Module _ -> Bound_module identifier)

  let is_variable entry =
    match entry.desc with
    | Lf_variable _
    | Meta_variable _
    | Parameter_variable _
    | Substitution_variable _
    | Context_variable _
    | Contextual_variable _
    | Computation_variable _ ->
        true
    | Lf_type_constant _
    | Lf_term_constant _
    | Schema_constant _
    | Computation_inductive_type_constant _
    | Computation_stratified_type_constant _
    | Computation_coinductive_type_constant _
    | Computation_abbreviation_type_constant _
    | Computation_term_constructor _
    | Computation_term_destructor _
    | Program_constant _
    | Module _ ->
        false
end

module Mutable_indexing_state = struct
  module Binding_tree = Binding_tree.Hashtbl

  type entry_binding_tree = Entry.t Binding_tree.t

  type bindings =
    { bindings : entry_binding_tree
    ; mutable lf_context_size : Int.t
          (** The length of [cPsi], the context of LF-bound variables. *)
    ; mutable meta_context_size : Int.t
          (** The length of [cD], the context of meta-level variables. *)
    ; mutable comp_context_size : Int.t
          (** The length of [cG], the context of computation-level variables. *)
    }

  type scope =
    | Plain_scope of { bindings : bindings }
    | Pattern_scope of
        { pattern_bindings : bindings
        ; mutable pattern_variables_rev : Identifier.t List.t
        ; expression_bindings : bindings
        }
    | Module_scope of
        { bindings : bindings
        ; declarations : entry_binding_tree
        }

  type state =
    { mutable scopes : scope List1.t
    ; mutable free_variables_allowed : Bool.t
    ; mutable generated_fresh_variables_count : Int.t
    }

  let[@inline] create_empty_bindings () =
    { bindings = Binding_tree.create ()
    ; lf_context_size = 0
    ; meta_context_size = 0
    ; comp_context_size = 0
    }

  let[@inline] create_empty_module_scope () =
    Module_scope
      { bindings = create_empty_bindings ()
      ; declarations = Binding_tree.create ()
      }

  let[@inline] create_initial_state () =
    { scopes = List1.singleton (create_empty_module_scope ())
    ; free_variables_allowed = false
    ; generated_fresh_variables_count = 0
    }

  let[@inline] enable_free_variables state =
    state.free_variables_allowed <- true

  let[@inline] disable_free_variables state =
    state.free_variables_allowed <- false

  let[@inline] set_free_variables_allowed_state state free_variables_allowed
      =
    state.free_variables_allowed <- free_variables_allowed

  let[@inline] are_free_variables_allowed state =
    state.free_variables_allowed

  let fresh_identifier state =
    let i = state.generated_fresh_variables_count in
    state.generated_fresh_variables_count <- i + 1;
    (* ['"'] is a reserved character, so ["\"i1"], ["\"i2"], ..., etc. are
       syntactically invalid identifiers, which are guaranteed to not clash
       with free variables *)
    Identifier.make ("\"i" ^ string_of_int i)

  let fresh_identifier_opt state = function
    | Option.Some identifier -> identifier
    | Option.None -> fresh_identifier state

  let[@inline] get_scope_bindings_state = function
    | Pattern_scope { pattern_bindings = bindings; _ }
    | Module_scope { bindings; _ }
    | Plain_scope { bindings } ->
        bindings

  let[@inline] get_scope_bindings state =
    (get_scope_bindings_state state).bindings

  let[@inline] push_scope state scope =
    state.scopes <- List1.cons scope state.scopes

  let pop_scope state =
    match state.scopes with
    | List1.T (x1, x2 :: xs) ->
        state.scopes <- List1.from x2 xs;
        x1
    | List1.T (_x, []) ->
        Error.raise_violation
          (Format.asprintf "[%s] cannot pop the last scope" __FUNCTION__)

  let[@inline] get_current_scope state = List1.head state.scopes

  let[@inline] get_current_scope_bindings_state state =
    get_scope_bindings_state (get_current_scope state)

  let[@inline] get_current_scope_bindings state =
    let current_scope_bindings_state =
      get_current_scope_bindings_state state
    in
    current_scope_bindings_state.bindings

  (** [push_new_plain_scope state] pushes a new empty plain scope to [state].
      The LF, meta and computation context sizes are carried over. *)
  let push_new_plain_scope state =
    let current_scope_bindings_state =
      get_current_scope_bindings_state state
    in
    let scope =
      Plain_scope
        { bindings =
            { current_scope_bindings_state with
              bindings = Binding_tree.create ()
            }
        }
    in
    push_scope state scope

  let entry_is_not_variable entry = Bool.not (Entry.is_variable entry)

  let lookup_toplevel_in_scope scope query =
    Binding_tree.lookup_toplevel_opt query (get_scope_bindings scope)

  let lookup_toplevel_in_scopes scopes query =
    List.find_map (fun scope -> lookup_toplevel_in_scope scope query) scopes

  let lookup_toplevel_declaration_in_scope scope query =
    Binding_tree.lookup_toplevel_filter_opt query entry_is_not_variable
      (get_scope_bindings scope)

  let lookup_toplevel_declaration_in_scopes scopes query =
    List.find_map
      (fun scope -> lookup_toplevel_declaration_in_scope scope query)
      scopes

  let lookup_toplevel_opt state query =
    match state.scopes with
    | List1.T ((Pattern_scope _ as scope), scopes) -> (
        match lookup_toplevel_in_scope scope query with
        | Option.Some x -> Option.some x
        | Option.None -> lookup_toplevel_declaration_in_scopes scopes query)
    | List1.T (scope, scopes) ->
        lookup_toplevel_in_scopes (scope :: scopes) query

  let rec lookup_in_scopes scopes identifiers =
    match scopes with
    | [] ->
        Error.raise
          (Qualified_identifier.Unbound_qualified_identifier
             (Qualified_identifier.from_list1 identifiers))
    | scope :: scopes -> (
        match
          Binding_tree.maximum_lookup identifiers (get_scope_bindings scope)
        with
        | `Bound result -> result
        | `Partially_bound
            ( bound_segments
            , (identifier, _entry, _subtree)
            , _unbound_segments ) ->
            Error.raise
              (Qualified_identifier.Unbound_namespace
                 (Qualified_identifier.make ~namespaces:bound_segments
                    identifier))
        | `Unbound _ -> lookup_in_scopes scopes identifiers)

  let rec lookup_declaration_in_scopes scopes identifiers =
    match scopes with
    | [] ->
        Error.raise
          (Qualified_identifier.Unbound_qualified_identifier
             (Qualified_identifier.from_list1 identifiers))
    | scope :: scopes -> (
        match
          Binding_tree.maximum_lookup_filter identifiers
            entry_is_not_variable
            (get_scope_bindings scope)
        with
        | `Bound result -> result
        | `Partially_bound
            ( bound_segments
            , (identifier, _entry, _subtree)
            , _unbound_segments ) ->
            Error.raise
              (Qualified_identifier.Unbound_namespace
                 (Qualified_identifier.make ~namespaces:bound_segments
                    identifier))
        | `Unbound _ -> lookup_declaration_in_scopes scopes identifiers)

  let lookup state query =
    let identifiers = Qualified_identifier.to_list1 query in
    match state.scopes with
    | List1.T ((Pattern_scope _ as scope), scopes) -> (
        match
          Binding_tree.maximum_lookup identifiers (get_scope_bindings scope)
        with
        | `Bound result -> result
        | `Partially_bound
            ( bound_segments
            , (identifier, _entry, _subtree)
            , _unbound_segments ) ->
            Error.raise
              (Qualified_identifier.Unbound_namespace
                 (Qualified_identifier.make ~namespaces:bound_segments
                    identifier))
        | `Unbound _ -> lookup_declaration_in_scopes scopes identifiers)
    | List1.T (scope, scopes) ->
        lookup_in_scopes (scope :: scopes) identifiers

  let add_binding state identifier ?subtree entry =
    match get_current_scope state with
    | Plain_scope { bindings }
    | Pattern_scope { pattern_bindings = bindings; _ }
    | Module_scope { bindings; _ } ->
        Binding_tree.add_toplevel identifier entry ?subtree bindings.bindings

  let remove_lf_binding state identifier =
    match get_current_scope state with
    | Plain_scope { bindings }
    | Pattern_scope { pattern_bindings = bindings; _ }
    | Module_scope { bindings; _ } ->
        Binding_tree.remove identifier bindings.bindings;
        bindings.lf_context_size <- bindings.lf_context_size - 1

  let remove_meta_binding state identifier =
    match get_current_scope state with
    | Plain_scope { bindings }
    | Pattern_scope { pattern_bindings = bindings; _ }
    | Module_scope { bindings; _ } ->
        Binding_tree.remove identifier bindings.bindings;
        bindings.meta_context_size <- bindings.meta_context_size - 1

  let remove_comp_binding state identifier =
    match get_current_scope state with
    | Plain_scope { bindings }
    | Pattern_scope { pattern_bindings = bindings; _ }
    | Module_scope { bindings; _ } ->
        Binding_tree.remove identifier bindings.bindings;
        bindings.comp_context_size <- bindings.comp_context_size - 1

  let add_declaration state identifier ?subtree entry =
    match get_current_scope state with
    | Plain_scope _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid plain scope disambiguation state"
             __FUNCTION__)
    | Pattern_scope _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid pattern scope disambiguation state"
             __FUNCTION__)
    | Module_scope { bindings; declarations } ->
        Binding_tree.add_toplevel identifier entry ?subtree bindings.bindings;
        Binding_tree.add_toplevel identifier entry ?subtree declarations

  let add_lf_level_variable state identifier make_entry =
    let bindings = get_current_scope_bindings_state state in
    let entry =
      make_entry
        ~lf_level:(Option.some (Lf_level.of_int bindings.lf_context_size))
    in
    bindings.lf_context_size <- bindings.lf_context_size + 1;
    Binding_tree.add_toplevel identifier entry bindings.bindings

  let add_meta_level_variable state identifier make_entry =
    let bindings = get_current_scope_bindings_state state in
    let entry =
      make_entry
        ~meta_level:
          (Option.some (Meta_level.of_int bindings.meta_context_size))
    in
    bindings.meta_context_size <- bindings.meta_context_size + 1;
    Binding_tree.add_toplevel identifier entry bindings.bindings

  let add_comp_level_variable state identifier make_entry =
    let bindings = get_current_scope_bindings_state state in
    let entry =
      make_entry
        ~comp_level:
          (Option.some (Comp_level.of_int bindings.comp_context_size))
    in
    bindings.comp_context_size <- bindings.comp_context_size + 1;
    Binding_tree.add_toplevel identifier entry bindings.bindings

  let add_lf_variable state ?location identifier =
    add_lf_level_variable state identifier
      (Entry.make_lf_variable_entry ?location identifier)

  let add_meta_variable state ?location identifier =
    add_meta_level_variable state identifier
      (Entry.make_meta_variable_entry ?location identifier)

  let add_parameter_variable state ?location identifier =
    add_meta_level_variable state identifier
      (Entry.make_parameter_variable_entry ?location identifier)

  let add_substitution_variable state ?location identifier =
    add_meta_level_variable state identifier
      (Entry.make_substitution_variable_entry ?location identifier)

  let add_context_variable state ?location identifier =
    add_meta_level_variable state identifier
      (Entry.make_context_variable_entry ?location identifier)

  let add_contextual_variable state ?location identifier =
    add_meta_level_variable state identifier
      (Entry.make_contextual_variable_entry ?location identifier)

  let add_comp_variable state ?location identifier =
    add_comp_level_variable state identifier
      (Entry.make_computation_variable_entry ?location identifier)

  let shift_lf_context state =
    let bindings_state = get_current_scope_bindings_state state in
    bindings_state.lf_context_size <- bindings_state.lf_context_size + 1

  let unshift_lf_context state =
    let bindings_state = get_current_scope_bindings_state state in
    bindings_state.lf_context_size <- bindings_state.lf_context_size - 1

  let shift_meta_context state =
    let bindings_state = get_current_scope_bindings_state state in
    bindings_state.meta_context_size <- bindings_state.meta_context_size + 1

  let unshift_meta_context state =
    let bindings_state = get_current_scope_bindings_state state in
    bindings_state.meta_context_size <- bindings_state.meta_context_size - 1

  let shift_comp_context state =
    let bindings_state = get_current_scope_bindings_state state in
    bindings_state.comp_context_size <- bindings_state.comp_context_size + 1

  let unshift_comp_context state =
    let bindings_state = get_current_scope_bindings_state state in
    bindings_state.comp_context_size <- bindings_state.comp_context_size - 1

  let start_module state =
    let current_scope_bindings_state =
      get_current_scope_bindings_state state
    in
    let module_scope =
      Module_scope
        { bindings =
            { current_scope_bindings_state with
              bindings = Binding_tree.create ()
            }
        ; declarations = Binding_tree.create ()
        }
    in
    push_scope state module_scope

  let stop_module state ?location identifier cid =
    match get_current_scope state with
    | Plain_scope _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid plain scope" __FUNCTION__)
    | Pattern_scope _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid pattern scope" __FUNCTION__)
    | Module_scope { declarations; _ } ->
        ignore (pop_scope state);
        add_declaration state ~subtree:declarations identifier
          (Entry.make_module_entry ?location identifier cid)

  let actual_binding_exn = Entry.actual_binding_exn

  let index_of_lf_typ_constant state qualified_identifier =
    match lookup state qualified_identifier with
    | { Entry.desc = Entry.Lf_type_constant { cid }; _ }, _ -> cid
    | entry, _ ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2 Expected_lf_typ_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_lf_term_constant state qualified_identifier =
    match lookup state qualified_identifier with
    | { Entry.desc = Entry.Lf_term_constant { cid }; _ }, _ -> cid
    | entry, _ ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2 Expected_lf_term_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_inductive_comp_constant state qualified_identifier =
    match lookup state qualified_identifier with
    | ( { Entry.desc = Entry.Computation_inductive_type_constant { cid }; _ }
      , _ ) ->
        cid
    | entry, _ ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2
             Expected_computation_inductive_type_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_stratified_comp_constant state qualified_identifier =
    match lookup state qualified_identifier with
    | ( { Entry.desc = Entry.Computation_stratified_type_constant { cid }; _ }
      , _ ) ->
        cid
    | entry, _ ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2
             Expected_computation_stratified_type_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_coinductive_comp_constant state qualified_identifier =
    match lookup state qualified_identifier with
    | ( { Entry.desc = Entry.Computation_coinductive_type_constant { cid }
        ; _
        }
      , _ ) ->
        cid
    | entry, _ ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2
             Expected_computation_coinductive_type_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_abbreviation_comp_constant state qualified_identifier =
    match lookup state qualified_identifier with
    | ( { Entry.desc = Entry.Computation_abbreviation_type_constant { cid }
        ; _
        }
      , _ ) ->
        cid
    | entry, _ ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2
             Expected_computation_abbreviation_type_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_schema_constant state qualified_identifier =
    match lookup state qualified_identifier with
    | { Entry.desc = Entry.Schema_constant { cid }; _ }, _ -> cid
    | entry, _ ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2 Expected_schema_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_comp_constructor state qualified_identifier =
    match lookup state qualified_identifier with
    | { Entry.desc = Entry.Computation_term_constructor { cid }; _ }, _ ->
        cid
    | entry, _ ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2 Expected_computation_term_constructor
             (actual_binding_exn qualified_identifier entry))

  let index_of_comp_destructor state qualified_identifier =
    match lookup state qualified_identifier with
    | { Entry.desc = Entry.Computation_term_destructor { cid }; _ }, _ -> cid
    | entry, _ ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2 Expected_computation_term_destructor
             (actual_binding_exn qualified_identifier entry))

  let index_of_comp_program state qualified_identifier =
    match lookup state qualified_identifier with
    | { Entry.desc = Entry.Program_constant { cid }; _ }, _ -> cid
    | entry, _ ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2 Expected_program_constant
             (actual_binding_exn qualified_identifier entry))

  let[@inline] get_lf_context_size state =
    let current_scope_bindings_state =
      get_current_scope_bindings_state state
    in
    current_scope_bindings_state.lf_context_size

  let[@inline] get_meta_context_size state =
    let current_scope_bindings_state =
      get_current_scope_bindings_state state
    in
    current_scope_bindings_state.meta_context_size

  let[@inline] get_comp_context_size state =
    let current_scope_bindings_state =
      get_current_scope_bindings_state state
    in
    current_scope_bindings_state.comp_context_size

  let[@inline] index_of_lf_level state lf_level =
    let lf_context_size = get_lf_context_size state in
    lf_context_size - Lf_level.to_int lf_level

  let[@inline] index_of_meta_level state meta_level =
    let meta_context_size = get_meta_context_size state in
    meta_context_size - Meta_level.to_int meta_level

  let[@inline] index_of_comp_level state comp_level =
    let comp_context_size = get_comp_context_size state in
    comp_context_size - Comp_level.to_int comp_level

  let index_of_lf_variable state identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some ({ Entry.desc = Entry.Lf_variable { lf_level }; _ }, _)
      -> (
        match lf_level with
        | Option.Some lf_level -> index_of_lf_level state lf_level
        | Option.None ->
            Error.raise_at1
              (Identifier.location identifier)
              Unknown_lf_variable_index)
    | Option.Some (entry, _) ->
        Error.raise_at1
          (Identifier.location identifier)
          (Error.composite_exception2 Expected_lf_variable
             (actual_binding_exn
                (Qualified_identifier.make_simple identifier)
                entry))
    | Option.None ->
        Error.raise_at1
          (Identifier.location identifier)
          (Identifier.Unbound_identifier identifier)

  let index_of_lf_variable_opt state identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some ({ Entry.desc = Entry.Lf_variable { lf_level }; _ }, _)
      -> (
        match lf_level with
        | Option.Some lf_level ->
            Option.some (index_of_lf_level state lf_level)
        | Option.None -> Option.none)
    | Option.Some _
    | Option.None ->
        Option.none

  let index_of_meta_variable state identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ( { Entry.desc =
              ( Entry.Meta_variable { meta_level }
              | Entry.Contextual_variable { meta_level } )
          ; _
          }
        , _ ) -> (
        match meta_level with
        | Option.Some meta_level -> index_of_meta_level state meta_level
        | Option.None ->
            Error.raise_at1
              (Identifier.location identifier)
              Unknown_meta_variable_index)
    | Option.Some (entry, _) ->
        Error.raise_at1
          (Identifier.location identifier)
          (Error.composite_exception2 Expected_meta_variable
             (actual_binding_exn
                (Qualified_identifier.make_simple identifier)
                entry))
    | Option.None ->
        Error.raise_at1
          (Identifier.location identifier)
          (Identifier.Unbound_identifier identifier)

  let index_of_meta_variable_opt state identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ( { Entry.desc =
              ( Entry.Meta_variable { meta_level }
              | Entry.Contextual_variable { meta_level } )
          ; _
          }
        , _ ) -> (
        match meta_level with
        | Option.Some meta_level ->
            Option.Some (index_of_meta_level state meta_level)
        | Option.None -> Option.none)
    | Option.Some _
    | Option.None ->
        Option.none

  let index_of_parameter_variable state identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ( { Entry.desc =
              ( Entry.Parameter_variable { meta_level }
              | Entry.Contextual_variable { meta_level } )
          ; _
          }
        , _ ) -> (
        match meta_level with
        | Option.Some meta_level -> index_of_meta_level state meta_level
        | Option.None ->
            Error.raise_at1
              (Identifier.location identifier)
              Unknown_parameter_variable_index)
    | Option.Some (entry, _) ->
        Error.raise_at1
          (Identifier.location identifier)
          (Error.composite_exception2 Expected_parameter_variable
             (actual_binding_exn
                (Qualified_identifier.make_simple identifier)
                entry))
    | Option.None ->
        Error.raise_at1
          (Identifier.location identifier)
          (Identifier.Unbound_identifier identifier)

  let index_of_parameter_variable_opt state identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ( { Entry.desc =
              ( Entry.Parameter_variable { meta_level }
              | Entry.Contextual_variable { meta_level } )
          ; _
          }
        , _ ) -> (
        match meta_level with
        | Option.Some meta_level ->
            Option.some (index_of_meta_level state meta_level)
        | Option.None -> Option.none)
    | Option.Some _
    | Option.None ->
        Option.none

  let index_of_substitution_variable state identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ( { Entry.desc =
              ( Entry.Substitution_variable { meta_level }
              | Entry.Contextual_variable { meta_level } )
          ; _
          }
        , _ ) -> (
        match meta_level with
        | Option.Some meta_level -> index_of_meta_level state meta_level
        | Option.None ->
            Error.raise_at1
              (Identifier.location identifier)
              Unknown_substitution_variable_index)
    | Option.Some (entry, _) ->
        Error.raise_at1
          (Identifier.location identifier)
          (Error.composite_exception2 Expected_substitution_variable
             (actual_binding_exn
                (Qualified_identifier.make_simple identifier)
                entry))
    | Option.None ->
        Error.raise_at1
          (Identifier.location identifier)
          (Identifier.Unbound_identifier identifier)

  let index_of_substitution_variable_opt state identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ( { Entry.desc =
              ( Entry.Substitution_variable { meta_level }
              | Entry.Contextual_variable { meta_level } )
          ; _
          }
        , _ ) -> (
        match meta_level with
        | Option.Some meta_level ->
            Option.some (index_of_meta_level state meta_level)
        | Option.None -> Option.none)
    | Option.Some _
    | Option.None ->
        Option.none

  let index_of_context_variable state identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ( { Entry.desc =
              ( Entry.Context_variable { meta_level }
              | Entry.Contextual_variable { meta_level } )
          ; _
          }
        , _ ) -> (
        match meta_level with
        | Option.Some meta_level -> index_of_meta_level state meta_level
        | Option.None ->
            Error.raise_at1
              (Identifier.location identifier)
              Unknown_context_variable_index)
    | Option.Some (entry, _) ->
        Error.raise_at1
          (Identifier.location identifier)
          (Error.composite_exception2 Expected_context_variable
             (actual_binding_exn
                (Qualified_identifier.make_simple identifier)
                entry))
    | Option.None ->
        Error.raise_at1
          (Identifier.location identifier)
          (Identifier.Unbound_identifier identifier)

  let index_of_context_variable_opt state identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ( { Entry.desc =
              ( Entry.Context_variable { meta_level }
              | Entry.Contextual_variable { meta_level } )
          ; _
          }
        , _ ) -> (
        match meta_level with
        | Option.Some meta_level ->
            Option.some (index_of_meta_level state meta_level)
        | Option.None -> Option.none)
    | Option.Some _
    | Option.None ->
        Option.none

  let index_of_comp_variable state identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ({ Entry.desc = Entry.Computation_variable { comp_level }; _ }, _)
      -> (
        match comp_level with
        | Option.Some comp_level -> index_of_comp_level state comp_level
        | Option.None ->
            Error.raise_at1
              (Identifier.location identifier)
              Unknown_computation_variable_index)
    | Option.Some (entry, _) ->
        Error.raise_at1
          (Identifier.location identifier)
          (Error.composite_exception2 Expected_computation_variable
             (actual_binding_exn
                (Qualified_identifier.make_simple identifier)
                entry))
    | Option.None ->
        Error.raise_at1
          (Identifier.location identifier)
          (Identifier.Unbound_identifier identifier)

  let open_namespace state identifier =
    let _entry, subtree = lookup state identifier in
    let bindings = get_current_scope_bindings state in
    Binding_tree.add_all bindings subtree

  let open_module ?location state identifier =
    match lookup state identifier with
    | { Entry.desc = Entry.Module _; _ }, _ ->
        open_namespace state identifier
    | entry, _ ->
        Error.raise_at1_opt location
          (Error.composite_exception2 Expected_module
             (actual_binding_exn identifier entry))

  let add_synonym state ?location qualified_identifier synonym =
    let entry, subtree = lookup state qualified_identifier in
    let binding_location' =
      match location with
      | Option.None -> entry.Entry.binding_location
      | Option.Some location -> location
    in
    let entry' = Entry.{ entry with binding_location = binding_location' } in
    add_binding state synonym ~subtree entry'

  let add_module_abbreviation state ?location module_identifier abbreviation
      =
    match lookup state module_identifier with
    | { Entry.desc = Entry.Module _; _ }, _ ->
        add_synonym state ?location module_identifier abbreviation
    | entry, _ ->
        Error.raise_at1
          (Qualified_identifier.location module_identifier)
          (Error.composite_exception2 Expected_module
             (actual_binding_exn module_identifier entry))

  let raise_duplicate_identifiers_exception f duplicates =
    match duplicates with
    | List1.T ((_identifier, duplicates), []) ->
        Error.raise_at
          (List2.to_list1 (List2.map Identifier.location duplicates))
          (f duplicates)
    | List1.T (x1, x2 :: xs) ->
        Error.raise_aggregate_exception
          (List2.map
             (fun (_identifier, duplicates) ->
               Error.located_exception
                 (List2.to_list1 (List2.map Identifier.location duplicates))
                 (f duplicates))
             (List2.from x1 x2 xs))

  let start_pattern state =
    let current_scope_bindings_state =
      get_current_scope_bindings_state state
    in
    let pattern_scope =
      Pattern_scope
        { pattern_bindings = create_empty_bindings ()
        ; pattern_variables_rev = []
        ; expression_bindings =
            { current_scope_bindings_state with
              bindings = Binding_tree.create ()
            }
        }
    in
    push_scope state pattern_scope;
    state.free_variables_allowed <- true

  let stop_pattern state =
    state.free_variables_allowed <- false;
    match get_current_scope state with
    | Module_scope _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid module scope" __FUNCTION__)
    | Plain_scope _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid plain scope" __FUNCTION__)
    | Pattern_scope { pattern_variables_rev; expression_bindings; _ } -> (
        ignore (pop_scope state);
        match
          Identifier.find_duplicates (List.rev pattern_variables_rev)
        with
        | Option.Some duplicates ->
            raise_duplicate_identifiers_exception
              (fun identifiers -> Duplicate_pattern_variables identifiers)
              duplicates
        | Option.None ->
            push_scope state (Plain_scope { bindings = expression_bindings })
        )

  let add_free_lf_level_variable state identifier make_entry =
    match get_current_scope state with
    | Pattern_scope scope ->
        let entry = make_entry ~lf_level:Option.none in
        scope.pattern_variables_rev <-
          identifier :: scope.pattern_variables_rev;
        Binding_tree.add_toplevel identifier entry
          scope.expression_bindings.bindings
    | Plain_scope _
    | Module_scope _ ->
        ()

  let add_free_meta_level_variable state identifier make_entry =
    match get_current_scope state with
    | Pattern_scope scope ->
        let entry = make_entry ~meta_level:Option.none in
        scope.pattern_variables_rev <-
          identifier :: scope.pattern_variables_rev;
        Binding_tree.add_toplevel identifier entry
          scope.pattern_bindings.bindings;
        Binding_tree.add_toplevel identifier entry
          scope.expression_bindings.bindings
    | Plain_scope _
    | Module_scope _ ->
        ()

  let add_free_comp_level_variable state identifier make_entry =
    match get_current_scope state with
    | Pattern_scope scope ->
        let entry =
          make_entry
            ~comp_level:
              (Option.some
                 (Comp_level.of_int
                    scope.expression_bindings.comp_context_size))
        in
        scope.pattern_variables_rev <-
          identifier :: scope.pattern_variables_rev;
        Binding_tree.add_toplevel identifier entry
          scope.expression_bindings.bindings;
        scope.expression_bindings.comp_context_size <-
          scope.expression_bindings.comp_context_size + 1
    | Plain_scope _
    | Module_scope _ ->
        ()

  let add_free_lf_variable state ?location identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ({ Entry.desc = Entry.Lf_variable { lf_level = Option.None }; _ }, _)
      ->
        (* [identifier] is known to be a free LF variable because its LF
           level is unknown, so we do not signal it as an illegal free
           variable. *)
        ()
    | _ ->
        if state.free_variables_allowed then
          add_free_lf_level_variable state identifier
            (Entry.make_lf_variable_entry ?location identifier)
        else
          Error.raise_at1
            (Identifier.location identifier)
            Illegal_free_lf_variable

  let add_free_meta_variable state ?location identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ( { Entry.desc = Entry.Meta_variable { meta_level = Option.None }; _ }
        , _ ) ->
        (* [identifier] is known to be a free meta-variable because its meta
           level is unknown, so we do not signal it as an illegal free
           variable. *)
        ()
    | _ ->
        if state.free_variables_allowed then
          add_free_meta_level_variable state identifier
            (Entry.make_meta_variable_entry ?location identifier)
        else
          Error.raise_at1
            (Identifier.location identifier)
            Illegal_free_meta_variable

  let add_free_parameter_variable state ?location identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ( { Entry.desc = Entry.Parameter_variable { meta_level = Option.None }
          ; _
          }
        , _ ) ->
        (* [identifier] is known to be a free parameter variable because its
           meta level is unknown, so we do not signal it as an illegal free
           variable. *)
        ()
    | _ ->
        if state.free_variables_allowed then
          add_free_meta_level_variable state identifier
            (Entry.make_parameter_variable_entry ?location identifier)
        else
          Error.raise_at1
            (Identifier.location identifier)
            Illegal_free_parameter_variable

  let add_free_substitution_variable state ?location identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ( { Entry.desc =
              Entry.Substitution_variable { meta_level = Option.None }
          ; _
          }
        , _ ) ->
        (* [identifier] is known to be a free substitution variable because
           its meta level is unknown, so we do not signal it as an illegal
           free variable. *)
        ()
    | _ ->
        if state.free_variables_allowed then
          add_free_meta_level_variable state identifier
            (Entry.make_substitution_variable_entry ?location identifier)
        else
          Error.raise_at1
            (Identifier.location identifier)
            Illegal_free_substitution_variable

  let add_free_context_variable state ?location identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ( { Entry.desc = Entry.Context_variable { meta_level = Option.None }
          ; _
          }
        , _ ) ->
        (* [identifier] is known to be a free context variable because its
           meta level is unknown, so we do not signal it as an illegal free
           variable. *)
        ()
    | _ ->
        if state.free_variables_allowed then
          add_free_meta_level_variable state identifier
            (Entry.make_context_variable_entry ?location identifier)
        else
          Error.raise_at1
            (Identifier.location identifier)
            Illegal_free_context_variable

  let add_computation_pattern_variable state ?location identifier =
    match lookup_toplevel_opt state identifier with
    | Option.Some
        ( { Entry.desc =
              Entry.Computation_variable { comp_level = Option.None }
          ; _
          }
        , _ ) ->
        (* [identifier] is known to be a free computationn variable because
           its computation level is unknown, so we do not signal it as an
           illegal free variable. *)
        ()
    | _ ->
        if state.free_variables_allowed then
          add_free_comp_level_variable state identifier
            (Entry.make_computation_variable_entry ?location identifier)
        else
          Error.raise_at1
            (Identifier.location identifier)
            Illegal_free_computation_variable

  let add_bound_pattern_meta_level_variable state ?location identifier
      make_entry =
    match get_current_scope state with
    | Pattern_scope scope ->
        let pattern_entry =
          make_entry ?location identifier
            ~meta_level:
              (Option.some
                 (Meta_level.of_int scope.pattern_bindings.meta_context_size))
        in
        let expression_entry =
          make_entry ?location identifier
            ~meta_level:
              (Option.some
                 (Meta_level.of_int
                    scope.expression_bindings.meta_context_size))
        in
        Binding_tree.add_toplevel identifier pattern_entry
          scope.pattern_bindings.bindings;
        scope.pattern_bindings.meta_context_size <-
          scope.pattern_bindings.meta_context_size + 1;
        scope.pattern_variables_rev <-
          identifier :: scope.pattern_variables_rev;
        Binding_tree.add_toplevel identifier expression_entry
          scope.expression_bindings.bindings;
        scope.expression_bindings.meta_context_size <-
          scope.expression_bindings.meta_context_size + 1
    | Plain_scope _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid plain scope" __FUNCTION__)
    | Module_scope _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid module scope" __FUNCTION__)

  let add_bound_pattern_meta_variable state ?location identifier =
    add_bound_pattern_meta_level_variable state ?location identifier
      Entry.make_meta_variable_entry

  let add_bound_pattern_parameter_variable state ?location identifier =
    add_bound_pattern_meta_level_variable state ?location identifier
      Entry.make_parameter_variable_entry

  let add_bound_pattern_substitution_variable state ?location identifier =
    add_bound_pattern_meta_level_variable state ?location identifier
      Entry.make_substitution_variable_entry

  let add_bound_pattern_context_variable state ?location identifier =
    add_bound_pattern_meta_level_variable state ?location identifier
      Entry.make_context_variable_entry

  let with_bound_lf_variable state ?location identifier m =
    add_lf_variable state ?location identifier;
    let x = m state in
    remove_lf_binding state identifier;
    x

  let with_bound_meta_variable state ?location identifier m =
    add_meta_variable state ?location identifier;
    let x = m state in
    remove_meta_binding state identifier;
    x

  let with_bound_parameter_variable state ?location identifier m =
    add_parameter_variable state ?location identifier;
    let x = m state in
    remove_meta_binding state identifier;
    x

  let with_bound_substitution_variable state ?location identifier m =
    add_substitution_variable state ?location identifier;
    let x = m state in
    remove_meta_binding state identifier;
    x

  let with_bound_context_variable state ?location identifier m =
    add_context_variable state ?location identifier;
    let x = m state in
    remove_meta_binding state identifier;
    x

  let with_bound_contextual_variable state ?location identifier m =
    add_contextual_variable state ?location identifier;
    let x = m state in
    remove_meta_binding state identifier;
    x

  let with_bound_comp_variable state ?location identifier m =
    add_comp_variable state ?location identifier;
    let x = m state in
    remove_comp_binding state identifier;
    x

  let with_bound_pattern_meta_variable state ?location identifier m =
    add_bound_pattern_meta_variable state ?location identifier;
    let x = m state in
    remove_meta_binding state identifier;
    x

  let with_bound_pattern_parameter_variable state ?location identifier m =
    add_bound_pattern_parameter_variable state ?location identifier;
    let x = m state in
    remove_meta_binding state identifier;
    x

  let with_bound_pattern_substitution_variable state ?location identifier m =
    add_bound_pattern_substitution_variable state ?location identifier;
    let x = m state in
    remove_meta_binding state identifier;
    x

  let with_bound_pattern_context_variable state ?location identifier m =
    add_bound_pattern_context_variable state ?location identifier;
    let x = m state in
    remove_meta_binding state identifier;
    x

  let with_shifted_lf_context state m =
    shift_lf_context state;
    let x = m state in
    unshift_lf_context state;
    x

  let with_shifted_meta_context state m =
    shift_meta_context state;
    let x = m state in
    unshift_meta_context state;
    x

  let with_shifted_comp_context state m =
    shift_comp_context state;
    let x = m state in
    unshift_comp_context state;
    x

  let add_lf_type_constant state ?location identifier cid =
    add_declaration state identifier
      (Entry.make_lf_type_constant_entry ?location identifier cid)

  let add_lf_term_constant state ?location identifier cid =
    add_declaration state identifier
      (Entry.make_lf_term_constant_entry ?location identifier cid)

  let add_schema_constant state ?location identifier cid =
    add_declaration state identifier
      (Entry.make_schema_constant_entry ?location identifier cid)

  let add_inductive_computation_type_constant state ?location identifier cid
      =
    add_declaration state identifier
      (Entry.make_computation_inductive_type_constant_entry ?location
         identifier cid)

  let add_stratified_computation_type_constant state ?location identifier cid
      =
    add_declaration state identifier
      (Entry.make_computation_stratified_type_constant_entry ?location
         identifier cid)

  let add_coinductive_computation_type_constant state ?location identifier
      cid =
    add_declaration state identifier
      (Entry.make_computation_coinductive_type_constant_entry ?location
         identifier cid)

  let add_abbreviation_computation_type_constant state ?location identifier
      cid =
    add_declaration state identifier
      (Entry.make_computation_abbreviation_type_constant_entry ?location
         identifier cid)

  let add_computation_term_constructor state ?location identifier cid =
    add_declaration state identifier
      (Entry.make_computation_term_constructor_entry ?location identifier cid)

  let add_computation_term_destructor state ?location identifier cid =
    add_declaration state identifier
      (Entry.make_computation_term_destructor_entry ?location identifier cid)

  let add_program_constant state ?location identifier cid =
    add_declaration state identifier
      (Entry.make_program_constant_entry ?location identifier cid)

  let add_module state ?location identifier cid m =
    start_module state;
    let x = m state in
    stop_module state ?location identifier cid;
    x

  let with_scope state m =
    push_new_plain_scope state;
    let x = m state in
    ignore (pop_scope state);
    x

  let with_parent_scope state m =
    let scope = pop_scope state in
    let x = with_scope state m in
    push_scope state scope;
    x

  let with_free_variables_as_pattern_variables state ~pattern ~expression =
    start_pattern state;
    let pattern' = pattern state in
    stop_pattern state;
    let expression' = expression state pattern' in
    ignore (pop_scope state);
    expression'

  let allow_free_variables state m =
    let free_variables_state = are_free_variables_allowed state in
    enable_free_variables state;
    let x = m state in
    set_free_variables_allowed_state state free_variables_state;
    x

  let disallow_free_variables state m =
    let free_variables_state = are_free_variables_allowed state in
    disable_free_variables state;
    let x = m state in
    set_free_variables_allowed_state state free_variables_state;
    x

  let traverse_option state m x_opt =
    match x_opt with
    | Option.None -> Option.none
    | Option.Some x ->
        let y = m state x in
        Option.some y

  let rec traverse_list state f l =
    match l with
    | [] -> []
    | x :: xs ->
        let y = f state x in
        let ys = traverse_list state f xs in
        y :: ys

  let traverse_list1 state f (List1.T (x, xs)) =
    let y = f state x in
    let ys = traverse_list state f xs in
    List1.from y ys

  let traverse_list2 state f (List2.T (x1, x2, xs)) =
    let y1 = f state x1 in
    let y2 = f state x2 in
    let ys = traverse_list state f xs in
    List2.from y1 y2 ys
end
