"
""I represent a paragraph of text""

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	battery:		<Object>


    Implementation Points
"
Class {
	#name : #Phone,
	#superclass : #Object,
	#instVars : [
		'battery'
	],
	#category : #'META-LAB'
}

{ #category : #'reflective operations' }
Phone class >> doesNotUnderstand: aMessage [
	| messageName |
	messageName := aMessage selector asString .
	(self class instVarNames includes: messageName)
		ifTrue: [  
			self class compile: messageName, String cr, '^', messageName ]
]

{ #category : #'as yet unclassified' }
Phone >> alive [
	"query if phone still has battery or is off"

	^ battery > 0
]

{ #category : #accessing }
Phone >> battery [
	"query remaining battery"

	^ battery
]

{ #category : #'as yet unclassified' }
Phone >> decharge: anInteger [
  battery := 0 max: (battery - anInteger) .
  ^ battery
]

{ #category : #initialization }
Phone >> initialize [
  super initialize .
  battery := 5.
  ^ self
]

{ #category : #'as yet unclassified' }
Phone >> recharge [
	"replenish battery"
	battery := 5 .
	^ self
]
