type bop =
    | Plus
    | Mult
    | Leq

type expr =
    | Var of string
    | Int of int
    | Bool of bool
    | Binop of expr * bop * expr
    | If of expr * expr * expr
    | Let of string * expr * expr
