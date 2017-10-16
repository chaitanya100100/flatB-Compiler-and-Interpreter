%{
#include "parser.tab.h"
extern FILE * flex_output;
%}


%%

"declblock"    {
                    fprintf(flex_output, "declblock from scanner\n");
                    return DECLBLOCK;
               }


"codeblock"    {
                   fprintf(flex_output, "codeblock from scanner\n");
                   return CODEBLOCK;
               }


"int"      return INT;
"for"      return FOR;
"while"    return WHILE;
"if"       return IF;
"else"     return ELSE;
"goto"     return GOTO;
"print"    return PRINT;
"read"     return READ;


"+"    return '+';
"-"    return '-';
"*"    return '*';
"/"    return '/';
"%"    return '%';

";"    return ';';
","    return ',';

":"    return ':';

"{"    return '{';
"}"    return '}';
"="    return '=';
"["    return '[';
"]"    return ']';
"("    return '(';
")"    return ')';

"<"     return LESS;
">"     return GREATER;
"<="    return LESS_OR_EQUAL;
">="    return GREATER_OR_EQUAL;
"=="    return EQUAL;
"!="    return NOT_EQUAL;


[0-9][0-9]*    {
                   yylval.val = (double)atoi(yytext);
                   fprintf(flex_output, "integer literal: %d\n", yylval.val);
                   return INT_LITERAL;
               }


[a-zA-Z][a-zA-Z0-9]*    {
                            fprintf(flex_output, "identifier: %s\n", yytext);
                            return IDENTIFIER;
                        }


\"(\.|[^\"])*\"    {
                       fprintf(flex_output, "string literal: %s\n", yytext);
                       return STRING_LITERAL;
                   }


[ \t\n]    { /* Do nothing */ }

.    {
         fprintf(flex_output, "Unexpected token encountered: %s\n", yytext);
         return ETOK;
     }
