Class {
	#name : #Person,
	#superclass : #Object,
	#instVars : [
		'name',
		'surname'
	],
	#category : #'META-LAB'
}

{ #category : #'as yet unclassified' }
Person class >> withName: aString surname: aString2 [ 
	| p |
	p := Person new .
	p name: aString .
	p surname: aString2 .
	^ p
]

{ #category : #'as yet unclassified' }
Person >> name [
	^ name
]

{ #category : #'as yet unclassified' }
Person >> name: aString [ 
	name := aString
]

{ #category : #'as yet unclassified' }
Person >> surname [
	^ surname
]

{ #category : #'as yet unclassified' }
Person >> surname: aString [ 
	surname := aString
]
