Class {
	#name : #RBMessageNodeCounter,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'counter'
	],
	#category : #'META-LAB'
}

{ #category : #misc }
RBMessageNodeCounter class >> countMessagesIn: aCompiledMethod [
  | counter |
	counter := RBMessageNodeCounter new .
	counter visitNode: aCompiledMethod ast .
  	^ counter counter
]

{ #category : #'as yet unclassified' }
RBMessageNodeCounter >> counter [
	^ counter
]

{ #category : #'as yet unclassified' }
RBMessageNodeCounter >> initialize [
	counter := 0
]

{ #category : #'as yet unclassified' }
RBMessageNodeCounter >> visitMessageNode: aMessageNode [
  counter := counter + 1.
  ^ super visitMessageNode: aMessageNode
]
