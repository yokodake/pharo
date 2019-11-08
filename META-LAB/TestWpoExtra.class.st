Class {
	#name : #TestWpoExtra,
	#superclass : #Object,
	#category : #'META-LAB'
}

{ #category : #tests }
TestWpoExtra >> testExo1 [
 | ir method mod |
EpMonitor current log entries .

ir := IRBuilder new numArgs: 0; pushLiteral: 'bye'; returnTop ; ir .
ir compilationContext class: Foo . 
method := ir compiledMethod selector: #foo; yourself .
mod := EpMethodModification oldMethod: Foo>>#foo newMethod: method .

EpMonitor current log addEntryWith: mod tags: [ :tags |
															tags at: EpLog authorKey put: EpMonitor current author.
															tags at: EpLog timeKey put: EpMonitor current time ].
														
"entry is invalid unfortunately"
]

{ #category : #tests }
TestWpoExtra >> testExo2 [ 
	| l |
	l := Logger on: Counter new .
	l increment .
	l value .
	l class .
	l logs .
"set superclass to nil"
]
