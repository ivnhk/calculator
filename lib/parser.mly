%{
    open Ast
%}

%token <int> INT
%token <string> ID
%token TRUE
%token FALSE
%token LEQ
%token TIMES
%token PLUS
%token LPAREN
%token RPAREN
%token LET
%token EQUALS
%token IN
%token IF
%token THEN
%token ELSE
%token EOF

%nonassoc IN
%nonassoc ELSE
%left LEQ
%left PLUS
%left TIMES

%start <Ast.expr> prog

%%
