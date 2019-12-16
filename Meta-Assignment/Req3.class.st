Class {
	#name : #Req3,
	#superclass : #TestCase,
	#category : #'Meta-Assignment'
}

{ #category : #tests }
Req3 >> testSimpleExample [
	| block |
	block := [ :arg | arg / 0 ] asMyBlockClosure.
	block handle: ZeroDivide with: [ :err | 'You divided by zero' ].
	block
		handle: MessageNotUnderstood
		with: [ :err | 'I cannot divide nil' ].
	self assert: (block value: 1) equals: 'Youdividedbyzero'.
	self assert: (block value: nil) equals: 'I cannot divide nil'
]
