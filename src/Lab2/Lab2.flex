package Lab2;
import java.util.regex.Pattern;

%%

%class Lab2
%standalone
%column
%line
%unicode

variables = [_]?[a-zA-Z]([0-9]|[a-zA-Z])*
number = [+-]?([0-9]*.[0-9]+|[0-9]+.|[0-9]+)([eE][-+]?[0-9]+)?[flFL]?
operator = ([<>=+-]|:=|[*/])
Whitespace = [ \t\n]
delimeter = [();]

%{

enum Lexer {
	//while,done
	KEYWORD("KEYWORD"),
	// '(', ')', ':'
	DELIMETER("DELIMETER"),
	//variables
	VARIABLE("VARIABLE"),
	//:=, <, >, = etc
	OPERATION("OPERATION"),
	//some hex value
	NUMBER("NUMBER"),

	UNKNOWN("UNKNOWN");

	private final String value;

	Lexer(String value) {
		this.value = value;
	}

	String getType() {
		return value;
	}
}

	public static void print(Lexer lexer, String text, int atColumn,int atLine) {
		System.out.printf("%s at column %d at line %d: %s\n", lexer.getType(), atColumn, atLine, text);
	}



%}

%%

//rule

while {
	print(Lexer.KEYWORD, yytext(), yycolumn, yyline);

}
done {
	print(Lexer.KEYWORD, yytext(), yycolumn, yyline);
}
{variables} {
	print(Lexer.VARIABLE, yytext(), yycolumn, yyline);

}
{number} {
    print(Lexer.NUMBER, yytext(), yycolumn, yyline);

}
{delimeter} {
	print(Lexer.DELIMETER, yytext(), yycolumn, yyline);
}
{operator} {
	print(Lexer.OPERATION, yytext(), yycolumn, yyline);
}


{Whitespace} {}
//bellow's shit make possible don't print every line of base file
.
{
    print(Lexer.UNKNOWN, yytext(), yycolumn, yyline);
}
