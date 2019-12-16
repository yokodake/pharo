Class {
	#name : #Req2,
	#superclass : #TestCase,
	#instVars : [
		'oc'
	],
	#category : #'Meta-Assignment'
}

{ #category : #tests }
Req2 >> benchmark [
	| unrolled normal bench a e |
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
	bench := [ :c :arr | [ c valueWithReceiver: self arguments: {arr} ] timeToRun asNanoSeconds  ].
	a := bench
		value: (unrolled value: 3)
		value: (Interval from: 0 to: 100000) asArray.
	e := bench value: normal value: (Interval from: 0 to: 100000) asArray.
	self assert: a ~= e.
	^ #(1000 10000 100000 1000000 10000000)
		collect: [ :u | 
			| arr |
			arr := (Interval from: 0 to: u) asArray.
			u
				->
					{(bench value: normal value: arr).
					(bench value: (unrolled value: 1) value: arr).
					(bench value: (unrolled value: 2) value: arr).
					(bench value: (unrolled value: 4) value: arr).
					(bench value: (unrolled value: 10) value: arr)} ]
]

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
	self assert: (unrolled value: 4) bytecode size ~= normal bytecode size.
	^ {normal.
	(unrolled value: 1).
	(unrolled value: 2).
	(unrolled value: 8).
	(unrolled value: 16)} collect: [ :c | c bytecode size]
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
