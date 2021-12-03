%{

#include <stdio.h>
#include <stdlib.h>
void yyerror();
void yywrap();
extern float value[20];
int flag=0;

%}
%union
{
    int ival;
    float fval;
}
%token <ival> N 
%token <ival> ID
%token <fval> FN
%type <fval> E

%right '='
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'

%%
St : St S
    | S
    ;
S: E ';' {printf("Answer is %f \n",$1);}
    ;
E : E '+' E {$$=$1+$3;}
    | E '-' E {$$=$1-$3;}
    | E '*' E {$$=$1*$3;}
    | E '/' E {$$=$1/$3;}
    | ID '=' E {$$=value[$1]=$3;}
    |  N {$$=$1;}
    |  FN {$$=$1;} 
    |  ID {$$=value[$1];}
    ;
%%
int main(){
    printf("\nEnter the Arithmetic Expression: ");
    yyparse();
    if(flag==0)
    {
        printf("\nIt's an Valid Arithmetic Expression.");
    }
}
void yyerror()
{
    printf("\nIt's an Invalid Arithmetic Expression.");
    flag=1;
}