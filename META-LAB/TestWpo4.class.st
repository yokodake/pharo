Class {
	#name : #TestWpo4,
	#superclass : #Object,
	#category : #'META-LAB'
}

{ #category : #tests }
TestWpo4 >> testExo1 [
  | p |
	p := Person withName: 'foo' surname: 'bar' .
  	(Person>>#name) decompile .
]

{ #category : #tests }
TestWpo4 >> testExo2 [
	|oc foo source|
	source := 'foo ^ val + 1' .
	oc := Person compiler " an OpalCompiler" .
	(oc source: 'foo ^ val + 1') compile " Person>>#foo" .
	oc compilationContext " a CompilationContext"	.
	(oc compilationContext) class: Foo .
	foo := (oc source: 'foo ^ val + 1') compile "Foo>>#foo" .
	foo valueWithReceiver: Foo new arguments: #() " 5" .
	Foo new foo " 'hi'" .
	
	
]

{ #category : #tests }
TestWpo4 >> testExo21 [
| ir method |
ir := IRBuilder new
			numArgs: 0;
			pushLiteral: 4;
			pushLiteral: 3;
		   send: #+;
			pushLiteral: 2;
			send: #*;
			send: #factorial ;
			returnTop;
			ir . 
			
method := ir compiledMethod
]

{ #category : #tests }
TestWpo4 >> testExo22 [
| ir method |
ir := IRBuilder new
			numArgs: 2;
			addTemps: #(x y);
			pushTemp: #x;
			pushTemp: #y;
		   send: #+;
			send: #factorial ;
			returnTop;
			ir . 
			
method := ir compiledMethod .
method selector: #myFact:with: .
]

{ #category : #tests }
TestWpo4 >> testExo23 [
 | ir method |
ir := IRBuilder new
			numArgs: 2;
			addTemps: #(x y);
			pushTemp: #x;
			pushTemp: #y;
		   send: #+;
			send: #factorial;
			pushReceiver;
			send: #factorial;
			send: #*;
     		returnTop;
			ir . 
			
method := ir compiledMethod .
method selector: #myFact:with: .

]

{ #category : #tests }
TestWpo4 >> testExo3 [
	| tmp1 cmt |
	tmp1 := Object compiler.
	(tmp1 source: 'foo ^ val + 1') compile .
	cmt := tmp1 compilationContext compiledMethodTrailer .
	cmt embeddedSourceCode: 'foo
	^ val + 1' 
]

{ #category : #tests }
TestWpo4 >> testExo4 [
  | ir method |
ir := IRBuilder new
			numArgs: 1;
			addTemps: #(x);
			pushReceiver ;
			pushTemp: #x;
			send: #>;
			returnTop;
			ir . 
  method := ir compileMethod .
]
