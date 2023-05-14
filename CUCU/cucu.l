%{
	#include <stdio.h>
	#include <string.h>
	#include "cucu.tab.h"
	
%}


%%
(\/\*(.|\n)*\*\/) {fprintf(yyout,"Comment:%s\n",yytext);}
(int)|(char[ ]\*+) {yylval.string=strdup(yytext); fprintf(yyout,"DataType:%s\n",yytext);return DataType;}
(if) {fprintf(yyout,"IfKeyword:%s\n",yytext); return IfKeyword;}
(else) {fprintf(yyout,"ElseKeyword:%s\n",yytext); return ElseKeyword;}
(while) {fprintf(yyout,"WhileKeyword:%s\n",yytext); return IfKeyword;}
(return) {fprintf(yyout,"ReturnKeyword:%s\n",yytext); return ReturnKeyword;}


[a-zA-Z][a-zA-Z0-9_]* {yylval.string=strdup(yytext); fprintf(yyout,"Identifier:%s\n",yytext); return Identifier;}
[0-9]+ {yylval.number=atoi(yytext); fprintf(yyout,"Number:%s\n",yytext); return Number;}
[,] {fprintf(yyout,"CommaSymbol:%s\n",yytext); return CommaSymbol;}
[(] {fprintf(yyout,"LeftParenthesis:%s\n",yytext); return LeftParenthesis;}
[)] {fprintf(yyout,"RightParenthesis:%s\n",yytext); return RightParenthesis;}
[\[] {fprintf(yyout,"LeftSquareBracket:%s\n",yytext); return LeftSquareBracket;}
[\]] {fprintf(yyout,"RightSquareBracket:%s\n",yytext); return RightSquareBracket;}
[\{] {fprintf(yyout,"LeftCurlyBracket:%s\n",yytext); return LeftCurlyBracket;}
[\}] {fprintf(yyout,"RightCurlyBracket:%s\n",yytext); return RightCurlyBracket;}

(\|\|) {fprintf(yyout,"LogicalOR:%s\n",yytext); return LogicalOR;}
(\&\&) {fprintf(yyout,"LogicalAND:%s\n",yytext); return LogicalAND;}
[\|] {fprintf(yyout,"BitwiseOR:%s\n",yytext); return BitwiseOR;}
[\&] {fprintf(yyout,"BitwiseAND:%s\n",yytext); return BitwiseAND;}

(==) {fprintf(yyout,"EqualityComparison:%s\n",yytext); return EqualityComparison;}
(!=) {fprintf(yyout,"NonEqualityComparison:%s\n",yytext); return NonEqualityComparison;}
(>=) {fprintf(yyout,"GreaterThanEqualToComparison:%s\n",yytext); return GreaterThanEqualToComparison;}
(<=) {fprintf(yyout,"LessThanEqualToComparison:%s\n",yytext); return LessThanEqualToComparison;}
[\=] {fprintf(yyout,"AssignSymbol:%s\n",yytext); return AssignSymbol;}
[<] {fprintf(yyout,"LessThanComparison:%s\n",yytext); return LessThanComparison;}
[>] {fprintf(yyout,"GreaterThanComparison:%s\n",yytext); return GreaterThanComparison;}

[\+] {fprintf(yyout,"AdditionOperator:%s\n",yytext); return AdditionOperator;}
[\-] {fprintf(yyout,"SubtractionOperator:%s\n",yytext); return SubtractionOperator;}
[\*] {fprintf(yyout,"MultiplicationOperator:%s\n",yytext); return MultiplicationOperator;}
[\/] {fprintf(yyout,"DivisionOperator:%s\n",yytext); return DivisionOperator;}
[\;] {fprintf(yyout,"Semicolon:%s\n",yytext); return Semicolon;}
\".*\" {fprintf(yyout,"String:%s\n",yytext); return String;}
[ \t\n]* ;
[.] {fprintf(yyout,"InvalidToken:%s\n",yytext);yyerror("InvalidToken");}
%%




