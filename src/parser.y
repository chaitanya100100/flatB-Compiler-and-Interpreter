%{
  #include <stdio.h>
  #include <stdlib.h>
  FILE *yyin;
  int yylex (void);
  void yyerror (char const *s);
%}

%token DECLBLOCK
%token CODEBLOCK
%token INT
%token NUMBER
%token IDENTIFIER
%token ETOK
%left '+'
%left '*'


%%


program:	decl_block code_block  { printf("program in parser\n"); }

decl_block:     DECLBLOCK '{' '}'                   { printf("decl_block in parser\n"); }
          |     DECLBLOCK '{' declaration_list '}'  { printf("decl_block in parser\n"); }
;

declaration_list:   declaration_list declaration
                |   declaration
;

declaration:    NUMBER ';'
           |    ';'
;

code_block:     CODEBLOCK '{'  '}'                  { printf("code_block in parser\n"); }
          |     CODEBLOCK '{' statement_list '}'    { printf("code_block in parser\n"); }
;

statement_list:     statement_list statement
              |     statement
;

statement:      NUMBER ';'
         |      ';'
%%

void yyerror (char const *s)
{
       fprintf (stderr, "%s\n", s);
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

	yyparse();
}
