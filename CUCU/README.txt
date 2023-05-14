Running Commands:
flex cucu.l
bison -d cucu.y
cc lex.yy.c cucu.tab.c -o cucu (An executable file cucu.exe forms) (use only cc to execute)

Parse Files (Sample1.cu (for eg)) using: ./cucu Sample1.cu

ASSUMPTIONS:
1.)Rules given in assignment are only followed (like comments are recognised with /*..*/ only and not //, int and char aren't declared as arrays like char[],int[] like in C )
2.)Syntax errors get printed in the parser.txt and lexical errors in the Lexer.txt 
3.)Function definition without function declaration isn't an error
4.)Function Name and Identifier will be printed after printing whole analysis of the inside of function
5.)All syntax errors are classified as "syntax errors"
6.)If and while blocks are always followed by curly brackets
7.)Function call is defined in the "stmt" only
8.)Program ends after reporting syntax error

