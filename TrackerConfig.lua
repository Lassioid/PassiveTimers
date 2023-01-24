local _, Util = ...

SavedVars = {}

local Init = CreateFrame("Frame")

Init:RegisterEvent("ADDON_LOADED")

Init:SetScript("OnEvent", function(self, event, addon)
	if addon == "ItemProcs" then
		print ("PassiveTimers v1.0 loaded type /icd to start")
		for key, value in pairs(SavedVars) do
			Util.Tracker(SavedVars[key])
		end
	end
end)

SlashCmdList["TRACKERTOGGLE"] = function(msg)
	if TrackerConfig:IsVisible() == false then
		TrackerConfig:Show()
	else 
		TrackerConfig:Hide()
	end
end

SLASH_TRACKERTOGGLE1 = "/icd"


local TrackerConfig = CreateFrame("Frame", "TrackerConfig", UIParent, "BackdropTemplate")
TrackerConfig:SetPoint("CENTER", 0, 0)
TrackerConfig:SetSize(150, 85)
TrackerConfig:SetBackdrop({
	edgeFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeSize = 2,
})
TrackerConfig:SetBackdropBorderColor(0, 0, 0, 1)

local TrackerConfigTexture = TrackerConfig:CreateTexture(nil, "BACKGROUND")
TrackerConfigTexture:SetAllPoints(TrackerConfig)
TrackerConfigTexture:SetSize(64, 64)
TrackerConfigTexture:SetColorTexture(0, 0, 0, .95)
TrackerConfig:Hide()

local DragDropContainer = CreateFrame("Frame", "DragDropContainer", TrackerConfig, "BackdropTemplate")
DragDropContainer:SetPoint("TOP", -30, -19)
DragDropContainer:SetSize(48, 48)
DragDropContainer:SetMovable(true)
DragDropContainer:SetBackdropBorderColor(0, 0, 1, 0.8)
DragDropContainer:SetBackdrop({
	bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",
	edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border",
})

local DragDropField = CreateFrame("Button", "DragDropField", DragDropContainer, "SecureActionButtonTemplate");
DragDropField:SetPoint("CENTER", 0, 0)
DragDropField:SetSize(48, 48)
DragDropField:EnableMouse(true)

-- "Interface/PaperDoll/UI-PaperDoll-Slot-Trinket"
-- "Interface\\Paperdoll\\UI-PaperDoll-Slot-Relic.blp"
-- "Interface/Buttons/ButtonHilight-Square"

local DragDropTexture = DragDropField:CreateTexture()
DragDropTexture:SetAllPoints(DragDropField)
DragDropTexture:SetSize(64, 64)
DragDropTexture:SetTexture("Interface/PaperDoll/UI-PaperDoll-Slot-Trinket")

DragDropField:SetScript("OnClick", function(self, event, ...)
	local _, itemId, itemName, _, _ = GetCursorInfo()
	if itemId == nil then
		Util.State.texture = nil;
		Util.State.itemId = nil;
		Util.State.itemName = nil
		DragDropTexture:SetTexture("Interface/PaperDoll/UI-PaperDoll-Slot-Trinket")
	end
	if itemId ~= nil then
		DragDropTexture:SetTexture(GetItemIcon(itemId));
		Util.State.texture = GetItemIcon(itemId);
		Util.State.itemId = itemId;
		Util.State.itemName = Util.ParseHyperLink(itemName)
	end
end)

local CreateTracker = CreateFrame("Button", "CreateTracker", TrackerConfig, "GameMenuButtonTemplate")
CreateTracker:SetSize(100, 20)
CreateTracker:SetPoint("BOTTOM", 0, 15)
CreateTracker:SetText("Create")

CreateTracker:SetScript("OnClick", function(self, event, ...)
	local icd_text = InternalCooldown:GetText();
	local aura_text = AuraName:GetText();

	if string.len(icd_text) ~= 0 then 
		Util.State.internalCooldown = icd_text
	end

	if string.len(aura_text) ~= 0 then 
		Util.State.auraName = aura_text
	end

	SavedVars[Util.State.itemId] = Util.State

	TrackerConfig:Hide()
	Util.Tracker(Util.State)
	Util.State = {}
end)
CreateTracker:Hide()

local CombatLogListener = CreateFrame("Frame")

CombatLogListener:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

CombatLogListener:SetScript("OnEvent", function(self, event, ...) 
    local timeStamp, eventType, _, _, playerName, _, _, _, _, _, _, _, itemName, _, buffType, _, _ = CombatLogGetCurrentEventInfo()
	if eventType == "SPELL_AURA_APPLIED" and playerName == "Intimod" then
		print(timeStamp, eventType, playerName, itemName, buffType)
		for key, value in pairs(SavedVars) do 
			-- print(key, value)
		end
	end
	if eventType == "SPELL_DAMAGE" and playerName == "Intimod" then 
		print(timeStamp, eventType, playerName, itemName, buffType)
		for key, value in pairs(SavedVars) do
			if SavedVars[key].itemName == itemName then
				TrackerFrame:StartCooldown(SavedVars[key].itemId)
			end
			print(
				key, value,
				SavedVars[key].itemId,
				SavedVars[key].type, 
				SavedVars[key].itemName,
				SavedVars[key].itemName == itemName
			)
		end
	end
end)