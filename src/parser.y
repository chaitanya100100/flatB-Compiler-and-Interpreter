%{

#include <stdio.h>
#include <stdlib.h>
#include "AST.h"

extern FILE *yyin;
int yylex (void);
void yyerror (char const *s);

FILE * flex_output;
FILE * bison_output;

extern union _NODE_ yylval;
AST_program * main_program;

%}


/*
================ tokens ===================
*/

%start program

%type <program> program
%type <decl_block> decl_block
%type <decl_block> decl_statement_list
%type <decl_statement> decl_statement
%type <decl_statement> decl_variable_list
%type <decl_variable> decl_variable

%type <code_block> code_block
%type <block_statement> statement_block
%type <block_statement> statement_list
%type <statement> statement
%type <read_statement> read_variable_list
%type <variable> variable
%type <print_statement> printable_list
%type <expression> expression

%token ETOK

%right '='

%left OR
%left AND
%left EQUAL NOT_EQUAL
%left LESS LESS_OR_EQUAL GREATER GREATER_OR_EQUAL
%left '+' '-'
%left '*' '/' '%'
%right UMINUS

%token <string_val> STRING_LITERAL
%token <string_val> IDENTIFIER
%token <int_val> INT_LITERAL
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


program:    decl_block code_block
            {
                fprintf(bison_output, "program\n");
                $$ = new AST_program($1, $2);
                main_program = $$;
            }
;


decl_block:    DECLBLOCK '{' '}'
               {
                   fprintf(bison_output, "decl_block\n");
                   $$ = new AST_decl_block();
               }

          |    DECLBLOCK '{' decl_statement_list '}'
               {
                   fprintf(bison_output, "decl_block\n");
                   $$ = $3;
               }
;

decl_statement_list:   decl_statement_list decl_statement
                       {
                           $$->push_back($2);
                       }
                       |   decl_statement
                       {
                           $$ = new AST_decl_block();
                           $$->push_back($1);
                       }
;


decl_statement:    INT decl_variable_list';'
                   {
                       fprintf(bison_output, "decl_statement\n");
                   }
              |    ';'
                   {
                       fprintf(bison_output, "decl_statement empty\n");
                       $$ = new AST_decl_statement();
                   }
;

decl_variable_list:    decl_variable_list ',' decl_variable
                       {
                           $$->push_back($3);
                       }
                  |    decl_variable
                       {
                           $$ = new AST_decl_statement();
                           $$->push_back($1);
                       }
;

decl_variable:    IDENTIFIER
                  {
                      $$ = new AST_decl_int_single($1);
                  }
             |    IDENTIFIER '[' INT_LITERAL ']'
                  {
                      $$ = new AST_decl_int_array($1, $3);
                  }
;



code_block:    CODEBLOCK '{' '}'
               {
                   fprintf(bison_output, "code_block empty\n");
                   $$ = new AST_code_block(new AST_block_statement());
               }
          |    CODEBLOCK '{' statement_list '}'
               {
                   fprintf(bison_output, "code_block\n");
                   $$ = new AST_code_block($3);
               }
;


statement_block:    '{' '}'
                    {
                        fprintf(bison_output, "statement_block empty\n");
                        $$ = new AST_block_statement();
                    }
               |    '{' statement_list '}'
                    {
                        fprintf(bison_output, "statement_block\n");
                        $$ = $2;
                    }
;

statement_list:    statement_list statement
                   {
                       $$->push_back($2);
                   }
              |    statement
                   {
                       $$ = new AST_block_statement();
                       $$->push_back($1);
                   }
;

statement:    expression ';'
              {
                  $$ = new AST_expression_statement($1);
              }
         |    variable '=' expression ';'
              {
                  $$ = new AST_assignment_statement($1, $3);
              }
         |    statement_block
              {
                  $$ = $1;
              }
         |    IF expression statement_block
              {
                  $$ = new AST_if_statement($2, $3);
              }
         |    IF expression statement_block ELSE statement_block
              {
                  $$ = new AST_ifelse_statement($2, $3, $5);
              }
         |    FOR variable '=' expression ',' expression statement_block
              {
                  $$ = new AST_for_statement($2, $4, $6, $7);
              }
         |    FOR variable '=' expression ',' expression ',' expression statement_block
              {
                  $$ = new AST_for_statement($2, $4, $6, $8, $9);
              }
         |    WHILE expression statement_block
              {
                  $$ = new AST_while_statement($2, $3);
              }
         |    GOTO IDENTIFIER ';'
              {
                  $$ = new AST_goto_statement(string($2));
              }
         |    GOTO IDENTIFIER IF expression ';'
              {
                  $$ = new AST_goto_statement($4, string($2));
              }
         |    READ read_variable_list ';'
              {
                  $$ = $2;
              }
         |    PRINT printable_list ';'
              {
                  $$ = $2;
              }
         |    IDENTIFIER ':'
              {
                  $$ = new AST_label_statement(string($1));
              }
