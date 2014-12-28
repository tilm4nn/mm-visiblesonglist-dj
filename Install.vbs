'
' MediaMonkey Script Uninstaller
'
' NAME: VisibleSongListDJ
'
' AUTHOR: Tilmann Kuhn http://www.object-zoo.net
'

Option Explicit

Sub Install()
	Dim section : section = "VisibleSongListDJ"
	Dim inip : inip = SDB.ApplicationPath&"Scripts\Scripts.ini"
	Dim inif : Set inif = SDB.Tools.IniFileByPath(inip)
	If Not (inif Is Nothing) Then
		inif.StringValue(section,"Filename") = "VisibleSongListDJ.vbs"
		inif.StringValue(section,"DisplayName") = "Visible Song List DJ"
		inif.StringValue(section,"Description") = "An AutoDJ which selects random tracks from the visible song list"
		inif.StringValue(section,"Language") = "VBScript"
		inif.StringValue(section,"ScriptType") = "4"
		SDB.RefreshScriptItems
	End If  
End Sub