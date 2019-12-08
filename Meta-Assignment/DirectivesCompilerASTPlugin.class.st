Class {
	#name : #DirectivesCompilerASTPlugin,
	#superclass : #OCCompilerASTPlugin,
	#category : #'Meta-Assignment'
}

{ #category : #'as yet unclassified' }
DirectivesCompilerASTPlugin class >> branching: aDirectiveNode on: aBoolean [
	| branches |
	branches := {(#_ifTrue:ifFalse:
		-> [ :n :p | 
			p
				ifTrue: [ (n arguments at: 1) body ]
				ifFalse: [ (n arguments at: 2) body ] ]).
	(#_ifTrue:
		-> [ :n :p | 
			p
				ifTrue: [ (n arguments at: 1) body ]
				ifFalse: [ RBSequenceNode statements: {} ] ]).
	(#_ifFalse:
		-> [ :n :p | 
			p
				ifTrue: [ RBSequenceNode statements: {} ]
				ifFalse: [ (n arguments at: 1) body ] ])} asDictionary.
	^ (branches at: aDirectiveNode selector) value: aDirectiveNode value: aBoolean
]

{ #category : #private }
DirectivesCompilerASTPlugin class >> evaluate: aRBBlockNode with: aCompiler [
	| code cm |
	code := String streamContents: [ :s | aRBBlockNode body printAsIfCompiledOn: s ].
	cm := aCompiler source: code; noPattern: true; parse; doSemanticAnalysis.
	(cm variableNodes allSatisfy: [ :n | n isGlobal or: n isTemp ]) ifFalse: [ CannotResolveAtCompileTime signal: code].
	^ [ aCompiler evaluate ] on: Error do: [ CannotResolveAtCompileTime signal ]
]

{ #category : #private }
DirectivesCompilerASTPlugin class >> priority [
	^ 100
]

{ #category : #api }
DirectivesCompilerASTPlugin >> priority [
 ^ 100
]

{ #category : #api }
DirectivesCompilerASTPlugin >> transform [
	| nodes a |
	a := ast copy.
	nodes := a sendNodes.
	nodes := nodes
		select: [ :n | 
			| sel |
			sel := n selector.
			n receiver isBlock "only blocks"
				and: (sel = #_ifTrue:ifFalse:
					or: (sel = #_ifTrue: or: sel = #_ifFalse:)) ].
	nodes
		do: [ :n | 
			| result |
			result := self class evaluate: (n receiver) with: (ast compilationContext getClass compiler).
			(result class superclass = Boolean) ifFalse: [ CompileTimeCondMustBeBoolean signal ].
			n replaceWith: (self class branching: n on: result) ].
	^ a
]
