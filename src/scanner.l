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
"while"					return WHILE;
"if"					return IF;
"else"					return ELSE;
"goto"					return GOTO;
"print"					return PRINT;
"read"					return READ;


"+"		return '+';
"-"		return '-';
"*"		return '*';
"/"		return '/';
"%"		return '%';

";"		return ';';
","		return ',';

":"		return ':';

"{"		return '{';
"}"		return '}';
"="		return '=';
"["		return '[';
"]"		return ']';
"("		return '(';
")"		return ')';

"<"		return LESS;
">"		return GREATER;
"<="	return LESS_OR_EQUAL;
">="	return GREATER_OR_EQUAL;
"=="	return EQUAL;
"!="	return NOT_EQUAL;


[0-9][0-9]*				{
							printf("Token type: Number, Lexeme/Token Value: %s\n", yytext);
							return NUMBER;
                		}

[a-zA-Z][a-zA-Z0-9]* 	{
							printf("Token type: Identifier, Lexeme/Token Value: %s\n", yytext);
							return IDENTIFIER;
		     			}

\"(\.|[^\"])*\"			{
							printf("Token type: string, Lexeme/Token Value: %s\n", yytext);
							return STRING;
						}


[ \t\n]					{ /* Do nothing */ }
.						{
		  					printf("Unexpected token encountered: %s\n", yytext);
		  					return ETOK;
						}
