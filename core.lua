-- $Id: core.lua 594 2010-03-07 20:07:35Z john.d.mann@gmail.com $

local event_frame = CreateFrame("Frame")

-- Objects which we want to get rid of.
local unwanted_objects = {
	MinimapBorder,
	MinimapZoneTextButton,
	MinimapToggleButton,
	MiniMapMailFrame,
	MiniMapBattlefieldFrame,
	MiniMapVoiceChatFrame,
	GameTimeFrame,
	MiniMapWorldMapButton,
	MinimapZoomIn,
	MinimapZoomOut,
	MinimapBorderTop,
	MiniMapInstanceDifficulty,
	TimeManagerClockButton,
	MinimapNorthTag
}

event_frame:SetScript("OnEvent", function(self, event)
	-- Only have to run this once.
	self:UnregisterEvent(event)
	self:SetScript("OnEvent", nil)
	
	-- Make Minimap square
	Minimap:SetMaskTexture([[Interface\AddOns\recMinimap\media\square]])
	
	-- Position Minimap
	Minimap:SetParent(TestTextureFrame)
	Minimap:ClearAllPoints()
	Minimap:SetPoint("CENTER", MiniMapPanel)
	Minimap:SetSize(142, 142)

	-- Disable cluster mouse trapping (We don't move the cluster, it is still in the upper right corner of the screen.
	MinimapCluster:EnableMouse(false)
	
	-- Remove unwanted objects
	for _, object in pairs(unwanted_objects) do
		recLib.Kill(object)
	end
	unwanted_objects = nil
	
	Minimap:SetScript("OnMouseWheel", function(self, direction)
		if direction > 0 then
			Minimap_ZoomIn()
		else
			Minimap_ZoomOut()
		end
	end)
	Minimap:EnableMouseWheel(true)
	
	event_frame = nil
end)

event_frame:RegisterEvent("PLAYER_ENTERING_WORLD")