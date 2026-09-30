%{ //this FIRST 
//this code here in.l will break the input down into tokens
//parser then the.y will take these tokens in turn them into non-tokens/variables to see if its valid

#include "cmd_data.h"
#include "cmd_parse.h"
#include <stdio.h>

/* The following definition ensures that helpful syntax errors are printed: do not  */
#define YY_USER_ACTION \
    yylloc->first_line = yylloc->last_line; \
    yylloc->first_column = yylloc->last_column; \
    for(int i = 0; yytext[i] != '\0'; i++) { \
        if(yytext[i] == '\n') { \
            yylloc->last_line++; \
            yylloc->last_column = 0; \
        } \
        else { \
            yylloc->last_column++; \
        } \
    }

/* The definition below allows for interactive input. */
#define YY_USER_INIT \
  yy_set_interactive(yyin == stdin);

%}

%option outfile="cmd_lex.c" header-file="cmd_lex.h"
%option reentrant noyywrap
%option bison-bridge bison-locations

%% //working in here
//use the regex stuff to return a token like "{" return LBRACE

//functions start with a $name
"$[a-zA-Z]+"     { return LABEL; }

"%"     { return VARREF; }
"/"     { return OPSTART; }
"="     { return OPTPAIR; }
"."     { return CMDSEP; }
"("     { return LPAR; }
")"     { return RPAR; }
"{"     { return LBRACE; }
"}"     { return RBRACE; }

//returns int with value
[1-9][0-9]*     { yylval.num = atoi(yytext); return INT; }

-?(0\.[0-9]|[1-9][0-9]*\.[0-9]+) { yyval.flt = atof(yytext); return FLOAT; }

[a-zA-Z][a-zA-Z0-9]+    { yylval->str_temp= strdup(yytext); return SYM; }

\"([^\\\"]|\\.)*\" { yylval->str_temp = strdup(yytext); return STRING}

[ \n\r\f\t]*  { continue; } //this is for white spaces

%%
