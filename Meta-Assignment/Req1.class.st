Class {
	#name : #Req1,
	#superclass : #TestCase,
	#category : #'Meta-Assignment'
}

{ #category : #compiler }
Req1 class >> compiler [
	| oc |
	oc := super compiler.
	oc bindings: {('a' -> 2)}.
	^ oc
]

{ #category : #tests }
Req1 >> testOne [
  ^ a + 1 .
 
]
