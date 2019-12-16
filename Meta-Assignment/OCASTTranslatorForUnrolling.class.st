Class {
	#name : #OCASTTranslatorForUnrolling,
	#superclass : #OCASTTranslatorForEffect,
	#category : #'Meta-Assignment'
}

{ #category : #enumerating }
OCASTTranslatorForUnrolling >> emitToDo: aMessageNode [
	^ super emitToDo: aMessageNode
]

{ #category : #enumerating }
OCASTTranslatorForUnrolling >> emitUnrolledToDo: aMessageNode [
	| unrollFactor start body end limit block iterator limitEmit |
	start := aMessageNode receiver.
	limit := aMessageNode arguments first.
	unrollFactor := DirectivesCompilerASTPlugin
		evaluate: (RBBlockNode body: (aMessageNode arguments at: 2))
		with: self compilationContext getClass compiler.
	block := aMessageNode arguments last.
	iterator := block arguments first binding.
	"emit how to compute the limit of the loop C/Ced from emitToDo"
	limitEmit := [ valueTranslator visitNode: limit ].
	limit isLiteralNode | limit isSelf | limit isSuper | limit isArgument
		ifFalse: [ valueTranslator visitNode: limit.
			methodBuilder addTemp: iterator name , #limit.
			methodBuilder storeTemp: iterator name , #limit.
			methodBuilder popTop.
			limitEmit := [ methodBuilder pushTemp: iterator name , #limit ] ].

	"push start. allocate and initialize iterator"
	valueTranslator visitNode: aMessageNode receiver.
	iterator emitStore: methodBuilder.
	self isEffectTranslator
		ifTrue: [ methodBuilder popTop ].
	methodBuilder jumpBackTarget: #start.
	iterator emitValue: methodBuilder.
	limitEmit value.
	methodBuilder
		send:
			(unrollFactor> 0
				ifTrue: [ #<= ]
				ifFalse: [ #>= ]).
	methodBuilder jumpAheadTo: #done if: false.
	effectTranslator visitInlinedBlockNode: block
	"	self emitUnrolledToDo_: aMessageNode"
]

{ #category : #enumerating }
OCASTTranslatorForUnrolling >> emitUnrolledToDo_: aMessageNode [
	| unrollFactor start end toRest restLoop block unrolledLoop |
	start := aMessageNode receiver.
	end := aMessageNode arguments first.
	block := aMessageNode arguments last.
	"we have to evaluate the unroll factor at compile time"
	unrollFactor := DirectivesCompilerASTPlugin
		evaluate: (RBBlockNode body: (aMessageNode arguments at: 2))
		with: self compilationContext getClass compiler.
	toRest := RBMessageNode
		receiver:
			(RBMessageNode
				receiver: (RBMessageNode receiver: end selector: #- arguments: {start})
				selector: #%
				arguments: {(RBLiteralValueNode value: unrollFactor)})
		selector: #+
		arguments: {start}.
	restLoop := aMessageNode copy
		selector: #to:do:;
		arguments:
			{toRest.
			block};
		yourself.
	unrolledLoop := aMessageNode copy
		selector: #to:do:;
		receiver: (RBMessageNode receiver: toRest selector: #+ arguments: {RBLiteralValueNode value: 1});
		arguments:
			{end.
			(self unrollBlockNode: block copy by: unrollFactor)}.
	self emitToDo: restLoop.
	self emitToDo: unrolledLoop step: unrollFactor
]

{ #category : #enumerating }
OCASTTranslatorForUnrolling >> unrollBlockNode: aBlockNode by: unrollFactor [
	^ aBlockNode
		body:
			(RBSequenceNode
				statements: ((self unrollBlockNodeBody: aBlockNode by: unrollFactor) flatCollect: [:seqNode | seqNode statements]))
]

{ #category : #enumerating }
OCASTTranslatorForUnrolling >> unrollBlockNodeBody: aBlockNode by: unrollFactor [
	| iterator |
	iterator := aBlockNode arguments first.
	^ (Interval from: 0 to: unrollFactor - 1) asOrderedCollection
		collect: [ :i | 
			| body |
			body := aBlockNode copy body.
			(body variableNodes select: [ :n | n = iterator ])
				do: [ :n | 
					n
						replaceWith:
							(RBMessageNode
								receiver: n copy
								selector: #+
								arguments: {(RBLiteralValueNode value: i)})].
			body ]
]

{ #category : #enumerating }
OCASTTranslatorForUnrolling >> visitMessageNode: m [
	^ super visitMessageNode: m
]
