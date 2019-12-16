Extension { #name : #RBMessageNode }

{ #category : #'*Meta-Assignment' }
RBMessageNode >> isInlineToDo [
	| block step |
	self methodCompilationContextOrNil
		ifNotNil: [ :c | 
			c optionInlineToDo
				ifFalse: [ ^ false ] ].
	self receiver isBlock
		ifTrue: [ ^ false ].
	self isCascaded
		ifTrue: [ ^ false ].
	(#(#to:do: #to:by:do: #_to:unrollBy:do:) includes: self selector)
		ifFalse: [ ^ false ].
	block := self arguments last.
	block isBlock
		ifFalse: [ ^ false ].
	block arguments size = 1
		ifFalse: [ ^ false ].
	self arguments first isVariable
		ifTrue: [ (RBParseTreeSearcher new
				matches: self arguments first name , ' := `@object'
					do: [ :n :a | true ];
				executeTree: block initialAnswer: false)
				ifTrue: [ ^ false ] ].
	self arguments size = 3
		ifTrue: [ step := self arguments second.
			step isLiteralNode
				ifFalse: [ ^ false ].
			step value = 0
				ifTrue: [ ^ false ] ].	"to:by:do:"
	^ true
]
