//%attributes = {"executedOnServer":true,"preemptive":"capable"}
//execute on server

$pdfcpu:=cs:C1710.pdfcpu.new()

$PDF:=Folder:C1567(fk resources folder:K87:11).file("test.pdf")

$status:=$pdfcpu.remove_properties($PDF; New collection:C1472("Author"; "Title"))

$status:=$pdfcpu.add_properties($PDF; New object:C1471("Title"; "あ"; "Author"; "あ"))

$status:=$pdfcpu.list_properties($PDF)

