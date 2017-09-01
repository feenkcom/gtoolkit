examples
b
	<gtExample>
	<label: 'Dummy #b, depends #a'>
	<description: 'should return false'>
	"<dependsOn: #a>"
	
	^ self a & false