%{
    #include "1807034.tab.h"
    #include <stdlib.h>
	#include <stdio.h>
	#include <string.h>
	extern char* strdup(const char*);
    void yyerror(char *);
%}

%%

[ \t]+
 
[/][s][/].* { printf("this is single line comment\n"); }
 
[/][m][/][a-zA-Z0-9\-{}();<>=+*/&\n\t ]*[/][m][/] { printf("this is multiple line comment\n"); }
 
"#ano "[<][a-zA-Z]+.[h][>] { printf("Header file has been detected\n"); }
 
"number muul{}" { return MAIN; }
 
"(" { return LP; }
")" { return RP; }

"{" { return LB; }
"}" { return RB; }

";;" { return DSEMI; }

[a-zA-Z] { yylval = *yytext - 'a'; return VAR; }

[-|+]?[0-9]+ { yylval = atoi(yytext); return NUM; }
 
"number" { return INT; }
 
"boro" { return LONG; }
 
"doshomik" { return DOUBLE; }
 
"nao" { return SCANF; }
 
"dekhao" { return PRINTF; }
 
"ghuro" { return FOR; }

"add" { return ADD; }

"sub" { return SUB; }

"div" { return DIV; }

"mul" { return MUL; }

"mod" { return MOD; }
 
"somansoman" { return EQUAL; }
 
"jotokkhon" { return WHILE; } 
 
"r jodi" { return ELSEIF; }
 
"jodi" { return IF; }
 
"noyto" { return ELSE; }

"MAX" { return MAX; }

"MIN" { return MIN; }

"<="  { return LTEQ; }

"ret "[a-zA-Z0-9]+";;" { printf("Value returned\n"); }

[-+/*<>=,:;%] { return *yytext; }

.			{ printf("%s --> Invalid\n", yytext); }
[\n]	{}
 
%%
 
int yywrap()
{
	return 1;
}