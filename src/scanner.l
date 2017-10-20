%{
#include "AST.h"
#include "parser.tab.h"

extern FILE * flex_output;
extern union _NODE_ yylval;

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
"||"    return OR;
"&&"    return AND;


[0-9][0-9]*    {
                   yylval.int_val = atoi(yytext);
                   fprintf(flex_output, "integer literal: %s\n", yytext);
                   return INT_LITERAL;
               }


[a-zA-Z][a-zA-Z0-9]*    {
                            yylval.string_val = strdup(yytext);
                            fprintf(flex_output, "identifier: %s\n", yytext);
                            return IDENTIFIER;
                        }


\"(\.|[^\"])*\"    {
                       yylval.string_val = strdup(yytext);
                       fprintf(flex_output, "string literal: %s\n", yytext);
                       return STRING_LITERAL;
                   }


[ \t\n]    { /* Do nothing */ }

.    {
         fprintf(flex_output, "Unexpected token encountered: %s\n", yytext);
         return ETOK;
     }
