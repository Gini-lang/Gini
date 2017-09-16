parser grammar GiniParser;

options { tokenVocab=GiniLexer; }

giniFile
    :   preamble toplevelDeclaration* EOF
    ;

preamble
    :    moudleHeader? useHeader*
    ;

moudleHeader
    :   Module ambiguousName SEMI
    ;

useHeader
    :   Use ambiguousName SEMI
    ;


toplevelDeclaration
    :   structDeclaration
    |   functionDeclaration
    ;

// Struct
structDeclaration
    :   Struct Identifier  '{'   structElements  '}'
    ;

structElements
    :   structElement*
    ;

structElement
    :   Identifier ':' type SEMI
    ;

// function
functionDeclaration
    :   Fun Identifier '(' ')' //TODO
    ;

//expr
expr
    :   Identifier                      #ValueExpr
    |   expr '.' Identifier             #GetFieldExpr
    |   Identifier '(' ')'           #FunctionInvokeExpr
    ;


// type
type
    :   integerTypes                    #IntegerType
    |   floatTypes                      #FloatingPointTypes
    |   ambiguousName                   #SimpleType
    |   '(' type ')'                    #AtomType
    |   type '[' expr? ']'              #ArrayType
    |   type Const? '*'                 #PointerType
    |   '(' types? ')' '->' type        #DelegateType
    |   Fun '(' types? ')' '->' type    #FunctionType
    |   Any                             #TopType
    |   Nothing                         #BottomType
    |   Unit                            #UnitType
    ;

types
    :   type (',' type)*
    ;

integerTypes
    :   I8
    |   I16
    |   I32
    |   I64
    |   U8
    |   U16
    |   U32
    |   U64
    ;

floatTypes
    :   F32
    |   F64
    ;

functionArgs
    :
    ;

functionArg
    :   variableModifiers Identifier
    ;

//Base

ambiguousName
	:	Identifier
	|	ambiguousName '.' Identifier
	;

variableModifiers
    :   Const?
    ;
