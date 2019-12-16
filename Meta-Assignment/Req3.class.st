Class {
	#name : #Req3,
	#superclass : #TestCase,
	#category : #'Meta-Assignment'
}

{ #category : #tests }
Req3 >> testMultiNesting [
	| block |
	block := [ :v | 
	[ v / 0 ] asMyBlockClosure
		handle: ZeroDivide with: [ :e | 'inner' ];
		value ] asMyBlockClosure.
	block handle: ZeroDivide with: [ :err | 'outer' ].
	block handle: MessageNotUnderstood 
	with: [ :err | 'I cannot divide nil' ].
	self assert: (block value: 1) equals: 'inner'.
	self assert: (block value: nil) equals: 'I cannot divide nil'
]

{ #category : #tests }
Req3 >> testNesting [
	| block |
	block := [ 1 / 0 ] asMyBlockClosure.
	block handle: ZeroDivide with: [ :err | [ nil / 0 ] on: MessageNotUnderstood do: [ 0 ]  ].
	self assert: (block value) equals: 0.
]

{ #category : #tests }
Req3 >> testNesting2 [
	| block |
	block := [ 1 / 0 ] asMyBlockClosure.
	block
		handle: ZeroDivide
		with: [ :err | 
			[ 1 / 0 ]
				on: MessageNotUnderstood
				do: [ 0 ] ].
	self should: [ block value ] raise: ZeroDivide
]

{ #category : #tests }
Req3 >> testSimplBubbleUp [
	| block |
	block := [ :arg | arg / 0 ] asMyBlockClosure.
	block
		handle: ZeroDivide
		with: [ :err | 
			'You divided by zero'].
	self should: [ block value: nil ] raise: MessageNotUnderstood
]

{ #category : #tests }
Req3 >> testSimpleExample [
	| block |
	block := [ :arg | arg / 0 ] asMyBlockClosure.
	block
		handle: ZeroDivide
		with: [ :err | 
			'You divided by zero'].
	block
		handle: MessageNotUnderstood
		with: [ :err | 'I cannot divide nil' ].
	self assert: (block value: 1) equals: 'You divided by zero'.
	self assert: (block value: nil) equals: 'I cannot divide nil'
]
