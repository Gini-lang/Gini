grammar Gini;

@lexer::members {
    java.util.LinkedList<Character> stack = new java.util.LinkedList<>();
}

giniFile
    :   preamble toplevelDeclaration* EOF
    ;

preamble
    :    moudleHeader? useHeader*
    ;

moudleHeader
    :   Module ambiguousName
    ;

useHeader
    :   Use ambiguousName
    ;


toplevelDeclaration
    :   structDeclaration
    ;

structDeclaration
    :   Struct Identifier  '{'   structElements?  '}'
    ;

structElements
    :   structElement (','  structElement)*
    ;

structElement
    :   Identifier ':' type
    ;

type
    :   ambiguousName                   #SimpleType
    |   '(' type ')'                    #AtomType
    |   type '[' expr? ']'              #ArrayType
    |   type Const? '*'                 #PointerType
    |   '(' types? ')' '->' type        #DelegateType
    |   Fun '(' types? ')' '->' type    #FunctionType
    |   IntegerTypes                    #IntegerType
    |   Any                             #TopType
    |   Nothing                         #BottomType
    |   Unit                            #UnitType
    ;

types
    :   type (',' type)*
    ;

expr
    :   ambiguousName
    ;

ambiguousName
	:	Identifier
	|	ambiguousName '.' Identifier
	;


As      :   'as';
Any     :   'any';
Const   :   'const';
Let     :   'let';
If      :   'if';
Else    :   'else';
Fun     :   'fun';
Where   :   'where';
While   :   'while';
For     :   'for';
Struct  :   'struct';
Class   :   'class';
Type    :   'type';
Break   :   'break';
Continue:   'continue';
Yield   :   'yield';
Enum    :   'enum';
Match   :   'match';
Case    :   'case';
Private :   'private';
Use     :   'Use';
Module  :   'module';
Union   :   'union';
Unit    :   'unit';
Return  :   'return';
Nothing :   'nothing';
New     :   'new';

Int8        :   'i8';
Int16       :   'i16';
Int32       :   'i32';
Int64       :   'i64';
Uint8       :   'u8';
Uint16      :   'u16';
Uint32      :   'u32';
Uint64      :   'u64';

LPAREN : '(' { stack.push('(');};
RPAREN : ')' { if(stack.peek() == '(') stack.pop();};
LBRACE : '{' { stack.push('{');};
RBRACE : '}' { if(stack.peek() == '{') stack.pop();};
LBRACK : '[' { stack.push('【');};
RBRACK : ']' { if(stack.peek() == '[') stack.pop();};
COMMA : ',';
DOT : '.';

ASSIGN : '=';
GT : '>';
LT : '<';
BANG : '!';
TILDE : '~';
QUESTION : '?';
COLON : ':';
EQUAL : '==';
LE : '<=';
GE : '>=';
NOTEQUAL : '!=';
AND : '&&';
OR : '||';
INC : '++';
DEC : '--';
ADD : '+';
SUB : '-';
MUL : '*';
DIV : '/';
BITAND : '&';
BITOR : '|';
CARET : '^';
MOD : '%';
ARROW : '->';
COLONCOLON : '::';

ADD_ASSIGN : '+=';
SUB_ASSIGN : '-=';
MUL_ASSIGN : '*=';
DIV_ASSIGN : '/=';
AND_ASSIGN : '&=';
OR_ASSIGN : '|=';
XOR_ASSIGN : '^=';
MOD_ASSIGN : '%=';
LSHIFT_ASSIGN : '<<=';
RSHIFT_ASSIGN : '>>=';
URSHIFT_ASSIGN : '>>>=';

AT : '@';
ELLIPSIS : '...';


IntegerLiteral
	:	DecimalIntegerLiteral
	|	HexIntegerLiteral
	|	BinaryIntegerLiteral
	;

fragment
DecimalIntegerLiteral
	:	DecimalNumeral IntegerTypeSuffix?
	;

fragment
HexIntegerLiteral
	:	HexNumeral IntegerTypeSuffix?
	;


fragment
BinaryIntegerLiteral
	:	BinaryNumeral IntegerTypeSuffix?
	;

