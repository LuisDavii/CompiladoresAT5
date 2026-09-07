%{
#include "valida.tab.h"
%}

%option noyywrap
%option nounput
%option noinput

%%

[ \t\r\n]+                     { /* ignora espacos em branco e quebras de linha */ }

"true"                         { return TRUE; }
"false"                        { return FALSE; }
"null"                         { return NULL_TOKEN; }

\"[^\"\r\n]*\"                 { return STRING; }

-?(0|[1-9][0-9]*)(\.[0-9]+)?   { return NUMBER; }

"{"                            { return '{'; }
"}"                            { return '}'; }
"["                            { return '['; }
"]"                            { return ']'; }
":"                            { return ':'; }
","                            { return ','; }

.                              { return ERROR; }

%%
