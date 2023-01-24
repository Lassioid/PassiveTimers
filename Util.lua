local _, Util = ...
local State = {}
-- ***** FIELD VALUES *****
-- frameKey
-- itemId
-- type (tracker type e.g. "item")
-- texture (item texture)
-- internalCooldown (item internal cooldown)
-- auraName (buff or aura name)
-- trackerPosition (offsetX, offsetY)
-- trackerSize

SlashCmdList["TRACKERTOGGLE"] = function(msg)
	if TrackerConfig:IsVisible() == false then
		TrackerConfig:Show()
	else 
		TrackerConfig:Hide()
	end
end

SLASH_TRACKERTOGGLE1 = "/icd"

local function ParseHyperLink (str)
    local hyperLinkStr = str:gsub("|", "||");
    local startIdx = string.find(hyperLinkStr, "%[")
    local endIdx = string.find(hyperLinkStr, "%]")
    return string.sub(hyperLinkStr, startIdx+1, endIdx-1)
end

Util.State = State
Util.ParseHyperLink = ParseHyperLink