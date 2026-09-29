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
"$"     { return LABEL; }

//the name of variables or functions
[a-zA-Z]+   { return NAME; } //one or more letters a-Z

"%"     { return VARREF; }
"/"     { return OPSTART; }
"="     { return OPTPAIR; }
"."     { return CMDSEP; }
"("     { return LPAR; }
")"     { return RPAR; }
"{"     { return LBRACE; }
"}"     { return RBRACE; }

//NOT COMPLETE YET WILL COME BACK TO THIS

//look for this in parser
"-"     { return MINUS; } //FLOATS optional negative sign

[0-9]+  { return INT; } //can use yylint or somethign like that

[0-9]+.[0-9]+   { return FLOAT; } //can slost use yyfloat but i forgot how

[a-zA-Z][a-zA-Z0-9]+    { return SYM; }

//given string token creates string return something
\"([^\\\"]|\\.)*\" { yylval->str_temp = strdup(yytext); return STRING} //WIP

[ \n\r\f\t]*  { continue; } //this is for white spaces

%%
