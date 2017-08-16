%{
#include "parser.tab.h"
%}

%%
"declaration_list"			return declaration_list;
"statement_list"		return statement_list;
[0-9][0-9]*	{  
			printf("Token type: Number, Lexeme/Token Value: %s\n", yytext);  
			return NUMBER; 
                }
[a-zA-Z][a-zA-Z0-9]* {  
			printf("Token type: Identifier, Lexeme/Token Value: %s\n", yytext);  
			return IDENTIFIER; 
		     } 
"+"		return '+';
"-"		return '-';
"*"		return '*';
"{"		return '{';
"}"		return '}';

[ \t]		{ /* Do nothing */ }
.		{ 
		  printf("Unexpected token encountered: %s\n", yytext); 
		  return ETOK;
		}
