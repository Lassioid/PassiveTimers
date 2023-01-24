local _, Util = ...

local function Tracker (fields)

    local TrackerFrame = CreateFrame("Frame", "TrackerFrame", UIParent, "BackdropTemplate")

    function TrackerFrame:StartCooldown(itemId)
        if itemId == fields.itemId then
            TrackerFrame:SetAlpha(0.5)
        end
    end

	if fields.position then
		TrackerFrame:SetPoint(
			"TOPLEFT", 
			nil, 
			"TOPLEFT", 
			fields.position.offsetX, 
			fields.position.offsetY
		)
	else 
		Tracker:SetPoint("CENTER", 0, 0)
	end
    TrackerFrame:EnableMouse(true)
    TrackerFrame:SetResizable(true)
    TrackerFrame:SetMovable(true)
    TrackerFrame:RegisterForDrag("LeftButton", "RightButton")
    TrackerFrame:SetSize(64, 64)
    TrackerFrame:SetBackdrop({
        edgeFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeSize = 2,
    })
    TrackerFrame:SetBackdropBorderColor(0, 0, 0, 1)
    TrackerFrame.tooltip = "Example:\n\nDarkmoon Card: Death\nBandit's Insignia\nExtract of Necromantic Power\n...";

    local TrackerTexture = TrackerFrame:CreateTexture(nil, "BACKGROUND")
    TrackerTexture:SetAllPoints(TrackerFrame)
    TrackerTexture:SetSize(64, 64)
    TrackerTexture:SetColorTexture(0, 0, 0, .95)
    TrackerTexture:SetTexture(fields.texture)

    TrackerFrame:SetScript("OnDragStart", function(self, event, payload)

        if event == "LeftButton" then
            self:StartSizing("BOTTOMRIGHT")
        end

        if event == "RightButton" then 
            self:StartMoving()
        end

    end)

    TrackerFrame:SetScript("OnDragStop", function(self, event, payload)
		local _, _, _, offsetX, offsetY = Tracker:GetPoint()
        if event == nil then
            if self:GetWidth() < 25 or self:GetHeight() < 25 then
                self:SetSize(64, 64)
            end
            self:StopMovingOrSizing()
			SavedVars[fields.itemId].position = {
				["offsetX"] = offsetX,
				["offsetY"] = offsetY
			}
        end
    end)
end

Util.Tracker = Tracker