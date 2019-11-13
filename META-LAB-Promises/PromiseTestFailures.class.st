Class {
	#name : #PromiseTestFailures,
	#superclass : #TestCase,
	#category : #'META-LAB-Promises'
}

{ #category : #tests }
PromiseTestFailures >> testFailedWhenResolvedCallsHandler [
	| promise sema resolved |
	sema := Semaphore new.
	promise := [ 1 / 0 ] promise.
	resolved := promise whenResolved: [ :arg1 | 1 ] whenFailed: [ sema signal ].
	sema wait: 1 seconds onCompletion: [ self assert: true ] onTimeout: [ self assert: false ]
]

{ #category : #tests }
PromiseTestFailures >> testPromiseNotFinishedthrowsException [
	| tmp1 |
	tmp1 := [ 1 + 1 ] promise.
	self should: [ tmp1 value ] raise: PromiseNotResolved
]

{ #category : #tests }
PromiseTestFailures >> testValueWhenResolvedPromiseThrowsError [
	| s promise resolved |
	s := Semaphore new.
	promise := [ 1 / 0 ] promise.
	resolved := promise whenResolved: [ :arg1 | s signal ].
	self should: [ resolved value ] raise: PromiseNotExecutable
]

{ #category : #tests }
PromiseTestFailures >> testWhenResolvedWhenFailedReturnsPromise [
	| sema resolved promise |
	sema := Semaphore new.
	promise := [ 1 + 1 ] promise.
	resolved := promise
		whenResolved: [ :arg1 | sema signal ]
		whenFailed: [ sema signal ].
	sema wait: 1 seconds onCompletion: [ self assert: true ] onTimeout: [ self assert: false ].
	self assert: resolved class equals: Promise. 
	self assert: resolved value class equals: Semaphore.
]
