local _, Util = ...

--- CHECKBOX BUTTONS CONTAINER
local CheckBoxFields = CreateFrame("Frame", "CheckBoxFields", TrackerConfig)
CheckBoxFields:SetSize(56, 56)
CheckBoxFields:SetPoint("TOP", 0, -15)

--- CHECKBOX AURA BUTTON
local CheckBoxAura = CreateFrame("CheckButton", "CheckBoxAura", CheckBoxFields, "ChatConfigCheckButtonTemplate");
CheckBoxAura:SetPoint("CENTER", 15, 13);
CheckBoxAura:SetText("CheckBox Name");
CheckBoxAura.tooltip = "Example:\n\nBerserk\nSwordguard Embroidery\nGreatness\n..."

local CheckBoxAuraText = CheckBoxAura:CreateFontString(nil, "OVERLAY", "GameFontNormal")
CheckBoxAuraText:SetPoint("CENTER", 29, 1)
CheckBoxAuraText:SetText("Aura")

CheckBoxAura:SetScript("OnClick", function()
    if CheckBoxAura:GetChecked() == true then
		Util.State.type = "aura"
        CreateTracker:Show()
        TrackerConfig:SetSize(150, 215)
        CheckBoxItem:Disable()
        CheckBoxItem:SetAlpha(0.4)
        AuraName:Show()
        TextInputFields:Show()
        TrackerFrame[44253]()
    else
		Util.State = {}
        CreateTracker:Hide()
        TrackerConfig:SetSize(150, 85)
        CheckBoxItem:Enable()
        CheckBoxItem:SetAlpha(1)
        TextInputFields:Hide()
    end
	
end);

-- CHECKBOX ITEM BUTTON
local CheckBoxItem = CreateFrame("CheckButton", "CheckBoxItem", CheckBoxFields, "ChatConfigCheckButtonTemplate");
CheckBoxItem:SetPoint("CENTER", 15, -14);
CheckBoxItem:SetText("CheckBox Name");
CheckBoxItem.tooltip = "Example:\n\nDarkmoon Card: Death\nBandit's Insignia\nExtract of Necromantic Power\n...";

local CheckBoxItemText = CheckBoxItem:CreateFontString(nil, "OVERLAY", "GameFontNormal")
CheckBoxItemText:SetPoint("CENTER", 29, 1)
CheckBoxItemText:SetText("Item")

CheckBoxItem:SetScript("OnClick", function()
    if CheckBoxItem:GetChecked() == true then
		Util.State.type = "item"
        CreateTracker:Show()
        TrackerConfig:SetSize(150, 215)
        CheckBoxAura:Disable()
        CheckBoxAura:SetAlpha(0.4)
        AuraName:Hide()
        TextInputFields:Show()
    else
		Util.State = {}
        CreateTracker:Hide()
        TrackerConfig:SetSize(150, 85)
        CheckBoxAura:Enable()
        CheckBoxAura:SetAlpha(1)
        TextInputFields:Hide()
    end
end);
--***************************************************************************--