IntegerTypeSuffix
    :   IntegerTypes
    ;

IntegerTypes
	:	'i8'
	|   'i16'
	|   'i32'
	|   'i64'
	|   'u8'
	|   'u16'
	|   'u32'
	|   'u64'
	;

fragment
DecimalNumeral
	:	'0'
	|	NonZeroDigit (Digits? | Underscores Digits)
	;

fragment
Digits
	:	Digit (DigitsAndUnderscores? Digit)?
	;

fragment
Digit
	:	'0'
	|	NonZeroDigit
	;

fragment
NonZeroDigit
	:	[1-9]
	;

fragment
DigitsAndUnderscores
	:	DigitOrUnderscore+
	;

fragment
DigitOrUnderscore
	:	Digit
	|	'_'
	;

fragment
Underscores
	:	'_'+
	;

fragment
HexNumeral
	:	'0' [xX] HexDigits
	;

fragment
HexDigits
	:	HexDigit (HexDigitsAndUnderscores? HexDigit)?
	;

fragment
HexDigit
	:	[0-9a-fA-F]
	;

fragment
HexDigitsAndUnderscores
	:	HexDigitOrUnderscore+
	;

fragment
HexDigitOrUnderscore
	:	HexDigit
	|	'_'
	;


fragment
BinaryNumeral
	:	'0' [bB] BinaryDigits
	;

fragment
BinaryDigits
	:	BinaryDigit (BinaryDigitsAndUnderscores? BinaryDigit)?
	;

fragment
BinaryDigit
	:	[01]
	;

fragment
BinaryDigitsAndUnderscores
	:	BinaryDigitOrUnderscore+
	;

fragment
BinaryDigitOrUnderscore
	:	BinaryDigit
	|	'_'
	;

FloatingPointLiteral
	:	DecimalFloatingPointLiteral
	|	HexadecimalFloatingPointLiteral
	;

fragment
DecimalFloatingPointLiteral
	:	Digits '.' Digits? ExponentPart? FloatTypeSuffix?
	|	'.' Digits ExponentPart? FloatTypeSuffix?
	|	Digits ExponentPart FloatTypeSuffix?
	|	Digits FloatTypeSuffix
	;

fragment
ExponentPart
	:	ExponentIndicator SignedInteger
	;

fragment
ExponentIndicator
	:	[eE]
	;

fragment
SignedInteger
	:	Sign? Digits
	;

fragment
Sign
	:	[+-]
	;

fragment
FloatTypeSuffix
	:   'f32'
	|   'f64'
    |   [fFdD]
	;

fragment
HexadecimalFloatingPointLiteral
	:	HexSignificand BinaryExponent FloatTypeSuffix?
	;

fragment
HexSignificand
	:	HexNumeral '.'?
	|	'0' [xX] HexDigits? '.' HexDigits
	;

fragment
BinaryExponent
	:	BinaryExponentIndicator SignedInteger
	;

fragment
BinaryExponentIndicator
	:	[pP]
	;

BoolLiteral
	:	'true'
	|	'false'
	;

CharacterLiteral
	:	'\'' SingleCharacter '\''
	|	'\'' EscapeSequence '\''
	;

fragment
SingleCharacter
	:	~['\\\r\n]
	;


StringLiteral
	:	'"' StringCharacters? '"'
	|   '`' .*? '`'
	;

fragment
StringTypePrefix
    :   'u8'
    |   'u16'
    |   'u32'
    ;

fragment
StringCharacters
	:	StringCharacter+
	;

fragment
StringCharacter
	:	~["\\\r\n]
	|	EscapeSequence
	;

fragment
EscapeSequence
	:	'\\' [btnfr"'\\]
    |   UnicodeEscape // This is not in the spec but prevents having to preprocess the input
	;

fragment
UnicodeEscape
    :   '\\' 'u' HexDigit HexDigit HexDigit HexDigit
    ;

NullLiteral
	:	'null'
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


WS  :   [ \t\r\n] -> skip
    ;

Comment
    :   '/*' .*? '*/' -> channel(HIDDEN)
    ;

LineComment
    :   '//' ~[\r\n]* -> channel(HIDDEN)
    ;