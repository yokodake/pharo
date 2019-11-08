Class {
	#name : #Consumer,
	#superclass : #Object,
	#category : #'META-LAB'
}

{ #category : #accessing }
Consumer class >> start: arg1 [
	[ | tmp2 |
	 [true]
		whileTrue: [ arg1 mutex critical: [ tmp2 := arg1 get ].
			Transcript crShow: tmp2.
			2000 milliSeconds wait ] ] fork
]
