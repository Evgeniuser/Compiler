/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 2001 Gerwin Klein <lsf@jflex.de>                          *
 * All rights reserved.                                                    *
 *                                                                         *
 * This is a modified version of the example from                          *
 *   http://www.lincom-asg.com/~rjamison/byacc/                            *
 *                                                                         *
 * Thanks to Larry Bell and Bob Jamison for suggestions and comments.      *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%{
  package Lab4;
  import java.io.*;
%}
      
%token WHILE DONE ID NUMBER
%right ASSIGN
%left CMP
      
%%

program: statement | program statement {System.out.println("program"); }
statement: WHILE'('expr')'oper DONE';' { System.out.println("While-loop"); }
statement: error';'
oper: statement | expr | statement oper | expr ',' oper {System.out.println("Operator"); }
expr: expr_assign | expr_cmp {System.out.println("expression"); }
expr_assign: ID ASSIGN expr_cmp | ID ASSIGN prime_expr {System.out.println("assign"); }
expr_cmp: prime_expr CMP prime_expr {System.out.println("comparison"); }
prime_expr: ID | NUMBER {System.out.println("primary expression"); }
%%

  private Yylex lexer;


  public void yyerror (String error) {
    System.err.println ("Error: " + error);
  }

private int yylex () {
    int yyl_return = -1;
    try {
      yylval = new ParserVal(0);
      yyl_return = lexer.yylex();
    }
    catch (IOException e) {
      System.err.println("IO error :"+e);
    }
    return yyl_return;
  }

  public Parser(Reader r) {
    lexer = new Yylex(r, this);
  }


  static boolean interactive;

  public static void main(String args[]) throws IOException {


    Parser yyparser;
    if ( args.length > 0 ) {
      // parse a file
      yyparser = new Parser(new FileReader(args[0]));
    }
    else {
      // interactive mode
      System.out.println("[Quit with CTRL-D]");
      System.out.print("Expression: ");
      interactive = true;
	    yyparser = new Parser(new InputStreamReader(System.in));
    }

    yyparser.yyparse();
    
    if (interactive) {
      System.out.println();
      System.out.println("Have a nice day");
    }
  }
