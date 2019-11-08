"
I represent False
"
Class {
	#name : #MyFalse,
	#superclass : #Object,
	#category : #'META-LAB'
}

{ #category : #'as yet unclassified' }
MyFalse >> and: aBool [ 
	^ MyFalse new
]

{ #category : #'logical operations' }
MyFalse >> not [ 
	^ MyTrue new
]

{ #category : #'as yet unclassified' }
MyFalse >> or: aBool [
	^ aBool	
]
