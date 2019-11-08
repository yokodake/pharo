"
an Iphone
"
Class {
	#name : #Iphone,
	#superclass : #Phone,
	#category : #'META-LAB'
}

{ #category : #'as yet unclassified' }
Iphone class >> dechargeRate [
	^ self battery * 0.001
]

{ #category : #'as yet unclassified' }
Iphone >> call: arg1 for: arg2 [
	self calledFor: arg2 .
	arg1 calledFor: arg2 .
	^ arg2
]

{ #category : #'as yet unclassified' }
Iphone >> calledFor: arg1 [
	^ self decharge: (arg1 * 0.001)
]

{ #category : #'as yet unclassified' }
Iphone >> price [
	^ 100
]
