(** Contexts

    @author Brigitte Pientka
*)

open Support
open Syntax.Int.LF
open Syntax.Int

exception NoTypAvailable

let addToHat (ctxvarOpt, length) =
  (ctxvarOpt, length + 1)

(* More appropriate: Psi into psihat  Oct  4 2008 -bp *)
let rec dctxToHat = function
  | Null            -> (None, 0)
  | CtxVar psi ->
     begin match psi with
     | CInst ({instantiation = {contents = Some (ICtx cPsi)}; _}, _) ->
        dctxToHat cPsi
     | _ -> (Some psi, 0)
     end
  | DDec (cPsi', _) -> addToHat (dctxToHat cPsi')

let rec hatToDCtx phat = match phat with
  | (None    , 0) -> LF.Null
  | (Some psi, 0) -> LF.CtxVar psi
  | (ctx_v   , k) ->
     LF.DDec
       ( hatToDCtx (ctx_v, k-1)
       , LF.TypDeclOpt Id.(mk_name (SomeString ("x" ^ string_of_int k))))


(* Declaration Contexts *)
(*
let rec sigmaShift typrec k = match typrec with
  | SigmaLast tA ->
      SigmaLast (TClo (tA, Shift  (NoCtxShift, k)))

  | SigmaElem (x, tA, typrec) ->
      SigmaElem (x, TClo (tA, Shift (NoCtxShift, k)), sigmaShift typrec (k (*+ 1*) ))
*)
let rec sigmaShift typrec s = match typrec with
  | SigmaLast(n, tA) ->
      SigmaLast (n, TClo (tA, s))

  | SigmaElem (x, tA, typrec) ->
      SigmaElem (x, TClo (tA, s), sigmaShift typrec (Substitution.LF.dot1 s))

(* ctxDec Psi k = x:A
 *
 * Invariant:
 *
 *   If      |Psi| >= k, where |Psi| is size of Psi,
 *   then    D ; Psi |- k => A  and  x:A in Psi at position k,
 *           D ; Psi |- A <= type
 *)
