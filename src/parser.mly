%{
open Ast
%}

%token <int> INT
%token <string> ID
%token <float> FLOAT
%token TRUE
%token FALSE
%token LEQ
%token GEQ
%token TIMES
%token DIVIDE
%token PLUS
%token MINUS
%token TIMESF
%token DIVIDEF
%token PLUSF
%token MINUSF
%token LPAREN
%token RPAREN
%token LET
%token EQUALS
%token IN
%token IF
%token THEN
%token ELSE
%token COLON
%token INT_TYPE
%token BOOL_TYPE
%token FLOAT_TYPE
%token EOF

%nonassoc IN
%nonassoc ELSE
%left LEQ
%left GEQ
%left PLUS
%left MINUS
%left TIMES
%left DIVIDE
%left PLUSF
%left MINUSF
%left TIMESF
%left DIVIDEF

%start <Ast.expr> prog

%%

prog:
	| e = expr; EOF { e }
	;
	
expr:
	| i = INT { Int i }
  | x = ID { Var x }
  | f = FLOAT { Float f }
  | TRUE { Bool true }
  | FALSE { Bool false }
  | e1 = expr; LEQ; e2 = expr { Binop (Leq, e1, e2) }
  | e1 = expr; GEQ; e2 = expr { Binop (Geq, e1, e2) }
  | e1 = expr; TIMES; e2 = expr { Binop (Mult, e1, e2) }
  | e1 = expr; DIVIDE; e2 = expr { Binop (Div, e1, e2) }
  | e1 = expr; PLUS; e2 = expr { Binop (Add, e1, e2) }
  | e1 = expr; MINUS; e2 = expr { Binop (Sub, e1, e2) }
  | e1 = expr; TIMESF; e2 = expr { Binop (MultF, e1, e2) }
  | e1 = expr; DIVIDEF; e2 = expr { Binop (DivF, e1, e2) }
  | e1 = expr; PLUSF; e2 = expr { Binop (AddF, e1, e2) }
  | e1 = expr; MINUSF; e2 = expr { Binop (SubF, e1, e2) }
  | LET; x = ID; COLON; t = typ; EQUALS; e1 = expr; IN; e2 = expr 
		{ Let (x, t, e1, e2) }
  | IF; e1 = expr; THEN; e2 = expr; ELSE; e3 = expr { If (e1, e2, e3) }
  | LPAREN; e=expr; RPAREN {e}
	;

typ: 
	| INT_TYPE { TInt }
	| BOOL_TYPE { TBool }
  | FLOAT_TYPE { TFloat }