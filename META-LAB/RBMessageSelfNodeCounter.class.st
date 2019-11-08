Class {
	#name : #RBMessageSelfNodeCounter,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'counter'
	],
	#category : #'META-LAB'
}

{ #category : #misc }
RBMessageSelfNodeCounter class >> countMessagesIn: arg1 [
	| tmp1 |
	tmp1 := RBMessageSelfNodeCounter new.
	tmp1 visitNode: arg1 ast.
	^ tmp1 counter
]

{ #category : #'as yet unclassified' }
RBMessageSelfNodeCounter >> counter [
	^ counter
]

{ #category : #'as yet unclassified' }
RBMessageSelfNodeCounter >> initialize [
	counter := 0
]

{ #category : #'as yet unclassified' }
RBMessageSelfNodeCounter >> visitMessageNode: aMessageNode [
	aMessageNode isSelfSend ifTrue: [ counter := counter + 1 ] .
	^ super visitMessageNode: aMessageNode 
]
