%{
  #include <stdio.h>
  #include <stdlib.h>
  FILE *yyin;
  int yylex (void);
  void yyerror (char const *s);
%}

%token declaration_list
%token statement_list
%token NUMBER
%token IDENTIFIER
%token ETOK
%left '+'
%left '*'

%%

program:	decl_block code_block

decl_block:  '{' declaration_list '}'

code_block:  '{' statement_list '}'

/*
expr	: 	expr '+' expr 
	|	expr '*' expr 
	| 	NUMBER
	|	IDENTIFIER
	;
*/

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
