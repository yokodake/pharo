Extension { #name : #BlockClosure }

{ #category : #'*META-LAB-Promises' }
BlockClosure >> promise [
	^ (Promise withBlock: self) start
]
