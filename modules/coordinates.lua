-- $Id: coordinates.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local coordinate_text = Minimap:CreateFontString(nil, "OVERLAY")
coordinate_text:SetFont(recMedia.fontFace.NORMAL, 9, "OUTLINE")
coordinate_text:SetPoint("BOTTOM", 0, 4)
local coordinate_formatting = "%0.1f, %0.1f"

local string_format = string.format

local x, y
local function update_coordinate_text()
	x, y = GetPlayerMapPosition("player")
	if x > 0 and y > 0 then
		coordinate_text:SetText(string_format(coordinate_formatting, x*100, y*100))
	end
end

local t = 0
local function on_update(self, elapsed)
	t = t - elapsed
	if t < 0 then
		t = 1
		update_coordinate_text()
	end
end

Minimap:RegisterEvent("ZONE_CHANGED_NEW_AREA")
Minimap:HookScript("OnEvent", function(self, event, ...)
	if event == "ZONE_CHANGED_NEW_AREA" then
		SetMapToCurrentZone()
	end
end)
Minimap:HookScript("OnUpdate", on_update)

