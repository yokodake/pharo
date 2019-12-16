Extension { #name : #BlockClosure }

{ #category : #'*Meta-Assignment' }
BlockClosure >> asMyBlockClosure [
	^ MyBlockClosure withBlock: self
]
