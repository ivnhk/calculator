type bop =
    | Add
    | Mult
    | Leq

type expr =
    | Var of string
    | Int of int
    | Bool of bool
    | Binop of bop * expr * expr
    | If of expr * expr * expr
    | Let of string * expr * expr

(** [is_value e] is whether [e] is a value. *)
let is_value : expr -> bool = function
    | Int _ | Bool _ -> true
    | Var _ | Let _ | Binop _ | If _ -> false

(** [subst e v x] is [e{v/x}]. *)
let subst _ _ _ =
    failwith "To implement"

(** [step] is the [-->] relation, that is, a single step of
    evaluation. *)
let rec step = function
    | Int _ | Bool _ -> failwith "Does not step"
    | Var _ -> failwith "Unbound variable"
    | Binop (bop, e1, e2) when is_value e1 && is_value e2 ->
        step_bop bop e1 e2
    | Binop (bop, e1, e2) when is_value e1 ->
        Binop (bop, e1, step e2)
    | Binop (bop, e1, e2) -> Binop (bop, step e1, e2)
    | Let (x, e1, e2) when is_value e1 -> subst e2 e1 x
    | Let (x, e1, e2) -> Let (x, step e1, e2)
    | If (Bool true, e2, _) -> e2
    | If (Bool false, _, e3) -> e3
    | If (Int _, _, _) -> failwith "Guard of if must have type bool"
    | If (e1, e2, e3) -> If (step e1, e2, e3)
(** [step_bop bop v1 v2] implements the primitive operation
    [v1 bop v2].  Requires: [v1] and [v2] are both values. *)
and step_bop bop e1 e2 = match bop, e1, e2 with
    | Add, Int a, Int b -> Int (a + b)
    | Mult, Int a, Int b -> Int (a * b)
    | Leq, Int a, Int b -> Bool (a <= b)
    | _ -> failwith "Operator and operand type mismatch"

(** [eval_big e] is the [e ==> v] relation. *)
let rec eval_big (e : expr) : expr = match e with
  | Int _ | Bool _ -> e
  | Var _ -> failwith "Unbound variable"
  | Binop (bop, e1, e2) -> eval_bop bop e1 e2
  | Let (x, e1, e2) -> subst e2 (eval_big e1) x |> eval_big
  | If (e1, e2, e3) -> eval_if e1 e2 e3
(** [eval_bop bop e1 e2] is the [e] such that [e1 bop e2 ==> e]. *)
and eval_bop bop e1 e2 = match bop, eval_big e1, eval_big e2 with
  | Add, Int a, Int b -> Int (a + b)
  | Mult, Int a, Int b -> Int (a * b)
  | Leq, Int a, Int b -> Bool (a <= b)
  | _ -> failwith "Operator and operand type mismatch"
(** [eval_if e1 e2 e3] is the [e] such that [if e1 then e2 else e3 ==> e]. *)
and eval_if e1 e2 e3 = match eval_big e1 with
  | Bool true -> eval_big e2
  | Bool false -> eval_big e3
  | _ -> failwith "Guard of if must have type bool"
