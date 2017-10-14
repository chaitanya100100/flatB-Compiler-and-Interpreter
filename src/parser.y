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
%left '%'
%right UMINUS

%token STRING
%token IDENTIFIER
%token NUMBER
%token READ
%token PRINT
%token GOTO
%token WHILE
%token FOR
%token ELSE
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
        |    IDENTIFIER '[' value_holder ']'
;

value_holder:    variable
            |    NUMBER
;



code_block:    CODEBLOCK statement_block
;

statement_block:    '{' '}'
               |    '{' statement_list '}'
;

statement_list:    statement_list statement
              |    statement
;

statement:    expression ';'
         |    IDENTIFIER ':'
         |    IF condition '{' statement_list '}' optional_else
         |    FOR variable '=' value_holder ',' value_holder statement_block
         |    FOR variable '=' value_holder ',' value_holder ',' value_holder statement_block
         |    WHILE condition statement_block
         /*No need for dual goto rule*/
         |    GOTO IDENTIFIER optional_goto_condition ';'
         |    READ variable_list ';'
         |    PRINT print_block ';'
         |    ';'
;

optional_else:    /*empty*/
             |    ELSE statement_block

optional_goto_condition :    /*empty*/
                        |    IF condition
;

expression:    variable '=' expression
          |    expression '+' expression
          |    expression '-' expression
          |    expression '*' expression
          |    expression '/' expression
          |    expression '%' expression
          |    '-' expression    %prec UMINUS
          |    '(' expression ')'
          |    value_holder
;

condition:    expression relational_operator expression
;

relational_operator:    LESS
                   |    GREATER
                   |    LESS_OR_EQUAL
                   |    GREATER_OR_EQUAL
                   |    EQUAL
                   |    NOT_EQUAL
;

print_block:    print_block ',' print_atom
           |    print_atom
;

print_atom:    STRING
          |    expression

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
