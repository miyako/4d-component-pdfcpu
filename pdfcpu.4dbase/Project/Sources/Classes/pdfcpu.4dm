Class extends CLI

Class constructor()
	
	Super:C1705()
	
Function remove_properties($inFile : 4D:C1709.File; $properties : Collection)->$status : Object
	
	$arguments:="properties remove "+This:C1470.escape_param(File:C1566($inFile.platformPath; fk platform path:K87:2).path)
	
	var $property : Text
	
	For each ($property; $properties)
		$arguments:=$arguments+" '"+$property
	End for each 
	
	$command:=This:C1470.getCommandName()+" "+$arguments
	
	$status:=This:C1470.execute($command)
	
Function list_properties($inFile : 4D:C1709.File)->$status : Object
	
	$arguments:="properties list "+This:C1470.escape_param(File:C1566($inFile.platformPath; fk platform path:K87:2).path)
	
	$command:=This:C1470.getCommandName()+" "+$arguments
	
	$status:=This:C1470.execute($command)
	
Function add_properties($inFile : 4D:C1709.File; $properties : Object)->$status : Object
	
	$arguments:="properties add "+This:C1470.escape_param(File:C1566($inFile.platformPath; fk platform path:K87:2).path)
	
	var $property : Text
	
	For each ($property; $properties)
		$arguments:=$arguments+" '"+$property+" = "+$properties[$property]+"'"
	End for each 
	
	$command:=This:C1470.getCommandName()+" "+$arguments
	
	$status:=This:C1470.execute($command)