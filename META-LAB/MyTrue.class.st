"
I represent True
"
Class {
	#name : #MyTrue,
	#superclass : #Object,
	#category : #'META-LAB'
}

{ #category : #'as yet unclassified' }
MyTrue >> and: arg1 [
	^ arg1
]

{ #category : #'logical operations' }
MyTrue >> not [
	"returns MyFalse"

	^ MyFalse new
]

{ #category : #'as yet unclassified' }
MyTrue >> or: aBool [ 
	^ MyTrue new
]
