grammar Gini;

identifier  :   Identifier
    |   OneNL
    ;



IntgerLiteral
    :
    ;

Identifier
	:	IdentifierStart IdentifierPart*
	;

fragment
IdentifierStart
	:	[a-zA-Z$_]
	|	~[\u0000-\u007F\uD800-\uDBFF]
		{Character.isJavaIdentifierStart(_input.LA(-1))}?
	|	[\uD800-\uDBFF] [\uDC00-\uDFFF]
		{Character.isJavaIdentifierStart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}?
	;

fragment
IdentifierPart
	:	[a-zA-Z0-9$_]
	|	~[\u0000-\u007F\uD800-\uDBFF]
		{Character.isJavaIdentifierPart(_input.LA(-1))}?
	|	[\uD800-\uDBFF] [\uDC00-\uDFFF]
		{Character.isJavaIdentifierPart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}?
	;

NL  :   OneNL+
    ;

OneNL
    :   '\r\n'
    |   '\n'
    |   '\r'
    ;

WS  :   [ \t] -> skip
    ;

Comment
    :   '/*' .*? '*/' -> channel(HIDDEN)
    ;

LineComment
    :   '//' ~[\r\n]* -> channel(HIDDEN)
    ;