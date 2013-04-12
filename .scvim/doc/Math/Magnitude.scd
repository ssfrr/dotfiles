Magnitude			comparable value in a linear continuum

inherits from: Object

Magnitudes represent values along a linear continuum which can be compared against each other.

	
	< aMagnitude
	
		Answer a Boolean whether the receiver is less than aMagnitude.
	
	<= aMagnitude
	
		Answer a Boolean whether the receiver is less than or equal to aMagnitude.
	
	> aMagnitude
	
		Answer a Boolean whether the receiver is greater than aMagnitude.
	
	>= aMagnitude
	
		Answer a Boolean whether the receiver is greater than or equal to aMagnitude.
	
	min(aMagnitude)
	
		Answer the minimum of the receiver and aMagnitude.
	
	max(aMagnitude)
	
		Answer the maximum of the receiver and aMagnitude.
	
	clip(minVal, maxVal)
	
		If the receiver is less than minVal then answer minVal, else if the receiver is greater than maxVal then answer maxVal, else answer the receiver.
	
	inclusivelyBetween(minVal, maxVal)
	
		Answer whether the receiver is greater than or equal to minVal and less than or equal to maxVal.
	
	exclusivelyBetween(minVal, maxVal)
	
		Answer whether the receiver is greater than minVal and less than maxVal.
	
	 


