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
				ifFalse: [ (n arguments at: 1) body ] ])}.
	^ (branches at: aDirectiveNode selector) value: aBoolean value: aDirectiveNode
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
			sel = #_ifTrue:ifFalse:
				or: (sel = #_ifTrue: or: sel = #_ifFalse) ].
	nodes
		do: [ :n | 
			| pred |
			pred := true.
			n replaceWith: (n arguments at: 1) body ].
	^ a
]
