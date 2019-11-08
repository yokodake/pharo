"
test for second test
"
Class {
	#name : #TestExo2,
	#superclass : #Object,
	#category : #'META-LAB'
}

{ #category : #tests }
TestExo2 >> testScenario [
	| tmp1 tmp2 |
	tmp1 := LGQ8 new.
	tmp2 := Iphone new.
	tmp1 call: tmp2 for: 10.
	tmp2
		call: tmp1 for: 2;
		alive.
	^ tmp1 alive
]