let ctxDec cPsi k =
  (* ctxDec' (Psi'', k') = x:V
   * where Psi |- ^(k-k') : Psi'', 1 <= k' <= k
   *)
  let rec ctxDec' = function
    | (DDec (_cPsi', TypDecl (x, tA')), 1) ->
        TypDecl (x, TClo (tA', Shift k))

    | (DDec (cPsi', TypDecl (_x, _tA')), k') ->
        ctxDec' (cPsi', k' - 1)

    | (DDec (cPsi', TypDeclOpt _ ), 1) ->
        raise NoTypAvailable

    | (DDec (cPsi', _), k') ->
        ctxDec' (cPsi', k'-1)

    | (CtxVar (CInst ({instantiation = {contents = Some (ICtx cPsi)}; _}, _ )), k) ->
        ctxDec' (cPsi, k)
    (* (Null, _) and (CtxVar _, _) should not occur by invariant *)
  in
    ctxDec' (cPsi, k)


(* ctxSigmaDec (Psi, k,i) = x:A
 *
 * Invariant:
 *
 *   If      |Psi| >= k, where |Psi| is size of Psi,
 *   then    D ; Psi |- k => Sigma x1:A1, ... xn:An
 *           A = Sigma x1:A1, ... xn:An, and x:A is in Psi
 *      and  D ; Psi |- Sigma x1:A1, ... xn:An  <= type
 *)
let ctxSigmaDec cPsi k =
  (* ctxDec' (Psi'', k') = x:V
   * where Psi |- ^(k-k') : Psi'', 1 <= k' <= k
   *)
  let rec ctxDec' = function
    | (DDec (_cPsi', TypDecl (x, Sigma tArec)), 1) ->
        TypDecl (x, Sigma (sigmaShift tArec  (Shift k)))

    | (DDec (cPsi', TypDecl (_x, Sigma _)), k') ->
        ctxDec' (cPsi', k' - 1)

    | (DDec (cPsi', TypDecl (_x, _tA')), k') ->
        ctxDec' (cPsi', k' - 1)
    | (CtxVar (CInst ({instantiation = {contents = Some (ICtx cPhi) }; _}, _)) , k) ->
        ctxDec' (cPhi, k)
    (* (Null, k') and (CtxVar _, k') should not occur by invariant *)
  in
    ctxDec' (cPsi, k)


(* ctxVar(Psi) = psi opt
 *
 * Invariant:
 *
 *   Given a data-level context Psi,
 *    returns Some psi if Psi has the form  psi, ...
 *    otherwise returns None
 *)
let rec ctxVar = function
  | Null              -> None
  | CtxVar psi        -> Some psi
  | DDec   (cPsi, _x) -> ctxVar cPsi

let hasCtxVar cPsi = Maybe.is_some (ctxVar cPsi)

(* append cD1 cD2 = (cD1, cD2) *)
let rec append cD1 cD2 = match cD2 with
  | Empty ->
      cD1

  | Dec (cD2', dec) ->
      let cD1' = append cD1 cD2' in
        Dec (cD1', dec)

let rec fold (empty : 'b) (f : 'b -> 'a -> 'b) (ctx : 'a LF.ctx) =
  match ctx with
  | LF.Empty -> empty
  | LF.Dec (ctx', d) -> f (fold empty f ctx') d

let map f ctx =
  fold LF.Empty (fun ctx' x -> LF.Dec (ctx', f x)) ctx

(** Transforms a context into a list by applying the given function.
    The list order will be the reverse of the context,
    i.e. the rightmost entry of the context (which is the first entry)
    will be the rightmost entry of the lsit (which is the last entry).
 *)
let rec to_list_map_rev (ctx : 'a LF.ctx) (f : 'a LF.ctx -> 'a -> 'b) : 'b list =
  match ctx with
  | Empty -> []
  | Dec (ctx', x) -> f ctx' x :: to_list_map_rev ctx' f

(** Converts the context to a list by applying a given function.
    The list order will be the same as the context,
    i.e. the rightmost entry of the context (the first entry)
    will be the _leftmost_ entry of the list (the first entry).
 *)
let to_list_map (ctx : 'a LF.ctx) (f : 'a LF.ctx -> 'a -> 'b) : 'b list =
  let rec go (ctx : 'a LF.ctx) (acc : 'b list) : 'b list =
    match ctx with
    | Empty -> acc
    | Dec (ctx', x) -> go ctx' (f ctx' x :: acc)
  in
  go ctx []

(** Convert the context to a list.
    See `to_list_map_rev` for a remark about the "reverse" nature of this.
 *)
let to_list_rev (ctx : 'a LF.ctx) : 'a list =
  to_list_map_rev ctx (Misc.const Misc.id)

(** Convert the context to a list, with subcontexts.
    See `to_list_map_rev` for a remark about the "reverse" nature of this.
 *)
let to_sublist_rev (ctx : 'a LF.ctx) : ('a LF.ctx * 'a) list =
  to_list_map_rev ctx Misc.tuple

(** Convert the context to a list.
 *)
let to_list (ctx : 'a LF.ctx) : 'a list =
  to_list_map ctx (Misc.const Misc.id)

let to_sublist (ctx : 'a LF.ctx) : ('a LF.ctx * 'a) list =
  to_list_map ctx Misc.tuple

let rec of_list_map (l : 'a list) (f : 'a -> 'b) : 'b LF.ctx =
  match l with
  | [] -> LF.Empty
  | x :: xs -> LF.Dec(of_list_map xs f, f x)

let of_list_map_rev (l : 'a list) (f : 'a -> 'b) : 'b LF.ctx =
  List.fold_left (fun acc x -> LF.Dec (acc, f x)) LF.Empty l

let of_list (l : 'a list) : 'a LF.ctx =
  of_list_map l Misc.id

let of_list_rev (l : 'a list) : 'a LF.ctx =
  of_list_map_rev l Misc.id

(** Iterate over a context from left to right (oldest variable first).
    The callback `f` gets both the subcontext of the variable _and_ the variable as input.
    Not tail-recursive, since contexts are snoc-lists.
 *)
let rec iter (ctx : 'a LF.ctx) (f : 'a LF.ctx -> 'a -> unit) : unit =
  match ctx with
  | Empty -> ()
  | Dec (ctx', x) -> iter ctx' f; f ctx' x

let iter' (ctx : 'a LF.ctx) (f : 'a -> unit) : unit =
  iter ctx (fun _ -> f)

(** Iterate over a context from right to left (most recent variable first)
    Tail recursive.
 *)
let rec iter_rev (ctx : 'a LF.ctx) (f : 'a LF.ctx -> 'a -> unit) : unit =
  match ctx with
  | Empty -> ()
  | Dec (ctx', x) -> f ctx' x; iter_rev ctx' f

let iter_rev' (ctx : 'a LF.ctx) (f : 'a -> unit) : unit =
  iter_rev ctx (fun _ -> f)

let find_with_index (ctx : 'a LF.ctx) (f : 'a LF.ctx -> 'a * int -> bool) : ('a * int) option =
  let rec go (ctx : 'a LF.ctx) (idx : int) =
    match ctx with
    | Empty -> None
    | Dec (ctx', x) ->
       let open Maybe in
       Lazy.force
         ( lazy (go ctx' (idx + 1))
           <|> lazy (of_bool (f ctx' (x, idx)) &> Some (x, idx))
         )
  in
  go ctx 1

let find_with_index' (ctx : 'a LF.ctx) (f : 'a * int -> bool) : ('a * int) option =
  find_with_index ctx (Misc.const f)

let find_with_index_rev (ctx : 'a LF.ctx) (f : 'a LF.ctx -> 'a * int -> bool) : ('a * int) option =
  let rec go (ctx : 'a LF.ctx) (idx : int) =
    match ctx with
    | Empty -> None
    | Dec (ctx', x) ->
       (** The following does not use Maybe.(<|>) to be optimized by
           TCO (Tail Call Optimzations)
        *)
       if f ctx' (x, idx)
       then Some (x, idx)
       else go ctx' (idx + 1)
  in
  go ctx 1

let find_with_index_rev' (ctx : 'a LF.ctx) (f : 'a * int -> bool) : ('a * int) option =
  find_with_index_rev ctx (Misc.const f)

(** Find an item satisfying a condition in a context from left to right
    (oldest one first)
 *)
let rec find (ctx : 'a LF.ctx) (f : 'a LF.ctx -> 'a -> bool) : 'a option =
  match ctx with
  | Empty -> None
  | Dec (ctx', x) ->
     let open Maybe in
     Lazy.force
       ( lazy (find ctx' f)
         <|> lazy (of_bool (f ctx' x) &> Some x)
       )

let find' (ctx : 'a LF.ctx) (f : 'a -> bool) : 'a option =
  find ctx (Misc.const f)

(** Find an item satisfying a condition in a context from right to left
    (most recent one first)
 *)
let rec find_rev (ctx : 'a LF.ctx) (f : 'a LF.ctx -> 'a -> bool) : 'a option =
  match ctx with
  | Empty -> None
  | Dec (ctx', x) ->
     (** The following does not use Maybe.(<|>) to be optimized by
         TCO (Tail Call Optimzations)
      *)
     if (f ctx' x)
     then Some x
     else find_rev ctx' f

let find_rev' (ctx : 'a LF.ctx) (f : 'a -> bool) : 'a option =
  find_rev ctx (Misc.const f)

let append_hypotheses (h1 : Comp.hypotheses) (h2 : Comp.hypotheses) : Comp.hypotheses =
  let open! Comp in
  let { cD = cD1; cG = cG1; cIH = cIH1 } = h1 in
  let { cD = cD2; cG = cG2; cIH = cIH2 } = h2 in
  let cD = append cD1 cD2 in
  let cG = append cG1 cG2 in
  let cIH = append cIH1 cIH2 in
  { cD; cG; cIH }

let rec length cD = match cD with
  | Empty        -> 0
  | Dec (cD', _) -> 1 + length cD'


let rec dctxLength = function
  | Null           -> 0
  | CtxVar _       -> 0
  | DDec (cPsi, _) -> 1 + dctxLength cPsi


(* Lookup name in context
 *
 * getNameDCtx cPsi k = x
 *
 * If |cPsi| <= k then x is the name of the k-th declaration in cPsi
 *
 * Invariants for lookup in cD and cG similar.
 *)

let rec getNameDCtx cPsi k = match (cPsi, k) with
  | (DDec (_cPsi, TypDecl (x, _ )), 1) -> x
  | (DDec (_cPsi, TypDeclOpt x) , 1)   -> x
  | (DDec (cPsi, _ ) , k) -> getNameDCtx cPsi (k-1)

let rec getNameMCtx cD k = match (cD, k) with
  | (Dec (_cD, Decl(u, _ ,_ )), 1) -> u
  | (Dec (_cD, DeclOpt u), 1) -> u
  | (Dec (cD, _ ) , k) ->
      getNameMCtx cD (k-1)

let rec getNameCtx cG k = match (cG, k) with
  | (Dec(_cG, Comp.CTypDecl (x, _ , _ )), 1 ) -> x
  | (Dec(_cG, Comp.CTypDeclOpt x), 1) -> x
  | (Dec(cG, _ ) , k) -> getNameCtx cG (k-1)



let rec projectCtxIntoDctx = function
  | Empty            -> Null
  | Dec (rest, last) -> DDec (projectCtxIntoDctx rest, last)

(*
let typdeclToCtypdecl cPsi = function
  | TypDecl (name, typ) -> MDecl(name, typ, cPsi)
  | TypDeclOpt name -> MDeclOpt name

let rec typdeclCtxToMctx cPsi = function
  | Empty            -> Empty
  | Dec (rest, last) -> Dec (typdeclCtxToMctx (DDec(cPsi, rest))
                                              typdeclToCtypdecl cPsi last)
      *)

(* Given cPsi = g, ...,
   return cPsi = g, x:A, ... *)
let splitContextVariable cPsi new_typ_decl =
  let rec inner = function
    | CtxVar ctx_var -> DDec(CtxVar ctx_var, new_typ_decl)
    | DDec (cPsi, concrete) -> DDec(inner cPsi, concrete)
  in
    inner cPsi

let emptyContextVariable cPsi = (* wrong *)
  let rec inner = function
    | CtxVar ctx_var -> Null
    | DDec (cPsi, concrete) -> DDec(inner cPsi, concrete)
  in
    inner cPsi

let rec lookup' ctx k = match ctx, k with
  | Dec (_, x), 1 -> Some x
  | Dec (ctx', _), k -> lookup' ctx' (k - 1)
  | _ -> None

let lookup_dep (cD : LF.mctx) k =
  let open Maybe in
  lookup' cD k
  $ function
    | LF.Decl (_, tau, dep) -> Some (tau, dep)
    | _ -> None

let lookup cG k =
  let open Maybe in
  lookup' cG k
  $ function
    | Comp.CTypDecl (_, tau, _) -> Some tau
    | _ -> None

let rec lookupSchema cD psi_offset = match (cD, psi_offset) with
  | (Dec (_cD, Decl (_, CTyp (Some cid_schema), _)), 1) -> cid_schema
  | (Dec (cD, _) , i) ->
      lookupSchema cD (i-1)

and lookupCtxVar cD cvar =
  let rec lookup cD offset = match cD with
      | Empty -> raise (Error.Violation "Context variable not found")
      | Dec (cD, Decl (psi, CTyp (Some schemaName), _)) ->
          begin match cvar with
            | CtxName phi when psi = phi ->  (psi, schemaName)
            | (CtxName _phi)             -> lookup cD (offset+1)
            | CtxOffset n                ->
                if (n - offset) = 1 then
                  (psi, schemaName)
                else
                  lookup cD (offset+1)
          end
      | Dec (cD, _ ) -> lookup cD (offset+1)
  in
    lookup cD 0

and lookupCtxVarSchema cO phi = snd (lookupCtxVar cO phi)

let rec rename src dst get_name rename_decl = function
  | LF.Empty -> LF.Empty
  | LF.Dec (ctx', d) when Id.equals (get_name d) src ->
     LF.Dec (ctx', rename_decl (fun _ -> dst) d)
  | LF.Dec (ctx', d) ->
     let ctx' = rename src dst get_name rename_decl ctx' in
     LF.Dec (ctx', d)

(** Renames the first (from right to left) variable named `src` to
    `dst`. *)
let rename_mctx src dst =
  rename src dst LF.name_of_ctyp_decl LF.rename_ctyp_decl

let rename_gctx src dst =
  rename src dst Comp.name_of_ctyp_decl Comp.rename_ctyp_decl
