Class {
	#name : #Req1,
	#superclass : #TestCase,
	#instVars : [
		'instvar',
		'oc'
	],
	#classVars : [
		'classvar'
	],
	#classInstVars : [
		'foobar'
	],
	#category : #'Meta-Assignment'
}

{ #category : #compiler }
Req1 class >> addCompileTimeVariables [
	<constantDefinition>
	^ { 'Bits64' -> True.
		'Bits' -> 64.
		'Bits32' -> 32 } asDictionary
]

{ #category : #compiler }
Req1 class >> compiler [
	^ super compiler
		addPlugin: DirectivesCompilerASTPlugin;
		bindings: self addCompileTimeVariables;
		yourself
]

{ #category : #running }
Req1 >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	oc := self class compiler noPattern: true; yourself
]

{ #category : #tests }
Req1 >> testCannotResolveAtCompileTime [
	self 
		should: [ oc compile: 'instvar := true . [ instvar ] _ifTrue:[ 1 ]' ] 
		raise: CannotResolveAtCompileTime 
]

{ #category : #tests }
Req1 >> testCannotResolveAtCompileTimeOnTemporary [
	self 
		should: [ oc compile: '|x| [x := true . x ] _ifTrue:[ 1 ]' ] 
		raise: CannotResolveAtCompileTime 
]

{ #category : #tests }
Req1 >> testCompileTimeCondMustBeBoolean [
	self 
		should: [ oc compile: '[ 1 ] _ifTrue:[ 1 ]' ] 
		raise: CompileTimeCondMustBeBoolean 
]

{ #category : #tests }
Req1 >> testFalse [
	self 
		assert: (oc evaluate: '[ false ] _ifFalse: [ 1 ]') equals: 1;
		assert: (oc evaluate: '[ true ] _ifFalse: [ 1 ]') equals: nil
]

{ #category : #tests }
Req1 >> testNotBlockDoesNotUnderstand [
	self should: [ true _ifTrue: [ 1 ] ] raise: MessageNotUnderstood
]

{ #category : #tests }
Req1 >> testOne [
	self assert: (oc evaluate:'[ true ] _ifTrue: [ 1 ]') equals: 1
]

{ #category : #tests }
Req1 >> testSequence [
	self assert: (oc evaluate: '[ true ] _ifTrue: [ x := 1 . x + 1 ]') equals: 2.
	self assert: (oc evaluate: '[ true ] _ifTrue: [ ''first'' . ''second'' ]') equals: 'second'. "this works because a RBSequenceNode is considered an expression?"
]

{ #category : #tests }
Req1 >> testTemp [
	self assert: (oc evaluate:'[|x| x := true . x ] _ifTrue: [ 1 ]') equals: 1
]

{ #category : #tests }
Req1 >> testTrue [
	self
		assert: (oc evaluate: '[ true ] _ifTrue: [ 1 ]') equals: 1;
		assert: (oc evaluate: '[ false ] _ifTrue: [ 1 ]') equals: nil
]

{ #category : #tests }
Req1 >> testTrueFalse [
	self
		assert: (oc evaluate: '[ true ] _ifTrue: [ 1 ] ifFalse: [ 2 ]') equals: 1;
		assert: (oc evaluate: '[ false ] _ifTrue: [ 1 ] ifFalse: [ 2 ]') equals: 2
]

{ #category : #tests }
Req1 >> testVars [
  self assert: (oc evaluate: '(Bits + 1)') equals: 65
]
