(* -*- coding: utf-8; indent-tabs-mode: nil; -*- *)

(** Substitutions

    @author Brigitte Pientka
*)


open Syntax.Int.LF

module LF = struct

  let (dprint, dprnt) = Debug.makeFunctions (Debug.toFlags [9])

  exception Error of string

  (**************************)
  (* Explicit Substitutions *)
  (**************************)

  (* id = ^0
   *
   * Invariant:
   *
   * cPsi |- id : cPsi      id is patsub
   *
   * Note: we do not take into account weakening here.
   *)
  let id =  Shift (NoCtxShift , 0)

  (* shift = ^1
   *
   * Invariant:
   *
   * cPsi, x:tA |- ^ : cPsi     ^ is patsub
   *)
  let shift =  Shift (NoCtxShift , 1)

  (* invShift = ^-1 = _.^0
   *
   * Invariant:
   *
   * Psi |- ^-1 : Psi, A    ^-1 is patsub
   *)
  let invShift = Dot (Undef, id)

  (* comp s1 s2 = s'
   *
   * Invariant:
   *
   * If   Psi'  |- s1 : Psi
   * and  Psi'' |- s2 : Psi'
   * then s'  =  s1 o s2
   * and  Psi'' |- s1 o s2 : Psi
   *
   * If   s1, s2 patsub
   * then s' patsub
   *)
  let rec comp s1 s2 = match (s1, s2) with
