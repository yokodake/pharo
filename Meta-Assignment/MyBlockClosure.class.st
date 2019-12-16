Class {
	#name : #MyBlockClosure,
	#superclass : #Object,
	#instVars : [
		'block'
	],
	#category : #'Meta-Assignment'
}

{ #category : #'as yet unclassified' }
MyBlockClosure class >> withBlock: aBlockClosure [
	^ MyBlockClosure new
		block: aBlockClosure;
		yourself
]

{ #category : #'as yet unclassified' }
MyBlockClosure >> block: aBlockClosure [ 
	block := aBlockClosure
]
