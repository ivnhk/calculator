open Interp.Ast

let parse (s : string) : expr =
  let lexbuf = Lexing.from_string s in
  let ast = Interp.Parser.prog Interp.Lexer.read lexbuf in
  ast

(* TODO: remove this. For testing purposes only *)
let rec string_of_tokens = function
  | Int i -> Printf.sprintf "Int(%d)" i
  | Bool b -> Printf.sprintf "Bool(%b)" b
  | Var x -> Printf.sprintf "Var(%s)" x
  | Binop (op, e1, e2) ->
      let op_str = match op with
        | Add -> "Add"
        | Mult -> "Mult"
        | Leq -> "Leq"
      in
      Printf.sprintf "Binop(%s, %s, %s)" op_str (string_of_tokens e1) (string_of_tokens e2)
  | If (e1, e2, e3) ->
      Printf.sprintf "If(%s, %s, %s)" (string_of_tokens e1) (string_of_tokens e2) (string_of_tokens e3)
  | Let (x, e1, e2) ->
      Printf.sprintf "Let(%s, %s, %s)" x (string_of_tokens e1) (string_of_tokens e2)

let () =
  let s = read_line () in
  let ast = parse s in
  print_endline (string_of_tokens ast)
