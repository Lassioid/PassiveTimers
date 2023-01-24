

 --- tester 
local pull, seconds, onesec

--[[
   local frame = CreateFrame("Frame")

frame:Hide()

frame:SetScript("OnUpdate", function(self, elapsed)
    --Start DBM pull timer
    onesec = onesec - elapsed
    pull = pull - elapsed
    if pull <= 0 then
        print("Pulling!")
        TrackerFrame:SetAlpha(1)
        self:Hide()
    elseif onesec <= 0 then
        print(seconds)
        seconds = seconds - 1
        onesec = 1
    end
end)

SlashCmdList["COUNTDOWN"] = function(t)
    t = tonumber(t) or 3
    pull = t + 1
    seconds = t
    onesec = 1
    frame:Show()
end

SLASH_COUNTDOWN1 = "/inc" 
--]]