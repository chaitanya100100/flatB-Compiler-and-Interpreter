%{
  #include <stdio.h>
  #include <stdlib.h>
  FILE *yyin;
  int yylex (void);
  void yyerror (char const *s);
%}

%token DECLBLOCK CODEBLOCK
%token INT
%token FOR
%token NUMBER
%token IDENTIFIER
%token ETOK

%right '='
%left '+' '-'
%left '*' '/'
%right UMINUS


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
        |    IDENTIFIER '[' NUMBER ']'
;



code_block:    CODEBLOCK '{'  '}'                  { printf("code_block in parser\n"); }
          |    CODEBLOCK '{' statement_list '}'    { printf("code_block in parser\n"); }
;

statement_list:    statement_list statement
              |    statement
;

statement:    expression ';'
         |    FOR IDENTIFIER '=' NUMBER ',' NUMBER '{' '}'
         |    FOR IDENTIFIER '=' NUMBER ',' NUMBER '{' statement_list '}'
         |    FOR IDENTIFIER '=' NUMBER ',' NUMBER ',' NUMBER '{' '}'
         |    FOR IDENTIFIER '=' NUMBER ',' NUMBER ',' NUMBER '{' statement_list '}'
         |    ';'
;

expression:    variable '=' expression
          |    expression '+' expression
          |    expression '-' expression        { printf("subtraction of expression\n"); }
          |    expression '*' expression
          |    expression '/' expression        { printf("divide of expression\n"); }
          |    '-' expression    %prec UMINUS   { printf("unary minus in expression\n"); }
          |    '(' expression ')'
          |    variable                         { printf("variable in expression\n"); }
          |    NUMBER
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
