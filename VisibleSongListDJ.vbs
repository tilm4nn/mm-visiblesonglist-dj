' The MIT License
'
' Copyright (C) 2014 Tilmann Kuhn
' http://www.object-zoo.net
' mailto:visiblesonglistdj@object-zoo.net
'
' Permission is hereby granted, free of charge, to any person obtaining a copy of this
' software and associated documentation files (the "Software"), to deal in the Software
' without restriction, including without limitation the rights to use, copy, modify, merge,
' publish, distribute, sublicense, and/or sell copies of the Software, and to permit
' persons to whom the Software is furnished to do so, subject to the following conditions:
'
' The above copyright notice and this permission notice shall be included in all copies
' or substantial portions of the Software.
'
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
' INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
' PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
' FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
' OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
' DEALINGS IN THE SOFTWARE.
 
Option Explicit
 
' This procedure is called when this script should show some UI on Options Panel (note that it's about a very small 
' panel to be shown, more details should be configured in a separate window)
' Panel = Panel where script can place its controls
Sub InitConfigSheet(Panel)
' We have no configuration
End Sub
 
 
' This procedure is called when this script should remove its UI from Options Panel.
' Panel = Panel where UI controls were previously placed by the script
' SaveConfig = Whether user pressed Ok and values in the dialog should be applied and saved (to registry, ini file, or so)
Sub CloseConfigSheet(Panel, SaveConfig)
' We have no configuration
End Sub

Dim playableSongs : Set playableSongs = Nothing
Dim allArePlayed : allArePlayed = False
Script.RegisterEvent SDB, "OnTrackListFilled", "ClearPlayableSongs"
 
' This function prepares a new track to be added to Now Playing queue
Function GenerateNewTrack
	Set GenerateNewTrack = FindPlayableSong()
End Function

Function FindPlayableSong
	Do 
		Set FindPlayableSong = NextPlayableSong()
		If (allArePlayed) Then
			Exit Function
		End If
	Loop Until (HasNotBeenPlayed(FindPlayableSong))
End Function

Function NextPlayableSong()
	Dim playableSongIndex
	
	Call UpdatePlayableSongs()
	playableSongIndex = NextPlayableSongIndex()
	Set NextPlayableSong = RemovePlayableSong(playableSongIndex)
End Function

Function NextPlayableSongIndex() 
	Randomize
	NextPlayableSongIndex = Int(playableSongs.Count * Rnd)
End Function

Function HasNotBeenPlayed(song)
	Dim currentSongList
	Dim index
	HasNotBeenPlayed = True
	
	Set currentSongList = SDB.Player.CurrentSongList
	For index = 0 To currentSongList.Count - 1
		If (currentSongList.Item(index).ID = song.ID) Then
			HasNotBeenPlayed = False
			Exit Function
		End If
	Next
End Function

Function RemovePlayableSong(index)
	Set RemovePlayableSong = playableSongs.Item(index)
	playableSongs.Delete(index)
End Function

Sub ClearPlayableSongs()
	Set playableSongs = Nothing
End Sub

Sub UpdatePlayableSongs()
	If (playableSongs Is Nothing) Then
		Set playableSongs = SDB.AllVisibleSongList
		allArePlayed = False
	End If
	If (playableSongs.Count = 0) Then
		Set playableSongs = SDB.AllVisibleSongList
		allArePlayed = True
	End If
End Sub