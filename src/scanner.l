%{
#include "parser.tab.h"
%}

%%

"declblock"				{
							printf("declblock from scanner\n");
							return DECLBLOCK;
						}

"codeblock"				{
							printf("codeblock from scanner\n");
							return CODEBLOCK;
						}

"int"					return INT;
"for"					return FOR;

[0-9][0-9]*				{
							printf("Token type: Number, Lexeme/Token Value: %s\n", yytext);
							return NUMBER;
                		}

[a-zA-Z][a-zA-Z0-9]* 	{
							printf("Token type: Identifier, Lexeme/Token Value: %s\n", yytext);
							return IDENTIFIER;
		     			}
"+"		return '+';
"-"		return '-';
"*"		return '*';
"/"		return '/';

";"		return ';';
","		return ',';

"{"		return '{';
"}"		return '}';
"="		return '=';
"["		return '[';
"]"		return ']';
"("		return '(';
")"		return ')';

[ \t\n]					{ /* Do nothing */ }
.						{
		  					printf("Unexpected token encountered: %s\n", yytext);
		  					return ETOK;
						}
