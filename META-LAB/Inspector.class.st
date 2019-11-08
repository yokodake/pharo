Class {
	#name : #Inspector,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#category : #'META-LAB'
}

{ #category : #'instance creation' }
Inspector class >> on: aObject [
	^ Inspector new setObj: aObject; yourself
]

{ #category : #'as yet unclassified' }
Inspector >> classHierarchy [
	^ object class withAllSuperclasses 
]

{ #category : #accessing }
Inspector >> getClass [
	^ object class
]

{ #category : #'as yet unclassified' }
Inspector >> getSuperclass [
	^ object class superclass
]

{ #category : #'as yet unclassified' }
Inspector >> makeSelectorDict [
	^ Dictionary newFrom: (self classHierarchy collect: [:e | e -> e selectors])
]

{ #category : #'as yet unclassified' }
Inspector >> setObj: anObject [ 
	object := anObject.
	^ anObject
]

{ #category : #'as yet unclassified' }
Inspector >> valueOf: aSymbol [
	^ object instVarNamed: aSymbol
]
