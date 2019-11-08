"
another phone
"
Class {
	#name : #LGQ8,
	#superclass : #Phone,
	#category : #'META-LAB'
}

{ #category : #'as yet unclassified' }
LGQ8 class >> dechargeRate [
  ^ 0.25
]

{ #category : #'as yet unclassified' }
LGQ8 >> call: arg1 for: arg2 [
	self calledFor: 0.25.
	arg1 calledFor: arg2.
	^ arg2
]

{ #category : #'as yet unclassified' }
LGQ8 >> calledFor: aNumber [ 
	self decharge: (battery - 0.25)
]

{ #category : #'as yet unclassified' }
LGQ8 >> price [
	^ 50

]
