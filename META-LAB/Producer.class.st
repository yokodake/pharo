Class {
	#name : #Producer,
	#superclass : #Object,
	#instVars : [
		'producer'
	],
	#category : #'META-LAB'
}

{ #category : #accessing }
Producer class >> start: arg1 [
	[ [ true ]
		whileTrue: [ arg1 mutex critical: [ arg1 increment ].
						 1000 milliSeconds  wait ] ] fork
]
