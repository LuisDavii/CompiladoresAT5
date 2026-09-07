%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex(void);
extern FILE *yyin;
void yyerror(const char *s);
%}

%token STRING
%token NUMBER
%token TRUE
%token FALSE
%token NULL_TOKEN
%token ERROR

%%

input:
    value
    ;

value:
    STRING
    | NUMBER
    | TRUE
    | FALSE
    | NULL_TOKEN
    | object
    | array
    ;

object:
    '{' '}'
    | '{' pair_list '}'
    ;

pair_list:
    pair
    | pair_list ',' pair
    ;

pair:
    STRING ':' value
    ;

array:
    '[' ']'
    | '[' value_list ']'
    ;

value_list:
    value
    | value_list ',' value
    ;

%%

void yyerror(const char *s) {
    (void)s;
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *f = fopen(argv[1], "r");
        if (!f) {
            printf("JSON COM ERRO\n");
            return 0;
        }
        yyin = f;
    }

    if (yyparse() == 0) {
        printf("JSON OK\n");
    } else {
        printf("JSON COM ERRO\n");
    }

    if (yyin && yyin != stdin) {
        fclose(yyin);
    }

    return 0;
}
