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
        Format.dprintf "%a" Format.pp_print_text
          "Illegal duplicate pattern variables."
    | exn -> Error.raise_unsupported_exception_printing exn)

module type INDEXING_STATE = sig
  include State.STATE

  val fresh_identifier : Identifier.t t

  val fresh_identifier_opt : Identifier.t Option.t -> Identifier.t t

  val index_of_lf_typ_constant : Qualified_identifier.t -> Id.cid_typ t

  val index_of_lf_term_constant : Qualified_identifier.t -> Id.cid_term t

  val index_of_inductive_comp_constant :
    Qualified_identifier.t -> Id.cid_comp_typ t

  val index_of_stratified_comp_constant :
    Qualified_identifier.t -> Id.cid_comp_typ t

  val index_of_coinductive_comp_constant :
    Qualified_identifier.t -> Id.cid_comp_cotyp t

  val index_of_abbreviation_comp_constant :
    Qualified_identifier.t -> Id.cid_comp_typdef t

  val index_of_schema_constant : Qualified_identifier.t -> Id.cid_schema t

  val index_of_comp_constructor :
    Qualified_identifier.t -> Id.cid_comp_const t

  val index_of_comp_destructor : Qualified_identifier.t -> Id.cid_comp_dest t

  val index_of_comp_program : Qualified_identifier.t -> Id.cid_prog t

  val index_of_lf_variable : Identifier.t -> Id.offset t

  val index_of_lf_variable_opt : Identifier.t -> Id.offset Option.t t

  val index_of_meta_variable : Identifier.t -> Id.offset t

  val index_of_meta_variable_opt : Identifier.t -> Id.offset Option.t t

  val index_of_parameter_variable : Identifier.t -> Id.offset t

  val index_of_parameter_variable_opt : Identifier.t -> Id.offset Option.t t

  val index_of_substitution_variable : Identifier.t -> Id.offset t

  val index_of_substitution_variable_opt :
    Identifier.t -> Id.offset Option.t t

  val index_of_context_variable : Identifier.t -> Id.offset t

  val index_of_context_variable_opt : Identifier.t -> Id.offset Option.t t

  val index_of_comp_variable : Identifier.t -> Id.offset t

  val with_bound_lf_variable :
    ?location:Location.t -> Identifier.t -> 'a t -> 'a t

  val with_bound_meta_variable :
    ?location:Location.t -> Identifier.t -> 'a t -> 'a t

  val with_bound_parameter_variable :
    ?location:Location.t -> Identifier.t -> 'a t -> 'a t

  val with_bound_substitution_variable :
    ?location:Location.t -> Identifier.t -> 'a t -> 'a t

  val with_bound_context_variable :
    ?location:Location.t -> Identifier.t -> 'a t -> 'a t

  val with_bound_contextual_variable :
    ?location:Location.t -> Identifier.t -> 'a t -> 'a t

  val with_bound_comp_variable :
    ?location:Location.t -> Identifier.t -> 'a t -> 'a t

  val with_shifted_lf_context : 'a t -> 'a t

  val with_shifted_meta_context : 'a t -> 'a t

  val with_shifted_comp_context : 'a t -> 'a t

  val add_lf_type_constant :
    ?location:Location.t -> Identifier.t -> Id.cid_typ -> Unit.t t

  val add_lf_term_constant :
    ?location:Location.t -> Identifier.t -> Id.cid_term -> Unit.t t

  val add_schema_constant :
    ?location:Location.t -> Identifier.t -> Id.cid_schema -> Unit.t t

  val add_inductive_computation_type_constant :
    ?location:Location.t -> Identifier.t -> Id.cid_comp_typ -> Unit.t t

  val add_stratified_computation_type_constant :
    ?location:Location.t -> Identifier.t -> Id.cid_comp_typ -> Unit.t t

  val add_coinductive_computation_type_constant :
    ?location:Location.t -> Identifier.t -> Id.cid_comp_cotyp -> Unit.t t

  val add_abbreviation_computation_type_constant :
    ?location:Location.t -> Identifier.t -> Id.cid_comp_typdef -> Unit.t t

  val add_computation_term_constructor :
    ?location:Location.t -> Identifier.t -> Id.cid_comp_const -> Unit.t t

  val add_computation_term_destructor :
    ?location:Location.t -> Identifier.t -> Id.cid_comp_dest -> Unit.t t

  val add_program_constant :
    ?location:Location.t -> Identifier.t -> Id.cid_prog -> Unit.t t

  val add_module :
    ?location:Location.t -> Identifier.t -> Id.module_id -> 'a t -> 'a t

  val open_module :
    ?location:Location.t -> Qualified_identifier.t -> Unit.t t

  val add_module_abbreviation :
       ?location:Location.t
    -> Qualified_identifier.t
    -> Identifier.t
    -> Unit.t t

  val with_scope : 'a t -> 'a t

  val with_parent_scope : 'a t -> 'a t

  val with_free_variables_as_pattern_variables :
    pattern:'a t -> expression:('a -> 'b t) -> 'b t

  val add_computation_pattern_variable :
    ?location:Location.t -> Identifier.t -> Unit.t t

  val add_free_lf_variable : ?location:Location.t -> Identifier.t -> Unit.t t

  val add_free_meta_variable :
    ?location:Location.t -> Identifier.t -> Unit.t t

  val add_free_parameter_variable :
    ?location:Location.t -> Identifier.t -> Unit.t t

  val add_free_substitution_variable :
    ?location:Location.t -> Identifier.t -> Unit.t t

  val add_free_context_variable :
    ?location:Location.t -> Identifier.t -> Unit.t t

  val with_bound_pattern_meta_variable :
    ?location:Location.t -> Identifier.t -> 'a t -> 'a t

  val with_bound_pattern_parameter_variable :
    ?location:Location.t -> Identifier.t -> 'a t -> 'a t

  val with_bound_pattern_substitution_variable :
    ?location:Location.t -> Identifier.t -> 'a t -> 'a t

  val with_bound_pattern_context_variable :
    ?location:Location.t -> Identifier.t -> 'a t -> 'a t

  val allow_free_variables : 'a t -> 'a t

  val disallow_free_variables : 'a t -> 'a t

  val add_all_bvar_store : Store.BVar.t -> Unit.t t

  val add_all_cvar_store : Store.CVar.t -> Unit.t t

  val add_all_var_store : Store.Var.t -> Unit.t t

  val add_all_mctx : Synint.LF.mctx -> Unit.t t

  val add_all_gctx : Synint.Comp.gctx -> Unit.t t
