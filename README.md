# Syntax-validator
Validate data syntax in LESS format.

The grammar is described in the BNF notation:

1. Initial symbol: <variables>
2. Non-terminal symbols:
  <variables>
  <variable>
  <value>
  <function>
  <values>
  <valuesContinuation>
  <comment>
3. Terminal symbols:
  <semicolon> ::= ;
  <at> ::= @
  <assign> ::= :
  <variableName> ::= [a-z-]+
  <color> ::= #[a-z0-9]+
  <number> ::= [0-9.]+
  <percent> ::= [0-9]+%
  <openBracket> ::= (
  <closeBracket> ::= )
  <comma> ::= ,
  <dot> ::= .
  <openBuckle> ::= {
  <closeBuckle> ::= }
  <commentContent> ::= [a-zA-Z0-9`% !]+
  <plainComment> ::= //
  <commentBeginning> ::= /*
  <commentEnding> ::= *\
4. Productions:
  <variables> ::= <variable><semicolon><variables> | E | <comment><variables> | <variable><variables>
  <variable> ::= <at><value><assign><value> | <at><value> | <value> | <value><assign><function> | 
    <dot><value><openBuckle><variables><closeBuckle>
  <value> ::= <color> | <variableName> | <percent> | <number>
  <function> ::= <value><openBracket><values><closeBracket>
  <values> ::= <variable><valuesContinuation> | <function><valuesContinuation>
  <valuesContinuation> ::= <comma><values> | E
  <comment> ::= <plainComment><commentContent> | <commentBeginning><commentContent><commentEnding>
  
Sample file to be checked:
  
@base:#f04615;
@width:0.5; 
.class {
  width: percentage(@width); // Returns `50%`
	color: saturate(@base, 5%);
	background-color: spin(lighten(@base, 25%), 8);
}
/* One hell of a block style comment! */@var: red; // Get in line!
@var: white;
