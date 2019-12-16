Class {
	#name : #Req2,
	#superclass : #TestCase,
	#instVars : [
		'oc'
	],
	#category : #'Meta-Assignment'
}

{ #category : #tests }
Req2 >> bytecodeSize [
	| unrolled normal |
	unrolled := [ :ufactor | 
	oc
		noPattern: false;
		compile:
			'integerSum: arrayOfIntegers
						sum := 0. 
						1 _to: arrayOfIntegers size unrollBy: ' , ufactor asString
				,
					'do: [:i | sum := sum + (arrayOfIntegers at: i)].
						. ^sum' ].
	normal := oc
		noPattern: false;
		compile:
			'integerSum: arrayOfIntegers
						sum := 0. 
						1 to: arrayOfIntegers size do: [:i | sum := sum + (arrayOfIntegers at: i)].
						. ^sum'.
	self assert: unrolled bytecode ~= normal bytecode.
	^ {}
]

{ #category : #running }
Req2 >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	oc := self class compiler
		yourself.
	oc compilationContext astTranslatorClass: OCASTTranslatorBis
]

{ #category : #tests }
Req2 >> testSum [
	| asserted expected |
	asserted := oc
			noPattern: true;
		evaluate: 'sum := 0. 1 _to: 10 unrollBy: 3 do: [ :i | sum := sum + i ]. ^sum'.
	"	self halt."
	expected := oc
			noPattern: true;
		evaluate: 'sum := 0. 1 to: 10 do: [ :i | sum := sum + i ]. ^sum'.
	self assert: asserted equals: expected
]
