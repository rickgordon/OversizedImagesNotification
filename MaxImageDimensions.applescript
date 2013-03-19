(* AppleScript to notify and Finder-select images in a folder that are over a designated size. The property pMaxFileSize (intially set to 2,000,000) is the maximum unflagged dimensions. Calculation is based on dimensions rather than physical file size. *)
(* © 2013 Rick Gordon under Creative Commons License *)

--

property pMaxFileSize : 2000000
set vOversizeList to {}

set vFolder to (choose folder)
tell application "System Events" to set vList to files of vFolder
repeat with vItem in vList
  set vAlias to vItem as alias
	tell application "Image Events"
		open vAlias
		set vDimList to dimensions of image 1
		if ((item 1 of vDimList) * (item 2 of vDimList)) > vMaxFileSize then
			set end of vOversizeList to vAlias
		end if
		close image 1
	end tell
end repeat
tell application "Finder"
	activate
	open vFolder
	select items of vOversizeList
end tell
return vOversizeList