/*
small hack
*/
         |    ';'
              {
                  $$ = new AST_expression_statement(new AST_int_literal(1));
              }

;


expression:    expression '+' expression
               {
                   $$ = new AST_binary_operator_expression($1, $3, "+");
               }
          |    expression '-' expression
               {
                   $$ = new AST_binary_operator_expression($1, $3, "-");
               }
          |    expression '*' expression
               {
                   $$ = new AST_binary_operator_expression($1, $3, "*");
               }
          |    expression '/' expression
               {
                   $$ = new AST_binary_operator_expression($1, $3, "/");
               }
          |    expression '%' expression
               {
                   $$ = new AST_binary_operator_expression($1, $3, "%");
               }
          |    expression LESS expression
               {
                   $$ = new AST_binary_operator_expression($1, $3, "<");
               }
          |    expression LESS_OR_EQUAL expression
               {
                   $$ = new AST_binary_operator_expression($1, $3, "<=");
               }
          |    expression GREATER expression
               {
                   $$ = new AST_binary_operator_expression($1, $3, ">");
               }
          |    expression GREATER_OR_EQUAL expression
               {
                   $$ = new AST_binary_operator_expression($1, $3, ">=");
               }
          |    expression EQUAL expression
               {
                   $$ = new AST_binary_operator_expression($1, $3, "==");
               }
          |    expression NOT_EQUAL expression
               {
                   $$ = new AST_binary_operator_expression($1, $3, "!=");
               }
          |    expression OR expression
               {
                   $$ = new AST_binary_operator_expression($1, $3, "||");
               }
          |    expression AND expression
               {
                   $$ = new AST_binary_operator_expression($1, $3, "&&");
               }
          |    '-' expression    %prec UMINUS
               {
                   $$ = new AST_unary_operator_expression($2, "-");
               }
          |    '(' expression ')'
               {
                   $$ = $2;
               }
          |    variable
               {
                   $$ = $1;
               }
          |    INT_LITERAL
               {
                   $$ = new AST_int_literal($1);
               }
;


variable:    IDENTIFIER
             {
                 $$ = new AST_variable_single_int(string($1));
             }
        |    IDENTIFIER '[' expression ']'
             {
                 $$ = new AST_variable_array_int(string($1), $3);
             }
;

read_variable_list:    read_variable_list ',' variable
                       {
                           $$->push_back($3);
                       }
                  |    variable
                       {
                           $$ = new AST_read_statement();
                           $$->push_back($1);
                       }
;


printable_list:    printable_list ',' STRING_LITERAL
                   {
                       $$->push_back(new AST_string_literal(string($3)));
                   }
              |    printable_list ',' expression
                   {
                       $$->push_back($3);
                   }
              |    STRING_LITERAL
                   {
                       $$ = new AST_print_statement();
                       $$->push_back(new AST_string_literal(string($1)));
                   }
              |    expression
                   {
                       $$ = new AST_print_statement();
                       $$->push_back($1);
                   }
;


/*
// this will create conflicts because the precedence rule apply only when there
// two rules of same NT which are conflicting.

expression:    variable '=' expression
          |    expression operator expression
          |    '-' expression    %prec UMINUS
          |    '(' expression ')'
          |    variable
;

operator:    relational_operator
        |    arithmetic_operator
;

relational_operator:    LESS
                   |    GREATER
                   |    LESS_OR_EQUAL
                   |    GREATER_OR_EQUAL
                   |    EQUAL
                   |    NOT_EQUAL
;

arithmetic_operator:    '+'
                   |    '-'
                   |    '*'
                   |    '/'
                   |    '%'
;
*/

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


    flex_output = fopen("flex_output.txt", "w");
    bison_output = fopen("bison_output.txt", "w");

	yyin = fopen(argv[1], "r");

	int return_val = yyparse();
    fprintf(bison_output, "\nRETURN VALUE : %d\n", return_val);

    Traverse v;
    main_program->accept(v);
    return 0;
}
