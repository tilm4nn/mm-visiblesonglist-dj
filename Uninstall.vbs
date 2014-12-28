'
' MediaMonkey Script Uninstaller
'
' NAME: VisibleSongListDJ
'
' AUTHOR: Tilmann Kuhn http://www.object-zoo.net
'

Option Explicit

Sub Uninstall()
	Dim section : section = "VisibleSongListDJ"
	Dim inip : inip = SDB.ApplicationPath&"Scripts\Scripts.ini"
	Dim inif : Set inif = SDB.Tools.IniFileByPath(inip)
	If Not (inif Is Nothing) Then
	  inif.DeleteSection(section)
	End If
End Sub
