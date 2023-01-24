local _, Util = ...

local TrackerLayer = CreateFrame("Frame", "TrackerLayer", UIParent)
TrackerLayer:SetPoint("CENTER")
TrackerLayer:SetSize(UIParent:GetWidth(), UIParent:GetHeight())


local function Tracker (fields)
    local TrackerFrame = CreateFrame("Frame", fields.itemId, TrackerLayer, "BackdropTemplate")
    local TimerText = TrackerFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    TimerText:SetPoint("CENTER", -2, -2)
    TimerText:SetFont("Fonts\\FRIZQT__.TTF", 30, "OUTLINE, MONOCHROME")

    function TrackerFrame:StartCooldown(itemId)
            if itemId == fields.itemId then
            local icdDuration = tonumber(fields.internalCooldown);
            TimerText:SetText(icdDuration)
            TrackerFrame:SetAlpha(0.35)
            C_Timer.NewTicker(1, function() 
                icdDuration = icdDuration - 1
                TimerText:SetText(icdDuration)
            end, fields.internalCooldown)
            C_Timer.After(fields.internalCooldown + 0.25, function()
                TimerText:SetText("")
                TrackerFrame:SetAlpha(1)
            end)
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
		TrackerFrame:SetPoint("CENTER", 0, 0)
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
		local _, _, _, offsetX, offsetY = TrackerFrame:GetPoint()
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