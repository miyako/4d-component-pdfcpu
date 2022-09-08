Class constructor($name : Text)
	
	This:C1470.name:=OB Class:C1730(This:C1470).name
	
Function _currentDirectory()->$folder : 4D:C1709.Folder
	
	$folder:=Folder:C1567(Get 4D folder:C485(Database folder:K5:14); fk platform path:K87:2).folder("CLI").folder(This:C1470.name)
	
	Case of 
		: (Is macOS:C1572)
			$folder:=$folder.folder("MacOS")
		: (Is Windows:C1573)
			$folder:=$folder.folder("Windows64")
	End case 
	
	$folder:=Folder:C1567($folder.platformPath; fk platform path:K87:2)
	
Function setcurrentDirectory()
	
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY"; This:C1470._currentDirectory().platformPath)
	
Function getCommandName()->$name : Text
	
	Case of 
		: (Is macOS:C1572)
			$name:=This:C1470.name
		: (Is Windows:C1573)
			$name:=This:C1470.name+".exe"
	End case 
	
Function getCommandPath()->$path : Text
	
	$folder:=This:C1470._currentDirectory()
	
	$file:=$folder.file(This:C1470.getCommandName())
	
	$path:=$file.path
	
Function getEncoding()->$encoding : Text
	
	Case of 
		: (Is macOS:C1572)
			$encoding:="utf-8"
		: (Is Windows:C1573)
			$encoding:="utf-16le"
	End case 
	
Function execute($command : Text)->$status : Object
	
	$status:=New object:C1471
	
	var $stdIn; $stdOut; $stdErr : Blob
	var $pid : Integer
	
	This:C1470.setcurrentDirectory()
	
	LAUNCH EXTERNAL PROCESS:C811($command; $stdIn; $stdOut; $stdErr; $pid)
	
	$status.command:=$command
	$status.stdOut:=Convert to text:C1012($stdOut; This:C1470.getEncoding())
	$status.stdErr:=Convert to text:C1012($stdErr; This:C1470.getEncoding())
	
Function escape_param()->$escape_param : Text
	
	If (Count parameters:C259#0)
		
		$escape_param:=$1
		
		C_LONGINT:C283($i; $len)
		
		Case of 
			: (Is Windows:C1573)
				
				//argument escape for cmd.exe; other commands (curl, ruby, etc.) may be incompatible
				
				$shoudQuote:=False:C215
				
				$metacharacters:="&|<>()%^\" "
				
				$len:=Length:C16($metacharacters)
				
				For ($i; 1; $len)
					$metacharacter:=Substring:C12($metacharacters; $i; 1)
					$shoudQuote:=$shoudQuote | (Position:C15($metacharacter; $escape_param; *)#0)
					If ($shoudQuote)
						$i:=$len
					End if 
				End for 
				
				If ($shoudQuote)
					If (Substring:C12($escape_param; Length:C16($escape_param))="\\")
						$escape_param:="\""+$escape_param+"\\\""
					Else 
						$escape_param:="\""+$escape_param+"\""
					End if 
				End if 
				
			: (Is macOS:C1572)
				
				$metacharacters:="\\!\"#$%&'()=~|<>?;*`[] "
				
				For ($i; 1; Length:C16($metacharacters))
					$metacharacter:=Substring:C12($metacharacters; $i; 1)
					$escape_param:=Replace string:C233($escape_param; $metacharacter; "\\"+$metacharacter; *)
				End for 
				
		End case 
		
	End if 