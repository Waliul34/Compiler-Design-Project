%{
    #include <stdlib.h>
	#include <stdio.h>
	#include <string.h>
	#include <math.h>
	int yylex(void);
    void yyerror(char *s);
	FILE *yyin, *yyout;
    int sym[26];

%}



%token MAIN LP RP LB RB DSEMI VAR NUM INT LONG DOUBLE SCANF LTEQ
PRINTF FOR ADD SUB DIV MUL MOD EQUAL WHILE ELSEIF ELSE IF MAX MIN 
%left ADD SUB
%left MUL DIV
%left MOD

%%

program: MAIN LP code RP
		;

code: /* NULL */

	| code statement
	
	;
	
statement: declaration

		|	expression DSEMI			{ $$ = $1; }
		
		|	VAR '=' expression DSEMI	{
										sym[$1] = $3;
										printf("Value of the variable : %d\n", $3);
										$$=$3;
										}
										
		| PRINTF LB expression RB DSEMI { printf("Print value : %d\n", $3); }
		
		| condition
		
		| for_code
		
		| while_code
		
		| max_code
		
		| min_code
		
		| SCANF LB expression RB DSEMI { printf("Read for variable \n"); }
		
		|
		
		;

declaration: TYPE ID1 DSEMI;
			
TYPE: INT | LONG | DOUBLE ;
			
ID1: ID1 ',' VAR 

	| VAR 		{ printf("Variable declared\n"); }
	
	;
	
expression: NUM			{ $$ = $1; }

		| VAR 			{ $$ = sym[$1]; }
		
		| expression ADD expression { $$ = $1 + $3; }
		
		| expression SUB expression { $$ = $1 - $3; }
		
		| expression MUL expression { $$ = $1 * $3; }
		
		| expression DIV expression {
										if($3)
										{ $$ = $1 / $3; }
										else
										{ $$ = 0;
										printf("Division by zero occured\n"); }
									}
									
		| expression MOD expression {
										if($3)
										{ $$ = $1 % $3; }
										else
										{ $$ = 0;
										printf("MOD by zero\n"); }
									}
									
		| expression '<' expression { $$ = $1 < $3; }
		
		| expression '>' expression { $$ = $1 > $3; }
		
		| expression LTEQ expression { $$ = $1 <= $3; }
		
		| expression '>=' expression { $$ = $1 >= $3; }
		
		| expression '!=' expression { $$ = $1 != $3; }
		
		| expression EQUAL expression { $$ = $1 == $3; }
		
		| LP expression RP            { $$ = $2; }

condition: IF LB expression RB LP statement RP else_if elsee {
			printf("IF condition detected\n");
			int i = $3;
			if(i == 1) {
				printf("IF condition is true\n");
				printf("Value inside IF : %d\n", $6);
			}
			else{
				printf("IF condition is false\n");
			}
		}
		;

else_if: ELSEIF LB expression RB LP statement RP else_if {
			printf("ELSE IF condition detected\n");
			int i = $3;
			if(i == 1) {
				printf("ELSE IF condition is true\n");
				printf("Value inside ELSE IF : %d\n", $6);
			}
			else{
				printf("ELSE IF condition is false\n");
			}		
		}
		
		|
		
		;
elsee:	ELSE LP statement RP	{
							printf("ELSE is detected\n"); 
							
						}
	
	|
	
	;

for_code: FOR LB statement expression '<' expression RB LP statement RP {
			printf("FOR LOOP is detected\n");
			int i, j, v;
			i = $4;
			j = $6;
			v = $9;
			for( ; i < j; i++) {
				printf("Value of the loop: %d\n", i);
				printf("Value of the expression inside loop: %d\n", v);
			}
		}
		
		|
		
		FOR LB statement expression '>' expression RB LP statement RP {
			printf("FOR LOOP is detected\n");
			int i, j, v;
			i = $4;
			j = $6;
			v = $9;
			for( ; i > j; i--) {
				printf("Value of the loop: %d\n", i);
				printf("Value of the expression inside loop: %d\n", v);
			}
		}
		
		| FOR LB statement expression LTEQ expression RB LP statement RP {
			printf("FOR LOOP is detected\n");
			int i, j, v;
			i = $4;
			j = $6;
			v = $9;
			for( ; i <= j; i++) {
				printf("Value of the loop: %d\n", i);
				printf("Value of the expression inside loop: %d\n", v);
			}
		}
	
	;
	
while_code:	WHILE LB expression RB LP statement RP {
			printf("WHILE LOOP is detected\n");
			int i, v;
			i = $3;
			v = $6;
			if(i == 1) {
				printf("While loop running\n"); 
				printf("Value of the expression inside loop: %d\n", v);
			}
		}
	;
	
max_code: MAX LB expression ',' expression RB DSEMI {
				int i, j;
				i = $3;
				j = $5;
				if(i > j)
					printf("Maximum value is : %d\n", i);
				else
					printf("Maximum value is : %d\n", j);
			}
		;
		
min_code: MIN LB expression ',' expression RB DSEMI {
				int i, j;
				i = $3;
				j = $5;
				if(i > j)
					printf("Minimum value is : %d\n", j);
				else
					printf("Minimum value is : %d\n", i);
			}
		;

%%



void yyerror(char *s) {

    printf("%s\n", s);

}


int main()
{
	yyin=freopen("input.txt", "r", stdin);
	yyout=freopen("output.txt", "w", stdout);
	
	yyparse();
	return 0;
}
