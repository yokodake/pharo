Class {
	#name : #TestWpo5,
	#superclass : #Object,
	#category : #'META-LAB'
}

{ #category : #tests }
TestWpo5 >> testExo11 [
  ((TabsExample methods) collect: [ :e | RBMessageNodeCounter countMessagesIn: e ]) sum
]

{ #category : #tests }
TestWpo5 >> testExo12 [
	(TabsExample methods
		collect: [ :arg1 | RBMessageSelfNodeCounter countMessagesIn: arg1 ]) sum 
]

{ #category : #tests }
TestWpo5 >> testExo21 [
	| foo install |
	foo := OrderedCollection new .

	install := [ :symbol | MetaLink new
								metaObject: [foo add: symbol ];
								selector: #value. ] .
			
	TabsExample class recompile . "recompiles all the methods "
	(TabsExample class methods) do: [ :cm |  cm ast link: (install value: cm selector) ] .

	TabsExample open .

	foo
]

{ #category : #tests }
TestWpo5 >> testExo31 [
	| link |
	link := MetaLink new
		metaObject: [ :node | node tagExecuted ];
		selector: #value:;
		arguments: #(node) .

	(Number>>#sin) ast link: link . 

	[(Number>>#sin) ast hasBeenExecuted not] assert.
	1 sin .
	[(Number>>#sin) ast hasBeenExecuted] assert .
	(Number>>#sin) ast removeProperty: #tagExecuted ifAbsent: [] .
	link uninstall
]
