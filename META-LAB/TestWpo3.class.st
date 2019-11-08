Class {
	#name : #TestWpo3,
	#superclass : #Object,
	#category : #'META-LAB'
}

{ #category : #tests }
TestWpo3 >> testExo2 [
	| tmp1 |
	tmp1 := Inspector on: #(1 2) asOrderedCollection.
	tmp1
		getClass
		; getSuperclass
 		; valueOf: #array
		; valueOf: #firstIndex
		; classHierarchy
		; makeSelectorDict
]

{ #category : #tests }
TestWpo3 >> testExo3 [
	| c |
	c := Counter new .
	Producer start: c .
	Consumer start: c .
	
]
