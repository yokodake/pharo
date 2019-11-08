Class {
	#name : #Foo,
	#superclass : #Object,
	#instVars : [
		'val'
	],
	#category : #'META-LAB'
}

{ #category : #accessing }
Foo >> foo [
 |ctx|
	ctx := thisContext .
	self halt .
 	^ 'hi'
]

{ #category : #initialization }
Foo >> initialize [ 
  val := 4
]
