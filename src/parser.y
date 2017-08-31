%{
  #include <stdio.h>
  #include <stdlib.h>
  FILE *yyin;
  int yylex (void);
  void yyerror (char const *s);
%}


%token ETOK

%right '='

%left EQUAL
%left NOT_EQUAL

%left LESS
%left LESS_OR_EQUAL
%left GREATER
%left GREATER_OR_EQUAL

%left '+' '-'
%left '*' '/'
%right UMINUS

%token IDENTIFIER
%token NUMBER
%token GOTO
%token WHILE
%token FOR
%token IF
%token INT
%token DECLBLOCK CODEBLOCK

%%


program:    decl_block code_block  { printf("program in parser\n"); }

decl_block:    DECLBLOCK '{' '}'                   { printf("decl_block in parser\n"); }
          |    DECLBLOCK '{' declaration_list '}'  { printf("decl_block in parser\n"); }
;

declaration_list:    declaration_list declaration_statement
                |    declaration_statement
;

declaration_statement:    INT variable_list';'
                     |    ';'
;

variable_list:    variable_list ',' variable
             |    variable
;

variable:    IDENTIFIER
        |    IDENTIFIER '[' IDENTIFIER ']'
        |    IDENTIFIER '[' NUMBER ']'
;


code_block:    CODEBLOCK '{'  '}'                  { printf("code_block in parser\n"); }
          |    CODEBLOCK '{' statement_list '}'    { printf("code_block in parser\n"); }
;

statement_list:    statement_list statement
              |    statement
;

statement:    expression ';'
         |    IDENTIFIER ':'
         |    FOR IDENTIFIER '=' NUMBER ',' NUMBER '{' '}'
         |    FOR IDENTIFIER '=' NUMBER ',' NUMBER '{' statement_list '}'
         |    FOR IDENTIFIER '=' NUMBER ',' NUMBER ',' NUMBER '{' '}'
         |    FOR IDENTIFIER '=' NUMBER ',' NUMBER ',' NUMBER '{' statement_list '}'
         |    WHILE condition '{' '}'
         |    WHILE condition '{' statement_list '}'
         /*No need for dual goto rule*/
         |    GOTO IDENTIFIER optional_goto_condition ';'
         |    ';'
;

optional_goto_condition :    /*empty*/
                        |    IF condition
;

expression:    variable '=' expression          { printf("assignment of expression\n"); }
          |    expression '+' expression
          |    expression '-' expression        { printf("subtraction of expression\n"); }
          |    expression '*' expression
          |    expression '/' expression        { printf("divide of expression\n"); }
          |    '-' expression    %prec UMINUS   { printf("unary minus in expression\n"); }
          |    '(' expression ')'
          |    variable                         { printf("variable in expression\n"); }
          |    NUMBER
;


condition:    expression relational_operator expression
;

relational_operator:    LESS
                   |    GREATER
                   |    LESS_OR_EQUAL
                   |    GREATER_OR_EQUAL
                   |    EQUAL
                   |    NOT_EQUAL {printf("not equal\n");}
;


%%



void yyerror (char const *s)
{
        fprintf (stderr, "----------------ERROR----------------\n");
        fprintf (stderr, "%s\n", s);
        fprintf (stderr, "----------------ERROR----------------\n");
}

int main(int argc, char *argv[])
{
	if (argc == 1 ) {
		fprintf(stderr, "Correct usage: bcc filename\n");
		exit(1);
	}

	if (argc > 2) {
		fprintf(stderr, "Passing more arguments than necessary.\n");
		fprintf(stderr, "Correct usage: bcc filename\n");
	}

	yyin = fopen(argv[1], "r");

	int return_val = yyparse();
    printf("\nRETURN VALUE : %d\n", return_val);
}
