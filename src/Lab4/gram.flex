package Lab4;
import java.util.regex.Pattern;

%%

%column
%line
%unicode
%byaccj

variables = [_]?[a-zA-Z]([0-9]|[a-zA-Z])*
number = [+-]?([0-9]*.[0-9]+|[0-9]+.|[0-9]+)([eE][-+]?[0-9]+)?[flFL]?
operator = [<>=]
Whitespace = [ \t\n]
delimeter = [();]
assign = (:=)

%{

private Parser yyparser;

  public Yylex(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
  }

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
    ASSIGN("ASSIGN"),
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

	return Parser.WHILE;

}
done {

	return Parser.DONE;
}
{variables} {

	return Parser.ID;

}
{number} {

    return Parser.NUMBER;

}

{operator} {

	return Parser.CMP;
}

{assign} {

    return Parser.ASSIGN;
    }

{Whitespace} {}
//bellow's shit make possible don't print every line of base file
.
{
    return (int) yycharat(0);
}
\b     { System.err.println("Sorry, backspace doesn't work"); }

/* error fallback */
[^]    { System.err.println("Error: unexpected character '"+yytext()+"'"); return -1; }
