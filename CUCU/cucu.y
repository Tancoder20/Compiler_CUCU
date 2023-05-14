%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
   
    int yylex();
    int yyerror(char *st);
    int yywrap();
    
    FILE *yyout,*parse;
    int yyerror(char *st)
    {
    fprintf(parse,"\n%s",st);
    }
 
%}

%union{
	int number;
	char *string;
}

%token IfKeyword ElseKeyword WhileKeyword ReturnKeyword CommaSymbol LeftParenthesis RightParenthesis LeftSquareBracket RightSquareBracket LeftCurlyBracket RightCurlyBracket LogicalOR LogicalAND BitwiseOR BitwiseAND EqualityComparison NonEqualityComparison GreaterThanEqualToComparison LessThanEqualToComparison AssignSymbol LessThanComparison GreaterThanComparison AdditionOperator SubtractionOperator MultiplicationOperator DivisionOperator Semicolon String InvalidToken

%token <string> DataType;
%token <string> Identifier ;
%token <number> Number ;

%%
code : var_dec | var_def | function_dec | function_def | var_dec code | var_def code | function_dec code | function_def code | ;

var_dec : DataType Identifier Semicolon {fprintf(parse,"TYPE:%s IDENTIFIER:%s\n",$1,$2);} ;
var_def : DataType Identifier AssignSymbol exp Semicolon {fprintf(parse,"TYPE:%s IDENTIFIER:%s\n",$1,$2);} ;
function_dec : DataType Identifier LeftParenthesis parameter_list RightParenthesis Semicolon {fprintf(parse,"FUNCTION TYPE:%s FUNCTION NAME:%s\n",$1,$2);} ;

parameter_list : parameter CommaSymbol parameter_list | parameter | ;

parameter : DataType Identifier {fprintf(parse,"FUNCTION PARAM:%s TYPE:%s\n",$2,$1);} ;

function_def : DataType Identifier LeftParenthesis parameter_list RightParenthesis LeftCurlyBracket stmts RightCurlyBracket {fprintf(parse,"FUNCTION TYPE:%s FUNCTION NAME:%s\n",$1,$2);} ;

stmts : stmts stmt | stmt | ;

stmt : DataType Identifier Semicolon {fprintf(parse,"TYPE:%s IDENTIFIER:%s\n ",$1,$2);} 
       | DataType Identifier AssignSymbol exp Semicolon {fprintf(parse,"TYPE:%s IDENTIFIER:%s\n ",$1,$2);}
       | Identifier AssignSymbol exp Semicolon {fprintf(parse,"IDENTIFIER:%s\n ",$1); }
       | DataType Identifier AssignSymbol String Semicolon {fprintf(parse,"TYPE:%s IDENTIFIER:%s\n ",$1,$2);}
       | Identifier AssignSymbol String Semicolon {fprintf(parse,"IDENTIFIER:%s\n ",$1); }
       | WhileKeyword LeftParenthesis exp RightParenthesis LeftCurlyBracket stmts RightCurlyBracket {fprintf(parse,"KEYWORD:WHILE\n ");} 
       | IfKeyword LeftParenthesis exp RightParenthesis LeftCurlyBracket stmts RightCurlyBracket {fprintf(parse,"KEYWORD:IF \n ");} 
       | IfKeyword LeftParenthesis exp RightParenthesis LeftCurlyBracket stmts RightCurlyBracket ElseKeyword LeftCurlyBracket stmts RightCurlyBracket {fprintf(parse,"KEYWORD:IF KEYWORD:ELSE\n ");} 
       | ReturnKeyword exp Semicolon {fprintf(parse,"KEYWORD:RETURN \n ");}  
       | Identifier LeftParenthesis exp_list RightParenthesis {fprintf(parse,"FUNCTION CALL:%s\n ",$1);}  
       | exp Semicolon 
       
exp_list : exp_list CommaSymbol exp | exp ;

exp:|compare LogicalAND exp {fprintf(parse,"LOGICAL_AND ");}
    |compare BitwiseAND exp {fprintf(parse,"BITWISE_AND ");}
    |compare LogicalOR exp {fprintf(parse,"LOGICAL_OR ");}
    |compare BitwiseOR exp {fprintf(parse,"BITWISE_OR ");}
    |compare

compare: compare EqualityComparison sum {fprintf(parse,"IS_EQUAL_TO ");}
    |compare NonEqualityComparison sum {fprintf(parse,"IS_NOT_EQUAL_TO ");}
    |compare GreaterThanEqualToComparison sum {fprintf(parse,"GREATER_THAN_EQUAL ");}
    |compare LessThanEqualToComparison sum {fprintf(parse,"LESS_THAN_EQUAL ");}
    |compare GreaterThanComparison sum {fprintf(parse,"GREATER_THAN ");}
    |compare LessThanComparison sum {fprintf(parse,"LESS_THAN ");}
    |sum

sum: muldiv AdditionOperator sum {fprintf(parse,"ADDITION ");}
    |muldiv SubtractionOperator sum  {fprintf(parse,"SUBTRACTION ");}
    |muldiv

muldiv : fac MultiplicationOperator muldiv {fprintf(parse,"MULTIPLICATION ");}
	| fac DivisionOperator muldiv  {fprintf(parse,"DIVISION ");}
    | fac

fac : id 
	| LeftParenthesis exp RightParenthesis

id: Identifier {fprintf(parse,"IDENTIFIER-%s ",$1);}
	| Number {fprintf(parse,"CONST-%d ",$1);}
    | Identifier LeftSquareBracket exp RightSquareBracket {fprintf(parse,"ARRAY_VARIABLE-%s ",$1);}
    | Identifier LeftParenthesis exp_list RightParenthesis {fprintf(parse,"FUNCTION CALL:%s\n ",$1);}  
;


%%

 int yywrap()
 {
     return 1;
 }
 
int main(int argc,char *argv[])
{
    freopen(argv[1],"r",stdin);
    
    yyout=fopen("Lexer.txt","w");
    parse=fopen("parser.txt","w");
    
    yyparse();
}