(*    | (CoShift (Coe co_id, NoCtxShift, 0), s2) ->  *)
        (* c(g) |- s1 : g             u:hil A |- x/x : x:nd A
           Psi  |- s2 : c(g)  where s2 = hil_imp ... /u

           Cannot be really defined Tue Sep  1 20:31:46 2009 -bp 
        *)

    | (CoShift (Coe co_cid, NoCtxShift, 0), CoShift (InvCoe co_cid', NoCtxShift, 0)) -> 
        (* c(g) |- s1 : g             u:hil A |- x/x : x:nd A
           g    |- s2 : c(g)  where s2 = x/u   *)

        if co_cid = co_cid' then 
          Shift (NoCtxShift , 0)
        else 
          raise (Error "Composition for CoShifts undefined - 1 ")

    | (CoShift (InvCoe co_cid', NoCtxShift, 0), CoShift (Coe co_cid, NoCtxShift, 0) ) -> 
        (* g     |- s1 : c(g)             u:hil A |- x/x : x:nd A
           c(g)  |- s2 : g  where s2 = x/u   *)

        if co_cid = co_cid' then 
          Shift (NoCtxShift , 0)
        else 
          raise (Error "Composition for CoShifts undefined - 2")

    | (CoShift (Coe co_cid, CtxShift psi, d), s2) -> 
        let rec ctx_shift n s2 = match s2 with
          | Dot(_ft, s) -> ctx_shift (n - 1) s
              (*  c(psi), Psi |- s1 : .   and Psi2 |- s2. ft : c(psi), Psi  *) 

          | CoShift (Coe co_cid', NoCtxShift, k) -> 
              (*  c(psi), Psi |- s1 : .   and (c'(c(psi)), Psi), Psi2 |- s2 : c(psi), Psi
               *  c'(c(psi)), Psi, Psi2 |-  s : .
               *)          
              CoShift (Coe co_cid' , CtxShift (CoCtx (co_cid, psi)), k + n)
            

          | CoShift (Coe co_cid', NegCtxShift _psi, k) -> 
              (* c(psi), Psi |- s1 : .    and Psi, Psi' |- s2 : c(psi), Psi
               * Psi, Psi' |- s1 o s2 : .
               *)
            if co_cid = co_cid' then
             Shift (NoCtxShift, k + n)
            else 
              raise (Error "CoShift Composition undefined - 2")

          | CoShift (InvCoe co_cid', NoCtxShift, d) ->  
              (* c(psi), Psi |- s1 : .    and psi, Psi' |- s2 : c(psi), Psi
               * psi, Psi' |- s1 o s2 : .
               *)
            if co_cid = co_cid' then 
             CoShift (Coe co_cid, CtxShift psi, d+n)
            else 
              raise (Error "CoShift Composition undefined - 3")

          | Shift (NoCtxShift, k) ->
              (* c(psi), Psi |- s1 : .  and   c(psi), Psi, Psi' |- s2 <= c(psi), Psi 
                  c(psi), Psi, Psi' |- s : . 
               *) 
              
              CoShift (Coe co_cid, NoCtxShift, k+n)


          | Shift (NegCtxShift _psi, k) ->
              (* c(psi), Psi |- s1 : .  and   Psi, Psi' |- s2 <= c(psi), Psi 
                  Psi, Psi' |- s : . 
               *)             
              Shift (NoCtxShift, k+n)

          | _ -> (* (Printf.printf "Composing: s1 = %s \n and s2 = %s\n\n"
                    (P.subToString s1) (P.subToString s2) ; *)
              raise (Error "CoShift Composition undefined - 5 ")
        in
          ctx_shift d s2

      
    | (Shift (NoCtxShift , 0), s2) -> 
        (*  Psi |- s1 : Psi   and Psi2 |- s2 : Psi
         *  therefore   Psi2 |- s2 : Psi  and s2 = s1 o s2
         *)
        s2

    | (s, Shift (NoCtxShift, 0)) ->
        (*  Psi1 |- s1 : Psi   and Psi1 |- s2 : Psi1
         *  therefore   Psi1 |- s1 : Psi  and s1 = s1 o s2
         *)
        s


    | (Shift (CtxShift psi, n), Shift (NegCtxShift psi', k)) ->
        (* psi, Psi |- s1 : .   and     Psi,Psi' |- s2 : psi, Psi
         * therefore  Psi,Psi' |- s : .
         *)
        if psi = psi' then
          Shift (NoCtxShift, n+k)
        else
          raise (Error "Composition undefined - 1 ")

    | (Shift (CtxShift psi , m), s2) ->
        let rec ctx_shift n s2 = match s2 with
          | Dot(_ft, s) -> ctx_shift (n - 1) s
              (*  psi, Psi |- s1 : .   and Psi2 |- s2. ft : psi, Psi  *)

          | Shift (NoCtxShift, k) -> Shift (CtxShift psi, k + n)
              (*  psi, Psi |- s1 : .   and (psi, Psi), Psi2 |- s2 : psi, Psi
               *  psi |-  s : .
               *)

          | Shift (NegCtxShift _psi, k) -> Shift (NoCtxShift, k + n)
              (* psi, Psi |- s1 : .    and Psi, Psi' |- s2 : psi, Psi
               * Psi, Psi' |- s1 o s2 : .
               *)
          | CoShift (Coe co_cid, NoCtxShift, d) -> CoShift (Coe co_cid, CtxShift psi, d+n)
              (* psi, Psi |- s1 : .    and c(psi), Psi' |- s2 : psi, Psi
               * c(psi), Psi' |- s1 o s2 : .
               *)

          | _ -> (* (Printf.printf "Composing: s1 = %s \n and s2 = %s\n\n"
                    (P.subToString s1) (P.subToString s2) ; *)
              raise (Error "Composition undefined - 2 ")
        in
          ctx_shift m s2

    | (Shift (NegCtxShift psi, k), Shift (NoCtxShift, m)) ->
        (* Psi1 |- s1 : psi     and   Psi1, Psi |- s2 : Psi1
         *  therefore   Psi1, Psi |- s : psi      where s = s1 o s2
         *)
        Shift (NegCtxShift psi, k + m)

    | (Shift (NegCtxShift psi, 0), Shift (CtxShift psi', m)) ->
        (* . |- s1 : psi     and  psi,Psi' |- s2 : .
         *  therefore   psi, Psi' |- s : psi      where s = s1 o s2
         *)
        if psi = psi' then
          Shift (NoCtxShift, m)
        else
          raise (Error "Composition not defined - 3")

    (* Case: Shift(CtxShift psi, m) o Shift(CtxShift psi', n) impossible *)

    | (Shift (NoCtxShift, n), Shift (NoCtxShift, m)) ->
        (* psi, Psi |- s1 : psi, Psi1   and psi, Psi2 |- s2: psi, Psi
         *  therefore  psi, Psi2 |- s : psi, Psi1  where s = s1 o s2
         *)
        Shift (NoCtxShift, n + m)

    (*    | (Shift (psi, n), SVar (s, tau)) -> Shift (|Psi''|) *)

    | (Shift (psi,n), Dot (_ft, s)) ->
        comp (Shift (psi, n - 1)) s

    | (CoShift (co, psi,n), Dot (_ft, s)) ->
        comp (CoShift (co, psi, n - 1)) s

    | (SVar (s, tau), s2) ->
        SVar (s, comp tau s2)

    | (Dot (ft, s), s') ->
        (* comp(s[tau], Shift(k)) = s[tau]
         * where s :: Psi[Phi]  and |Psi| = k
         *
         * comp(s[tau], Shift(k)) = Dot(Id(1), ... Dot(Id(k0), s[tau]))
         * where s :: Psi[Phi]  and |Psi| = k'
         * k = k' + k0
         *)
        let h = frontSub ft s' in 
          Dot (h, comp s s')

    | (CoShift (Coe co_cid, NoCtxShift, d) ,  CoShift (Coe _co_cid, NoCtxShift, _d) ) -> 
        raise (Error ("Composition not defined: 1 CoShift d =/=0 d = " ^ string_of_int d))

    | (Shift (NoCtxShift, n) ,  CoShift (Coe co_cid, NoCtxShift, d)) -> 
        (* psi, Psi0,Psi1 |- s1 : psi,Psi0  and  c(psi), Psi0, Psi1, Psi2 |- s2 <= psi, Psi0,Psi1 *)
        CoShift (Coe co_cid, NoCtxShift, d+n)

    | (CoShift (Coe co_cid, NoCtxShift, k) ,  Shift (NoCtxShift, d )) -> 
        (* c(psi), Psi |- s1 : psi   and    c(psi), cPsi, Psi' |- s2 <= c(psi), Psi *)
        CoShift (Coe co_cid, NoCtxShift, k + d)

    | (CoShift (InvCoe co_cid', NoCtxShift, n) ,  Shift (NoCtxShift, d) ) -> 
        (* g, cPsi  |- s1 : c(g)            
           g, cPsi, cPsi'  |- s2 : g, cPsi   *)
        CoShift (InvCoe co_cid', NoCtxShift, n+d)

    | (Shift (NoCtxShift, n) ,  CoShift (InvCoe co_cid, NoCtxShift, d)) -> 
        (* c(psi), Psi0,Psi1 |- s1 : c(psi),Psi0  and  psi, Psi0, Psi1, Psi2 |- s2 <= c(psi), Psi0,Psi1 *)
        CoShift (InvCoe co_cid, NoCtxShift, d+n)

    | (CoShift (InvCoe co_cid', NoCtxShift, n) ,  CoShift (Coe co_cid, NoCtxShift, d) ) -> 
        (* g, cPsi  |- s1 : c(g)     c(g), cPsi, cPsi' |-   s2 : g, cPsi   
        *)
        if co_cid' = co_cid then 
          Shift(NoCtxShift, d+n)
        else
          raise (Error "CoShift (InvCoe ) Composition not defined?")

    | (_s1, _s2) -> 
        raise (Error "Composition not defined?")


  (* bvarSub n s = Ft'
   *
   * Invariant:
   *
   * If    Psi |- s <= Psi'    Psi' |- n <= A
   * then  Ft' = Ftn         if  s = Ft1 .. Ftn .. ^k
   * or  Ft' = ^(n + k)      if  s = Ft1 .. Ftm ^k   and m < n
   * and Psi |- Ft' <= [s]A
   *)
  and bvarSub n s = match (n, s) with
    | (1, Dot (ft, _s))  -> ft
    | (n, Dot (_ft, s))  -> bvarSub (n - 1) s
    | (n, Shift (_ , k)) -> Head (BVar (n + k))
    | (n, CoShift (_ , _, k)) -> Head (BVar (n + k))


  (* frontSub Ft s = Ft'
   *
   * Invariant:
   *
   * If   Psi |- s : Psi'     Psi' |- Ft : A
   * then Ft' = Ft [s]
   * and  Psi |- Ft' : [s]A
   *)
  and frontSub ft s = match ft with
    | Head (BVar n)       ->  bvarSub n s
    | Head (FVar _)       -> ft
    | Head (MVar (u, s')) -> Head (MVar (u, comp s' s)) 
    | Head (PVar (u, s')) -> Head (PVar (u, comp s' s))

    | Head (Proj (BVar n, k))  ->
        begin match bvarSub n s with
          | Head (BVar x) ->
              Head (Proj (BVar x, k))

          | Head (PVar _ as h) ->
              Head (Proj (h, k))

          | Block (BVar n, k') -> 
              if k = k' then Head(BVar n)
              else raise (Error "[frontSub] Proj-Block undefined ")

          | Obj (Tuple (_, tuple)) ->
              let rec nth s = function
                | (Last u, 1) -> (u, s)
                | (Cons (u, _), 1) -> (u, s)
                | (Cons (u, tuple), n) -> nth (Dot(Obj u, s)) (tuple, n - 1)
              in
(*                Obj (Clo (nth s (tuple, k))) *)
                Obj (fst (nth s (tuple, k)))
        end

    | Head (Proj (h, k))  ->
        begin match frontSub (Head h) s with
          | Head h' ->
              Head (Proj (h', k))

          | Block (BVar n, k') -> 
              if k = k' then Head(BVar n)
              else raise (Error "[frontSub] Proj-Block undefined ")
          | Obj (Tuple (_, tuple)) ->
              let rec nth s = function
                | (Last u, 1) -> (u, s)
                | (Cons (u, _), 1) -> (u, s)
                | (Cons (u, tuple), n) -> nth (Dot(Obj u, s)) (tuple, n - 1)
              in
(*                Obj (Clo (nth s (tuple, k))) *)
                Obj (fst (nth s (tuple, k)))
        end

    | Head (AnnH (h, a))  ->
        let Head h' = frontSub (Head h) s in
          Head (AnnH (h', a))

    | Head (Const c)      -> Head (Const c)
    | Block (BVar n, index) -> 
        begin match bvarSub n s with 
          | Head (BVar m) -> Block (BVar m, index)
          | Head (Proj (BVar m, index')) -> 
              if index = index' then Head (BVar m) else  
                raise (Error "[frontSub] Block undefined ")

          | _ ->  raise (Error "[frontSub] Block undefined ")
        end


    | Obj u               -> Obj (Clo (u, s))
    | Undef               -> Undef


  (* dot1 (s) = s'
   *
   * Invariant:
   *
   * If   Psi |- s : Psi'
   * then s' = 1. (s o ^)
   * and  for all A s.t.  Psi' |- A : type
   * Psi, [s]A |- s' : Psi', A
   *
   * If s patsub then s' patsub
   *)
  (* first line is an optimization *)
  (* roughly 15% on standard suite for Twelf 1.1 *)
  (* Sat Feb 14 10:16:16 1998 -fp *)
  and dot1 s = match s with
    | Shift (_ , 0) -> s
    | s             -> Dot (Head (BVar 1), comp s shift)



  (* decSub (x:tA) s = (x:tA[s])
   *
   * Invariant:
   *
   * If   D ; Psi  |- s     <= Psi'    D ; Psi' |- A <= type
   * then D ; Psi  |- [s]A] <= type
   *)

  (* First line is an optimization suggested by cs *)
  (* Dec[id] = Dec *)
  (* Sat Feb 14 18:37:44 1998 -fp *)
  (* seems to have no statistically significant effect *)
  (* undo for now Sat Feb 14 20:22:29 1998 -fp *)
  (*
    fun decSub (D, Shift(0)) = D
    | decSub (Dec (x, A), s) = Dec (x, Clo (A, s))
  *)
  let decSub (TypDecl (x, tA)) s = TypDecl (x, TClo (tA, s))


  (* invDot1 (s)         = s'
   * invDot1 (1. s' o ^) = s'
   *
   * Invariant:
   *
   * s = 1 . s' o ^
   * If Psi' |- s' : Psi
   * (so Psi',A[s] |- s : Psi,A)
   *)
  (*  let invDot1 s = comp (comp shift s) invShift *)


  (***************************)
  (* Inverting Substitutions *)
  (***************************)

  (* invert s = s'
   *
   * Invariant:
   *
   * If   D ; Psi  |- s  <= Psi'    (and s patsub)
   * then D ; Psi' |- s' <= Psi
   * s.t. s o s' = id    (comp s' s = id)
   *)
  let invert s =
    let rec lookup n s p = match s with
      | Shift _                 -> None
      | CoShift _               -> None
      | Dot (Undef, s')         -> lookup (n + 1) s' p
      | Dot (Head (BVar k), s') ->
          if k = p then
            Some (Head (BVar n))
          else
            lookup (n + 1) s' p 

      (* Attention -bp,jd *)
      | Dot (Head (Proj(BVar k, index)), s') ->
          if k = p then
            Some (Block (BVar n, index))
          else
            lookup (n + 1) s' p 

      | Dot (Block (BVar k, index), s') -> 
          if k = p then
            Some (Head (Proj (BVar n, index)))
          else 
            lookup (n+1) s' p
    in

    let rec invert'' p si = match p with
      | 0 -> si
      | p ->
          let front = match lookup 1 s p with
            | Some h -> h
            | None   -> Undef
          in
            invert'' (p - 1) (Dot (front, si)) in

    let rec invert' n s = match s with
      | CoShift (Coe co_cid, NoCtxShift, p) -> 
          (*  c(g), Psi |- s <= g  where |Psi| = d
              g         |- c^-1(id), undef, ... undef <= c(g), Psi
           *)
          invert'' p (CoShift  (InvCoe co_cid, NoCtxShift, n))

      | CoShift (InvCoe co_cid, NoCtxShift, p) -> 
          invert'' p (CoShift  (Coe co_cid, NoCtxShift, n))

      | Shift (NoCtxShift, p) ->
          invert'' p (Shift (NoCtxShift, n))

      | Shift (CtxShift(psi), p) ->
          invert'' p (Shift (NegCtxShift(psi), n))

      | Shift (NegCtxShift(psi), 0) ->
          (* . |- s : psi  Hence psi |- si : . *)
          Shift (CtxShift(psi), 0)

      | Shift (NegCtxShift(psi), p) ->
          (* Psi |- s : psi  Hence psi |- si : Psi *)
          invert'' p (Shift (CtxShift psi, n))

      | Dot (_, s') ->
          invert' (n + 1) s'

    in
      invert' 0 s


  (* strengthen t Psi = Psi'
   *
   * Invariant:
   *
   * If   D ; Psi'' |- t : Psi  (* and t is a pattern sub *)
   * then D ; Psi'  |- t : Psi  and cPsi' subcontext of cPsi
   *)
  let rec strengthen s cPsi = match (s, cPsi) with
    | (Shift (NoCtxShift, _ (* 0 *)), Null) ->
        Null

    | (Shift (CtxShift _psi, _ (* 0 *)), Null) ->
        Null

    | (Shift (NegCtxShift _psi, _ ), CtxVar _psi') ->
        Null

    | (Shift (NoCtxShift, _ ), CtxVar psi) ->
        CtxVar psi

    | (Dot (Head (BVar _k) (* k = 1 *), t), DDec (cPsi, decl)) ->
        let t' = comp t invShift in
          (* Psi  |- x:A dec where decl = x:A
           * Psi' |- t' : Psi
           * Psi' |- x:[t']A dec
           *)
          DDec (strengthen t' cPsi, decSub decl t')

    | (Dot (Undef, t), DDec (cPsi, _)) ->
        strengthen t cPsi

    | (Shift (psi, n), cPsi) ->
        strengthen (Dot (Head (BVar (n + 1)), Shift (psi, n + 1))) cPsi


  (* isId s = B
   *
   * Invariant:
   *
   * If   Psi |- s: Psi', s weakensub
   * then B holds
   * iff s = id, Psi' = Psi
   *)
  let isId s =
    let rec isId' s k' = match s with
      | Shift (NoCtxShift, k)   -> k = k'
      | Dot (Head (BVar n), s') -> n = k' && isId' s' (k' + 1)
      | _                       -> false
    in
      isId' s 0


(* cloInv (U, w) = U[w^-1]
 *
 * Invariant:
 *
 * If Psi |- M <= A
 * Psi |- w  <= Psi'  w pattern subst
 * [w^-1]M defined (without pruning or constraints)
 *
 * then Psi' |- [w^-1]M : [w^-1]A
 *
 * Effects: None
 *)
(*   let cloInv (tM, w) = Clo (tM, invert w) *)



(* compInv s w = t
 *
 * Invariant:
 *
 * If  D ; Psi |- s <= Psi1
 * D ; Psi |- w <= Psi'
 * then  t = s o (w^-1)
 * and   D ; Psi' |- t <= Psi1
 *)
(*  let compInv s w = comp s (invert w) *)

  (* isMId t = B
   *
   * Invariant:
   *
   * If   cD |- t: cD', t weaken_msub
   * then B holds
   * iff t = id, cD' = cD
   *)
  let isMId t =
    let rec isId' s k' = match s with
      | MShift k   -> k = k'
      | MDot (MV n, s') -> n = k' && isId' s' (k' + 1)
      | _                       -> false
    in
      isId' t 0


(* applyMSub n t = MFt'
     
   Invariant: 

     If    D |- t <= D'    n-th element in D' = A[Psi]
     then  Ft' = Ft_n      if  t = Ft_1 .. Ft_n .. ^0
     and D ; [|t|]Psi |- Ft' <= [|t|]A
  *)

let rec applyMSub n t = 
    begin match (n, t) with
  | (1, MDot (ft, _t)) -> ft
  | (n, MDot (_ft, t)) -> applyMSub (n - 1) t
  | (n, MShift k)       -> MV (k + n)
    end 


end