end

module type LEVEL = sig
  type t

  val of_int : Int.t -> t

  val to_int : t -> Int.t
end

module Level = struct
  type t = int

  let of_int = Fun.id

  let to_int = Fun.id
end

module Lf_level : LEVEL = Level

module Meta_level : LEVEL = Level

module Comp_level : LEVEL = Level

module Persistent_indexing_state = struct
  module Binding_tree = Binding_tree.Hamt

  module Entry = struct
    type t =
      { binding_location : Location.t
      ; desc : desc
      }

    and desc =
      | Lf_variable of
          { lf_level : Lf_level.t Option.t
                (** The de Bruijn level of the LF variable. If it is
                    [Option.None], then this is a free variable, whose level
                    is unknown. *)
          }
      | Meta_variable of
          { meta_level : Meta_level.t Option.t
                (** The de Bruijn level of the meta-variable. If it is
                    [Option.None], then this is a free variable, whose level
                    is unknown. *)
          }
      | Parameter_variable of
          { meta_level : Meta_level.t Option.t
                (** The de Bruijn level of the parameter variable. If it is
                    [Option.None], then this is a free variable, whose level
                    is unknown. *)
          }
      | Substitution_variable of
          { meta_level : Meta_level.t Option.t
                (** The de Bruijn level of the substitution variable. If it
                    is [Option.None], then this is a free variable, whose
                    level is unknown. *)
          }
      | Context_variable of
          { meta_level : Meta_level.t Option.t
                (** The de Bruijn level of the context variable. If it is
                    [Option.None], then this is a free variable, whose level
                    is unknown. *)
          }
      | Contextual_variable of
          { meta_level : Meta_level.t Option.t
                (** The de Bruijn level of the contextual variable. If it is
                    [Option.None], then this is a free variable, whose level
                    is unknown. *)
          }
          (** A contextual variable is either a meta, parameter,
              substitution, or context variable. Contextual variables are
              introduced ambiguously by [mlam]-expressions. *)
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
      | Computation_abbreviation_type_constant of
          { cid : Id.cid_comp_typdef }
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

    let[@inline] make_lf_variable_entry ?location identifier lf_level =
      make_entry ?location identifier (Lf_variable { lf_level })

    let[@inline] make_meta_variable_entry ?location identifier meta_level =
      make_entry ?location identifier (Meta_variable { meta_level })

    let[@inline] make_parameter_variable_entry ?location identifier
        meta_level =
      make_entry ?location identifier (Parameter_variable { meta_level })

    let[@inline] make_substitution_variable_entry ?location identifier
        meta_level =
      make_entry ?location identifier (Substitution_variable { meta_level })

    let[@inline] make_context_variable_entry ?location identifier meta_level
        =
      make_entry ?location identifier (Context_variable { meta_level })

    let[@inline] make_contextual_variable_entry ?location identifier
        meta_level =
      make_entry ?location identifier (Contextual_variable { meta_level })

    let[@inline] make_computation_variable_entry ?location identifier
        comp_level =
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

  type bindings_state =
    { bindings : Entry.t Binding_tree.t
    ; lf_context_size : Int.t
          (** The length of [cPsi], the context of LF-bound variables. *)
    ; meta_context_size : Int.t
          (** The length of [cD], the context of meta-level variables. *)
    ; comp_context_size : Int.t
          (** The length of [cG], the context of computation-level variables. *)
    }

  type substate =
    | Scope_state of
        { bindings : bindings_state
        ; parent : substate Option.t
        }
    | Module_state of
        { bindings : bindings_state
        ; declarations : Entry.t Binding_tree.t
        ; parent : substate Option.t
        }
    | Pattern_state of
        { pattern_bindings : bindings_state
        ; inner_pattern_bindings : Entry.t List1.t Identifier.Hamt.t
        ; pattern_variables_rev : Identifier.t List.t
        ; expression_bindings : bindings_state
        }

  type state =
    { substate : substate
    ; free_variables_allowed : Bool.t
    ; generated_fresh_variables_count : Int.t
    }

  include (
    State.Make (struct
      type t = state
    end) :
      State.STATE with type state := state)

  let get_and_increment_generated_fresh_variables_count =
    let* state = get in
    let i = state.generated_fresh_variables_count in
    let* () =
      put
        { state with
          generated_fresh_variables_count =
            state.generated_fresh_variables_count + 1
        }
    in
    return i

  let fresh_identifier =
    let* i = get_and_increment_generated_fresh_variables_count in
    (* ['"'] is a reserved character, so ["\"i1"], ["\"i2"], ..., etc. are
       syntactically invalid identifiers, which are guarenteed to not clash
       with free variables *)
    return (Identifier.make ("\"i" ^ string_of_int i))

  let fresh_identifier_opt = function
    | Option.Some identifier -> return identifier
    | Option.None -> fresh_identifier

  let[@inline] set_substate substate =
    modify (fun state -> { state with substate })

  let get_substate =
    let* state = get in
    return state.substate

  let[@inline] modify_substate f =
    let* substate = get_substate in
    let substate' = f substate in
    set_substate substate'

  let[@inline] set_substate_bindings bindings = function
    | Scope_state state -> Scope_state { state with bindings }
    | Module_state state -> Module_state { state with bindings }
    | Pattern_state state ->
        Pattern_state { state with pattern_bindings = bindings }

  let get_substate_bindings = function
    | Scope_state state -> state.bindings
    | Module_state state -> state.bindings
    | Pattern_state state -> state.pattern_bindings

  let[@inline] set_bindings_state bindings =
    modify_substate (set_substate_bindings bindings)

  let get_bindings_state = get_substate $> get_substate_bindings

  let[@inline] modify_bindings_state f =
    let* bindings_state = get_bindings_state in
    let bindings_state' = f bindings_state in
    set_bindings_state bindings_state'

  let set_bindings bindings =
    modify_bindings_state (fun state -> { state with bindings })

  let get_bindings =
    let* bindings_state = get_bindings_state in
    return bindings_state.bindings

  let[@inline] modify_bindings f =
    let* bindings = get_bindings in
    let bindings' = f bindings in
    set_bindings bindings'

  let get_lf_context_size =
    let* bindings_state = get_bindings_state in
    return bindings_state.lf_context_size

  let[@inline] set_lf_context_size lf_context_size =
    modify_bindings_state (fun state -> { state with lf_context_size })

  let[@inline] modify_lf_context_size f =
    let* lf_context_size = get_lf_context_size in
    let lf_context_size' = f lf_context_size in
    set_lf_context_size lf_context_size'

  let get_meta_context_size =
    let* bindings_state = get_bindings_state in
    return bindings_state.meta_context_size

  let[@inline] set_meta_context_size meta_context_size =
    modify_bindings_state (fun state -> { state with meta_context_size })

  let[@inline] modify_meta_context_size f =
    let* meta_context_size = get_meta_context_size in
    let meta_context_size' = f meta_context_size in
    set_meta_context_size meta_context_size'

  let get_comp_context_size =
    let* bindings_state = get_bindings_state in
    return bindings_state.comp_context_size

  let[@inline] set_comp_context_size comp_context_size =
    modify_bindings_state (fun state -> { state with comp_context_size })

  let[@inline] modify_comp_context_size f =
    let* comp_context_size = get_comp_context_size in
    let comp_context_size' = f comp_context_size in
    set_comp_context_size comp_context_size'

  let lookup qualified_identifier =
    let* bindings = get_bindings in
    try
      let entry, _subtree =
        Binding_tree.lookup qualified_identifier bindings
      in
      return entry
    with
    | ( Binding_tree.Unbound_identifier _ | Binding_tree.Unbound_namespace _
      | Binding_tree.Unbound_qualified_identifier _ ) as cause ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          cause

  let lookup_with_subtree qualified_identifier =
    let* bindings = get_bindings in
    try return (Binding_tree.lookup qualified_identifier bindings) with
    | ( Binding_tree.Unbound_identifier _ | Binding_tree.Unbound_namespace _
      | Binding_tree.Unbound_qualified_identifier _ ) as cause ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          cause

  let lookup_toplevel identifier =
    get_substate >>= function
    | Pattern_state { pattern_bindings; inner_pattern_bindings; _ } -> (
        try
          let entry, _subtree =
            Binding_tree.lookup_toplevel_filter identifier
              (fun entry -> Bool.not (Entry.is_variable entry))
              pattern_bindings.bindings
          in
          return entry
        with
        | Binding_tree.Unbound_identifier _ as cause -> (
            match
              Identifier.Hamt.find_opt identifier inner_pattern_bindings
            with
            | Option.Some (List1.T (entry, _)) -> return entry
            | Option.None ->
                Error.raise_at1 (Identifier.location identifier) cause))
    | Module_state _
    | Scope_state _ ->
        let* bindings = get_bindings in
        let entry, _subtree =
          Binding_tree.lookup_toplevel identifier bindings
        in
        return entry

  let lookup_toplevel_opt identifier =
    try_catch
      (lazy (lookup_toplevel identifier $> Option.some))
      ~on_exn:(fun _cause -> return Option.none)

  let actual_binding_exn = Entry.actual_binding_exn

  let index_of_lf_typ_constant qualified_identifier =
    lookup qualified_identifier $> function
    | { Entry.desc = Entry.Lf_type_constant { cid }; _ } -> cid
    | entry ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2 Expected_lf_typ_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_lf_term_constant qualified_identifier =
    lookup qualified_identifier $> function
    | { Entry.desc = Entry.Lf_term_constant { cid }; _ } -> cid
    | entry ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2 Expected_lf_term_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_inductive_comp_constant qualified_identifier =
    lookup qualified_identifier $> function
    | { Entry.desc = Entry.Computation_inductive_type_constant { cid }; _ }
      ->
        cid
    | entry ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2
             Expected_computation_inductive_type_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_stratified_comp_constant qualified_identifier =
    lookup qualified_identifier $> function
    | { Entry.desc = Entry.Computation_stratified_type_constant { cid }; _ }
      ->
        cid
    | entry ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2
             Expected_computation_stratified_type_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_coinductive_comp_constant qualified_identifier =
    lookup qualified_identifier $> function
    | { Entry.desc = Entry.Computation_coinductive_type_constant { cid }; _ }
      ->
        cid
    | entry ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2
             Expected_computation_coinductive_type_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_abbreviation_comp_constant qualified_identifier =
    lookup qualified_identifier $> function
    | { Entry.desc = Entry.Computation_abbreviation_type_constant { cid }
      ; _
      } ->
        cid
    | entry ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2
             Expected_computation_abbreviation_type_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_schema_constant qualified_identifier =
    lookup qualified_identifier $> function
    | { Entry.desc = Entry.Schema_constant { cid }; _ } -> cid
    | entry ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2 Expected_schema_constant
             (actual_binding_exn qualified_identifier entry))

  let index_of_comp_constructor qualified_identifier =
    lookup qualified_identifier $> function
    | { Entry.desc = Entry.Computation_term_constructor { cid }; _ } -> cid
    | entry ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2 Expected_computation_term_constructor
             (actual_binding_exn qualified_identifier entry))

  let index_of_comp_destructor qualified_identifier =
    lookup qualified_identifier $> function
    | { Entry.desc = Entry.Computation_term_destructor { cid }; _ } -> cid
    | entry ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2 Expected_computation_term_destructor
             (actual_binding_exn qualified_identifier entry))

  let index_of_comp_program qualified_identifier =
    lookup qualified_identifier $> function
    | { Entry.desc = Entry.Program_constant { cid }; _ } -> cid
    | entry ->
        Error.raise_at1
          (Qualified_identifier.location qualified_identifier)
          (Error.composite_exception2 Expected_program_constant
             (actual_binding_exn qualified_identifier entry))

  let[@inline] index_of_variable_opt index_of_variable identifier =
    try_catch
      (lazy (index_of_variable identifier $> Option.some))
      ~on_exn:(fun _cause -> return Option.none)

  let[@inline] index_of_lf_level lf_level =
    let* lf_context_size = get_lf_context_size in
    return (lf_context_size - Lf_level.to_int lf_level)

  let[@inline] index_of_meta_level meta_level =
    let* meta_context_size = get_meta_context_size in
    return (meta_context_size - Meta_level.to_int meta_level)

  let[@inline] index_of_comp_level comp_level =
    let* comp_context_size = get_comp_context_size in
    return (comp_context_size - Comp_level.to_int comp_level)

  let index_of_lf_variable identifier =
    lookup_toplevel identifier >>= function
    | { Entry.desc = Entry.Lf_variable { lf_level }; _ } -> (
        match lf_level with
        | Option.Some lf_level -> index_of_lf_level lf_level
        | Option.None ->
            Error.raise_at1
              (Identifier.location identifier)
              Unknown_lf_variable_index)
    | entry ->
        Error.raise_at1
          (Identifier.location identifier)
          (Error.composite_exception2 Expected_lf_variable
             (actual_binding_exn
                (Qualified_identifier.make_simple identifier)
                entry))

  let index_of_lf_variable_opt = index_of_variable_opt index_of_lf_variable

  let index_of_meta_variable identifier =
    lookup_toplevel identifier >>= function
    | { Entry.desc =
          ( Entry.Meta_variable { meta_level }
          | Entry.Contextual_variable { meta_level } )
      ; _
      } -> (
        match meta_level with
        | Option.Some meta_level -> index_of_meta_level meta_level
        | Option.None ->
            Error.raise_at1
              (Identifier.location identifier)
              Unknown_meta_variable_index)
    | entry ->
        Error.raise_at1
          (Identifier.location identifier)
          (Error.composite_exception2 Expected_meta_variable
             (actual_binding_exn
                (Qualified_identifier.make_simple identifier)
                entry))

  let index_of_meta_variable_opt =
    index_of_variable_opt index_of_meta_variable

  let index_of_parameter_variable identifier =
    lookup_toplevel identifier >>= function
    | { Entry.desc =
          ( Entry.Parameter_variable { meta_level }
          | Entry.Contextual_variable { meta_level } )
      ; _
      } -> (
        match meta_level with
        | Option.Some meta_level -> index_of_meta_level meta_level
        | Option.None ->
            Error.raise_at1
              (Identifier.location identifier)
              Unknown_parameter_variable_index)
    | entry ->
        Error.raise_at1
          (Identifier.location identifier)
          (Error.composite_exception2 Expected_parameter_variable
             (actual_binding_exn
                (Qualified_identifier.make_simple identifier)
                entry))

  let index_of_parameter_variable_opt =
    index_of_variable_opt index_of_parameter_variable

  let index_of_substitution_variable identifier =
    lookup_toplevel identifier >>= function
    | { Entry.desc =
          ( Entry.Substitution_variable { meta_level }
          | Entry.Contextual_variable { meta_level } )
      ; _
      } -> (
        match meta_level with
        | Option.Some meta_level -> index_of_meta_level meta_level
        | Option.None ->
            Error.raise_at1
              (Identifier.location identifier)
              Unknown_substitution_variable_index)
    | entry ->
        Error.raise_at1
          (Identifier.location identifier)
          (Error.composite_exception2 Expected_substitution_variable
             (actual_binding_exn
                (Qualified_identifier.make_simple identifier)
                entry))

  let index_of_substitution_variable_opt =
    index_of_variable_opt index_of_substitution_variable

  let index_of_context_variable identifier =
    lookup_toplevel identifier >>= function
    | { Entry.desc =
          ( Entry.Context_variable { meta_level }
          | Entry.Contextual_variable { meta_level } )
      ; _
      } -> (
        match meta_level with
        | Option.Some meta_level -> index_of_meta_level meta_level
        | Option.None ->
            Error.raise_at1
              (Identifier.location identifier)
              Unknown_context_variable_index)
    | entry ->
        Error.raise_at1
          (Identifier.location identifier)
          (Error.composite_exception2 Expected_context_variable
             (actual_binding_exn
                (Qualified_identifier.make_simple identifier)
                entry))

  let index_of_context_variable_opt =
    index_of_variable_opt index_of_context_variable

  let index_of_comp_variable identifier =
    lookup_toplevel identifier >>= function
    | { Entry.desc = Entry.Computation_variable { comp_level }; _ } -> (
        match comp_level with
        | Option.Some comp_level -> index_of_comp_level comp_level
        | Option.None ->
            Error.raise_at1
              (Identifier.location identifier)
              Unknown_computation_variable_index)
    | entry ->
        Error.raise_at1
          (Identifier.location identifier)
          (Error.composite_exception2 Expected_computation_variable
             (actual_binding_exn
                (Qualified_identifier.make_simple identifier)
                entry))

  let with_free_variables_state ~free_variables_allowed m =
    let* state = get in
    let* () = put { state with free_variables_allowed } in
    let* x = m in
    let* state' = get in
    let* () =
      put
        { state' with free_variables_allowed = state.free_variables_allowed }
    in
    return x

  let shift_lf_context = modify_lf_context_size (fun size -> size + 1)

  let unshift_lf_context = modify_lf_context_size (fun size -> size - 1)

  let[@inline] with_shifted_lf_context m =
    shift_lf_context &> m <& unshift_lf_context

  let shift_meta_context = modify_meta_context_size (fun size -> size + 1)

  let unshift_meta_context = modify_meta_context_size (fun size -> size - 1)

  let[@inline] with_shifted_meta_context m =
    shift_meta_context &> m <& unshift_meta_context

  let shift_comp_context = modify_comp_context_size (fun size -> size + 1)

  let unshift_comp_context = modify_comp_context_size (fun size -> size - 1)

  let[@inline] with_shifted_comp_context m =
    shift_comp_context &> m <& unshift_comp_context

  let with_bindings_state_checkpoint m =
    let* bindings_state = get_bindings_state in
    let* x = m in
    let* () = set_bindings_state bindings_state in
    return x

  let push_entry identifier entry bindings =
    let entries' =
      match Identifier.Hamt.find_opt identifier bindings with
      | Option.None -> List1.singleton entry
      | Option.Some entries -> List1.cons entry entries
    in
    Identifier.Hamt.add identifier entries' bindings

  let add_lf_level_variable identifier make_entry =
    get_substate >>= function
    | Pattern_state substate ->
        let entry =
          make_entry
            (Option.some
               (Lf_level.of_int substate.pattern_bindings.lf_context_size))
        in
        let lf_context_size' =
          substate.pattern_bindings.lf_context_size + 1
        in
        let bindings' =
          Binding_tree.add_toplevel identifier entry
            substate.pattern_bindings.bindings
        in
        set_substate
          (Pattern_state
             { substate with
               pattern_bindings =
                 { substate.pattern_bindings with
                   bindings = bindings'
                 ; lf_context_size = lf_context_size'
                 }
             ; inner_pattern_bindings =
                 push_entry identifier entry substate.inner_pattern_bindings
             })
    | Scope_state _
    | Module_state _ ->
        modify_bindings_state (fun state ->
            let entry =
              make_entry
                (Option.some (Lf_level.of_int state.lf_context_size))
            in
            let lf_context_size' = state.lf_context_size + 1 in
            let bindings' =
              Binding_tree.add_toplevel identifier entry state.bindings
            in
            { state with
              bindings = bindings'
            ; lf_context_size = lf_context_size'
            })

  let add_meta_level_variable identifier make_entry =
    get_substate >>= function
    | Pattern_state substate ->
        let entry =
          make_entry
            (Option.some
               (Meta_level.of_int substate.pattern_bindings.meta_context_size))
        in
        let meta_context_size' =
          substate.pattern_bindings.meta_context_size + 1
        in
        let bindings' =
          Binding_tree.add_toplevel identifier entry
            substate.pattern_bindings.bindings
        in
        set_substate
          (Pattern_state
             { substate with
               pattern_bindings =
                 { substate.pattern_bindings with
                   bindings = bindings'
                 ; meta_context_size = meta_context_size'
                 }
             ; inner_pattern_bindings =
                 push_entry identifier entry substate.inner_pattern_bindings
             })
    | Scope_state _
    | Module_state _ ->
        modify_bindings_state (fun state ->
            let entry =
              make_entry
                (Option.some (Meta_level.of_int state.meta_context_size))
            in
            let meta_context_size' = state.meta_context_size + 1 in
            let bindings' =
              Binding_tree.add_toplevel identifier entry state.bindings
            in
            { state with
              bindings = bindings'
            ; meta_context_size = meta_context_size'
            })

  let add_comp_level_variable identifier make_entry =
    get_substate >>= function
    | Pattern_state substate ->
        let entry =
          make_entry
            (Option.some
               (Comp_level.of_int substate.pattern_bindings.comp_context_size))
        in
        let comp_context_size' =
          substate.pattern_bindings.comp_context_size + 1
        in
        let bindings' =
          Binding_tree.add_toplevel identifier entry
            substate.pattern_bindings.bindings
        in
        set_substate
          (Pattern_state
             { substate with
               pattern_bindings =
                 { substate.pattern_bindings with
                   bindings = bindings'
                 ; comp_context_size = comp_context_size'
                 }
             ; inner_pattern_bindings =
                 push_entry identifier entry substate.inner_pattern_bindings
             })
    | Scope_state _
    | Module_state _ ->
        modify_bindings_state (fun state ->
            let entry =
              make_entry
                (Option.some (Comp_level.of_int state.comp_context_size))
            in
            let comp_context_size' = state.comp_context_size + 1 in
            let bindings' =
              Binding_tree.add_toplevel identifier entry state.bindings
            in
            { state with
              bindings = bindings'
            ; comp_context_size = comp_context_size'
            })

  let add_lf_variable ?location identifier =
    add_lf_level_variable identifier
      (Entry.make_lf_variable_entry ?location identifier)

  let add_meta_variable ?location identifier =
    add_meta_level_variable identifier
      (Entry.make_meta_variable_entry ?location identifier)

  let add_parameter_variable ?location identifier =
    add_meta_level_variable identifier
      (Entry.make_parameter_variable_entry ?location identifier)

  let add_substitution_variable ?location identifier =
    add_meta_level_variable identifier
      (Entry.make_substitution_variable_entry ?location identifier)

  let add_context_variable ?location identifier =
    add_meta_level_variable identifier
      (Entry.make_context_variable_entry ?location identifier)

  let add_contextual_variable ?location identifier =
    add_meta_level_variable identifier
      (Entry.make_contextual_variable_entry ?location identifier)

  let add_comp_variable ?location identifier =
    add_comp_level_variable identifier
      (Entry.make_computation_variable_entry ?location identifier)

  let with_bound_lf_variable ?location identifier m =
    with_bindings_state_checkpoint (add_lf_variable ?location identifier &> m)

  let with_bound_meta_variable ?location identifier m =
    with_bindings_state_checkpoint
      (add_meta_variable ?location identifier &> m)

  let with_bound_parameter_variable ?location identifier m =
    with_bindings_state_checkpoint
      (add_parameter_variable ?location identifier &> m)

  let with_bound_substitution_variable ?location identifier m =
    with_bindings_state_checkpoint
      (add_substitution_variable ?location identifier &> m)

  let with_bound_context_variable ?location identifier m =
    with_bindings_state_checkpoint
      (add_context_variable ?location identifier &> m)

  let with_bound_contextual_variable ?location identifier m =
    with_bindings_state_checkpoint
      (add_contextual_variable ?location identifier &> m)

  let with_bound_comp_variable ?location identifier m =
    with_bindings_state_checkpoint
      (add_comp_variable ?location identifier &> m)

  let[@inline] add_binding identifier ?subtree entry =
    modify_bindings (Binding_tree.add_toplevel identifier ?subtree entry)

  let[@inline] add_declaration identifier ?subtree entry =
    let* () = add_binding identifier ?subtree entry in
    modify_substate (function
      | Module_state state ->
          let declarations' =
            Binding_tree.add_toplevel identifier ?subtree entry
              state.declarations
          in
          Module_state { state with declarations = declarations' }
      | _state ->
          Error.raise_violation
            (Format.asprintf "[%s] invalid state" __FUNCTION__))

  let add_lf_type_constant ?location identifier cid =
    add_declaration identifier
      (Entry.make_lf_type_constant_entry ?location identifier cid)

  let add_lf_term_constant ?location identifier cid =
    add_declaration identifier
      (Entry.make_lf_term_constant_entry ?location identifier cid)

  let add_schema_constant ?location identifier cid =
    add_declaration identifier
      (Entry.make_schema_constant_entry ?location identifier cid)

  let add_inductive_computation_type_constant ?location identifier cid =
    add_declaration identifier
      (Entry.make_computation_inductive_type_constant_entry ?location
         identifier cid)

  let add_stratified_computation_type_constant ?location identifier cid =
    add_declaration identifier
      (Entry.make_computation_stratified_type_constant_entry ?location
         identifier cid)

  let add_coinductive_computation_type_constant ?location identifier cid =
    add_declaration identifier
      (Entry.make_computation_coinductive_type_constant_entry ?location
         identifier cid)

  let add_abbreviation_computation_type_constant ?location identifier cid =
    add_declaration identifier
      (Entry.make_computation_abbreviation_type_constant_entry ?location
         identifier cid)

  let add_computation_term_constructor ?location identifier cid =
    add_declaration identifier
      (Entry.make_computation_term_constructor_entry ?location identifier cid)

  let add_computation_term_destructor ?location identifier cid =
    add_declaration identifier
      (Entry.make_computation_term_destructor_entry ?location identifier cid)

  let add_program_constant ?location identifier cid =
    add_declaration identifier
      (Entry.make_program_constant_entry ?location identifier cid)

  let start_module =
    let* bindings = get_bindings_state in
    modify (fun state ->
        { state with
          substate =
            Module_state
              { bindings
              ; declarations = Binding_tree.empty
              ; parent = Option.some state.substate
              }
        })

  let stop_module ?location identifier cid =
    get_substate >>= function
    | Pattern_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid pattern state" __FUNCTION__)
    | Scope_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid scope state" __FUNCTION__)
    | Module_state substate -> (
        match substate.parent with
        | Option.None ->
            Error.raise_violation
              (Format.asprintf "[%s] no parent state" __FUNCTION__)
        | Option.Some parent ->
            let* () = set_substate parent in
            add_declaration identifier ~subtree:substate.declarations
              (Entry.make_module_entry ?location identifier cid))

  let add_module ?location identifier cid m =
    let* () = start_module in
    let* x = m in
    let* () = stop_module ?location identifier cid in
    return x

  let open_namespace identifier =
    modify_bindings (Binding_tree.open_namespace identifier)

  let open_module ?location identifier =
    lookup identifier >>= function
    | { Entry.desc = Entry.Module _; _ } -> open_namespace identifier
    | _ -> Error.raise_at1_opt location Expected_module

  let add_module_abbreviation ?location module_identifier abbreviation =
    lookup_with_subtree module_identifier >>= function
    | ({ Entry.desc = Entry.Module _; _ } as entry), subtree ->
        modify_bindings
          (Binding_tree.add_toplevel abbreviation ~subtree entry)
    | _ -> Error.raise_at1_opt location Expected_module

  let with_scope m =
    let* state = get in
    let* bindings = get_bindings_state in
    let* () =
      put
        { state with
          substate =
            Scope_state { bindings; parent = Option.some state.substate }
        }
    in
    let* x = m in
    let* () = put state in
    return x

  let with_parent_scope m =
    let* state = get in
    match state.substate with
    | Scope_state { parent; _ } -> (
        match parent with
        | Option.Some parent ->
            let* () = put { state with substate = parent } in
            let* x = with_scope m in
            let* () = put state in
            return x
        | Option.None ->
            Error.raise_violation
              (Format.asprintf "[%s] no parent scope" __FUNCTION__))
    | Module_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid module state" __FUNCTION__)
    | Pattern_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid pattern state" __FUNCTION__)

  let allow_free_variables m =
    with_free_variables_state ~free_variables_allowed:true m

  let disallow_free_variables m =
    with_free_variables_state ~free_variables_allowed:false m

  let get_pattern_variables_and_expression_state =
    let* state = get in
    match state.substate with
    | Pattern_state o ->
        let pattern_variables = List.rev o.pattern_variables_rev in
        return (pattern_variables, o.expression_bindings)
    | Module_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid module state" __FUNCTION__)
    | Scope_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid scope state" __FUNCTION__)

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

  let with_free_variables_as_pattern_variables ~pattern ~expression =
    let* state = get in
    let* bindings = get_bindings_state in
    let* () =
      put
        { state with
          substate =
            Pattern_state
              { pattern_bindings =
                  { bindings with
                    lf_context_size = 0
                  ; meta_context_size = 0
                  ; comp_context_size = 0
                  }
              ; inner_pattern_bindings = Identifier.Hamt.empty
              ; pattern_variables_rev = []
              ; expression_bindings = bindings
              }
        }
    in
    let* pattern' = allow_free_variables pattern in
    let* pattern_variables, expression_bindings =
      get_pattern_variables_and_expression_state
    in
    match Identifier.find_duplicates pattern_variables with
    | Option.Some duplicates ->
        let* () = put state in
        raise_duplicate_identifiers_exception
          (fun identifiers -> Duplicate_pattern_variables identifiers)
          duplicates
    | Option.None ->
        let* () = put state in
        let* () = set_bindings_state expression_bindings in
        let* expression' = expression pattern' in
        let* () = put state in
        return expression'

  let add_free_lf_level_variable identifier make_entry =
    modify (fun state ->
        match state.substate with
        | Pattern_state substate ->
            let entry = make_entry Option.none in
            { state with
              substate =
                Pattern_state
                  { substate with
                    expression_bindings =
                      { substate.expression_bindings with
                        bindings =
                          Binding_tree.add_toplevel identifier entry
                            substate.expression_bindings.bindings
                      }
                  ; pattern_variables_rev =
                      identifier :: substate.pattern_variables_rev
                  }
            }
        | Module_state _
        | Scope_state _ ->
            state)

  let add_free_meta_level_variable identifier make_entry =
    modify (fun state ->
        match state.substate with
        | Pattern_state substate ->
            let entry = make_entry Option.none in
            { state with
              substate =
                Pattern_state
                  { substate with
                    inner_pattern_bindings =
                      push_entry identifier entry
                        substate.inner_pattern_bindings
                  ; expression_bindings =
                      { substate.expression_bindings with
                        bindings =
                          Binding_tree.add_toplevel identifier entry
                            substate.expression_bindings.bindings
                      }
                  ; pattern_variables_rev =
                      identifier :: substate.pattern_variables_rev
                  }
            }
        | Module_state _
        | Scope_state _ ->
            state)

  let add_free_comp_level_variable identifier make_entry =
    modify (fun state ->
        match state.substate with
        | Pattern_state substate ->
            let comp_context_size =
              substate.expression_bindings.comp_context_size
            in
            let entry =
              make_entry (Option.some (Comp_level.of_int comp_context_size))
            in
            let comp_context_size' = comp_context_size + 1 in
            { state with
              substate =
                Pattern_state
                  { substate with
                    expression_bindings =
                      { substate.expression_bindings with
                        bindings =
                          Binding_tree.add_toplevel identifier entry
                            substate.expression_bindings.bindings
                      ; comp_context_size = comp_context_size'
                      }
                  ; pattern_variables_rev =
                      identifier :: substate.pattern_variables_rev
                  }
            }
        | Module_state _
        | Scope_state _ ->
            state)

  let are_free_variables_allowed =
    let* state = get in
    return state.free_variables_allowed

  let add_free_lf_variable ?location identifier =
    lookup_toplevel_opt identifier >>= function
    | Option.Some
        { Entry.desc = Entry.Lf_variable { lf_level = Option.None }; _ } ->
        (* [identifier] is known to be a free LF variable because its LF
           level is unknown, so we do not signal it as an illegal free
           variable. *)
        return ()
    | _ -> (
        are_free_variables_allowed >>= function
        | true ->
            add_free_lf_level_variable identifier
              (Entry.make_lf_variable_entry ?location identifier)
        | false ->
            Error.raise_at1
              (Identifier.location identifier)
              Illegal_free_lf_variable)

  let add_free_meta_variable ?location identifier =
    lookup_toplevel_opt identifier >>= function
    | Option.Some
        { Entry.desc = Entry.Meta_variable { meta_level = Option.None }; _ }
      ->
        (* [identifier] is known to be a free meta-variable because its meta
           level is unknown, so we do not signal it as an illegal free
           variable. *)
        return ()
    | _ -> (
        are_free_variables_allowed >>= function
        | true ->
            add_free_meta_level_variable identifier
              (Entry.make_meta_variable_entry ?location identifier)
        | false ->
            Error.raise_at1
              (Identifier.location identifier)
              Illegal_free_meta_variable)

  let add_free_parameter_variable ?location identifier =
    lookup_toplevel_opt identifier >>= function
    | Option.Some
        { Entry.desc = Entry.Parameter_variable { meta_level = Option.None }
        ; _
        } ->
        (* [identifier] is known to be a free parameter variable because its
           meta level is unknown, so we do not signal it as an illegal free
           variable. *)
        return ()
    | _ -> (
        are_free_variables_allowed >>= function
        | true ->
            add_free_meta_level_variable identifier
              (Entry.make_parameter_variable_entry ?location identifier)
        | false ->
            Error.raise_at1
              (Identifier.location identifier)
              Illegal_free_parameter_variable)

  let add_free_substitution_variable ?location identifier =
    lookup_toplevel_opt identifier >>= function
    | Option.Some
        { Entry.desc =
            Entry.Substitution_variable { meta_level = Option.None }
        ; _
        } ->
        (* [identifier] is known to be a free substitution variable because
           its meta level is unknown, so we do not signal it as an illegal
           free variable. *)
        return ()
    | _ -> (
        are_free_variables_allowed >>= function
        | true ->
            add_free_meta_level_variable identifier
              (Entry.make_substitution_variable_entry ?location identifier)
        | false ->
            Error.raise_at1
              (Identifier.location identifier)
              Illegal_free_substitution_variable)

  let add_free_context_variable ?location identifier =
    lookup_toplevel_opt identifier >>= function
    | Option.Some
        { Entry.desc = Entry.Context_variable { meta_level = Option.None }
        ; _
        } ->
        (* [identifier] is known to be a free context variable because its
           meta level is unknown, so we do not signal it as an illegal free
           variable. *)
        return ()
    | _ -> (
        are_free_variables_allowed >>= function
        | true ->
            add_free_meta_level_variable identifier
              (Entry.make_context_variable_entry ?location identifier)
        | false ->
            Error.raise_at1
              (Identifier.location identifier)
              Illegal_free_context_variable)

  let add_computation_pattern_variable ?location identifier =
    lookup_toplevel_opt identifier >>= function
    | Option.Some
        { Entry.desc =
            Entry.Computation_variable { comp_level = Option.None }
        ; _
        } ->
        (* [identifier] is known to be a free computationn variable because
           its computation level is unknown, so we do not signal it as an
           illegal free variable. *)
        return ()
    | _ -> (
        are_free_variables_allowed >>= function
        | true ->
            add_free_comp_level_variable identifier
              (Entry.make_computation_variable_entry ?location identifier)
        | false ->
            Error.raise_at1
              (Identifier.location identifier)
              Illegal_free_computation_variable)

  let with_bound_pattern_meta_variable ?location identifier m =
    get_substate >>= function
    | Pattern_state
        { pattern_bindings
        ; inner_pattern_bindings
        ; pattern_variables_rev
        ; expression_bindings
        } ->
        let entry =
          Entry.make_meta_variable_entry ?location identifier
            (Option.some
               (Meta_level.of_int pattern_bindings.meta_context_size))
        in
        let entry' =
          Entry.make_meta_variable_entry ?location identifier
            (Option.some
               (Meta_level.of_int expression_bindings.meta_context_size))
        in
        let* () =
          set_substate
            (Pattern_state
               { pattern_bindings =
                   { pattern_bindings with
                     meta_context_size =
                       pattern_bindings.meta_context_size + 1
                   }
               ; inner_pattern_bindings =
                   push_entry identifier entry inner_pattern_bindings
               ; pattern_variables_rev = identifier :: pattern_variables_rev
               ; expression_bindings =
                   { expression_bindings with
                     bindings =
                       Binding_tree.add_toplevel identifier entry'
                         expression_bindings.bindings
                   ; meta_context_size =
                       expression_bindings.meta_context_size + 1
                   }
               })
        in
        m
    | Scope_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid scope state" __FUNCTION__)
    | Module_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid module state" __FUNCTION__)

  let with_bound_pattern_parameter_variable ?location identifier m =
    get_substate >>= function
    | Pattern_state
        { pattern_bindings
        ; inner_pattern_bindings
        ; pattern_variables_rev
        ; expression_bindings
        } ->
        let entry =
          Entry.make_parameter_variable_entry ?location identifier
            (Option.some
               (Meta_level.of_int pattern_bindings.meta_context_size))
        in
        let entry' =
          Entry.make_parameter_variable_entry ?location identifier
            (Option.some
               (Meta_level.of_int expression_bindings.meta_context_size))
        in
        let* () =
          set_substate
            (Pattern_state
               { pattern_bindings =
                   { pattern_bindings with
                     meta_context_size =
                       pattern_bindings.meta_context_size + 1
                   }
               ; inner_pattern_bindings =
                   push_entry identifier entry inner_pattern_bindings
               ; pattern_variables_rev = identifier :: pattern_variables_rev
               ; expression_bindings =
                   { expression_bindings with
                     bindings =
                       Binding_tree.add_toplevel identifier entry'
                         expression_bindings.bindings
                   ; meta_context_size =
                       expression_bindings.meta_context_size + 1
                   }
               })
        in
        m
    | Scope_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid scope state" __FUNCTION__)
    | Module_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid module state" __FUNCTION__)

  let with_bound_pattern_substitution_variable ?location identifier m =
    get_substate >>= function
    | Pattern_state
        { pattern_bindings
        ; inner_pattern_bindings
        ; pattern_variables_rev
        ; expression_bindings
        } ->
        let entry =
          Entry.make_substitution_variable_entry ?location identifier
            (Option.some
               (Meta_level.of_int pattern_bindings.meta_context_size))
        in
        let entry' =
          Entry.make_substitution_variable_entry ?location identifier
            (Option.some
               (Meta_level.of_int expression_bindings.meta_context_size))
        in
        let* () =
          set_substate
            (Pattern_state
               { pattern_bindings =
                   { pattern_bindings with
                     meta_context_size =
                       pattern_bindings.meta_context_size + 1
                   }
               ; inner_pattern_bindings =
                   push_entry identifier entry inner_pattern_bindings
               ; pattern_variables_rev = identifier :: pattern_variables_rev
               ; expression_bindings =
                   { expression_bindings with
                     bindings =
                       Binding_tree.add_toplevel identifier entry'
                         expression_bindings.bindings
                   ; meta_context_size =
                       expression_bindings.meta_context_size + 1
                   }
               })
        in
        m
    | Scope_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid scope state" __FUNCTION__)
    | Module_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid module state" __FUNCTION__)

  let with_bound_pattern_context_variable ?location identifier m =
    get_substate >>= function
    | Pattern_state
        { pattern_bindings
        ; inner_pattern_bindings
        ; pattern_variables_rev
        ; expression_bindings
        } ->
        let entry =
          Entry.make_context_variable_entry ?location identifier
            (Option.some
               (Meta_level.of_int pattern_bindings.meta_context_size))
        in
        let entry' =
          Entry.make_context_variable_entry ?location identifier
            (Option.some
               (Meta_level.of_int expression_bindings.meta_context_size))
        in
        let* () =
          set_substate
            (Pattern_state
               { pattern_bindings =
                   { pattern_bindings with
                     meta_context_size =
                       pattern_bindings.meta_context_size + 1
                   }
               ; inner_pattern_bindings =
                   push_entry identifier entry inner_pattern_bindings
               ; pattern_variables_rev = identifier :: pattern_variables_rev
               ; expression_bindings =
                   { expression_bindings with
                     bindings =
                       Binding_tree.add_toplevel identifier entry'
                         expression_bindings.bindings
                   ; meta_context_size =
                       expression_bindings.meta_context_size + 1
                   }
               })
        in
        m
    | Scope_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid scope state" __FUNCTION__)
    | Module_state _ ->
        Error.raise_violation
          (Format.asprintf "[%s] invalid module state" __FUNCTION__)

  let initial_state =
    { substate =
        Module_state
          { bindings =
              { bindings = Binding_tree.empty
              ; lf_context_size = 0
              ; meta_context_size = 0
              ; comp_context_size = 0
              }
          ; declarations = Binding_tree.empty
          ; parent = Option.none
          }
    ; free_variables_allowed = false
    ; generated_fresh_variables_count = 0
    }

  let add_all_bvar_store store =
    (* [store] is a stack, so traverse it from tail to head *)
    traverse_reverse_list_void
      (fun { Store.BVar.name } -> add_lf_variable (Name.to_identifier name))
      (Store.BVar.to_list store)

  let add_all_cvar_store store =
    (* [store] is a stack, so traverse it from tail to head *)
    traverse_reverse_list_void
      (fun { Store.CVar.name; _ } ->
        add_context_variable (Name.to_identifier name))
      (Store.CVar.to_list store)

  let add_all_var_store store =
    (* [store] is a stack, so traverse it from tail to head *)
    traverse_reverse_list_void
      (fun { Store.Var.name } -> add_comp_variable (Name.to_identifier name))
      (Store.Var.to_list store)

  let rec add_all_mctx cD =
    (* [cD] is a stack, so traverse it from tail to head *)
    match cD with
    | Synint.LF.Dec (cD', Synint.LF.Decl (u, _, _, _))
    | Synint.LF.Dec (cD', Synint.LF.DeclOpt (u, _)) ->
        let* () = add_all_mctx cD' in
        add_contextual_variable (Name.to_identifier u)
    | Synint.LF.Empty -> return ()

  let rec add_all_gctx cG =
    (* [cG] is a stack, so traverse it from tail to head *)
    match cG with
    | Synint.LF.Dec (cG', Synint.Comp.CTypDecl (x, _, _))
    | Synint.LF.Dec (cG', Synint.Comp.CTypDeclOpt x) ->
        let* () = add_all_gctx cG' in
        add_comp_variable (Name.to_identifier x)
    | Synint.LF.Empty -> return ()
end
