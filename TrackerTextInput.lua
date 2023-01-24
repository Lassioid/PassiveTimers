local inputFields = {
	["InternalCooldown"] = {
		["key"] = "InternalCooldown",
		["title"] = "Internal Cooldown",
		["x"] = 0,
		["y"] = -30,
		["maxLetters"] = 3
	},
	["Aura"] = {
		["key"] = "AuraName",
		["title"] = "Aura Name",
		["x"] = 0,
		["y"] = -70,
		["maxLetters"] = 30
	}
	-- add new field that will work for things like Revenge
}

local TextInputFields = CreateFrame("Frame", "TextInputFields", TrackerConfig)
TextInputFields:SetPoint("TOP", 0, -75)
TextInputFields:SetSize(150, 130)

local TextInputFieldsTexture = TextInputFields:CreateTexture(nil, "BACKGROUND")
TextInputFieldsTexture:SetAllPoints(TextInputFields)
TextInputFieldsTexture:SetSize(64, 64)
TextInputFieldsTexture:SetColorTexture(0, 0, 0, 0)

local function TextInput (field)
    local Input = CreateFrame("EditBox", field.key, TextInputFields, "BackdropTemplate")
    Input:SetAutoFocus(false)
    Input:SetSize(125, 15)
    Input:SetPoint("TOP", field.x, field.y)
    Input:SetFontObject("GameFontNormal")
    Input:SetMaxLetters(field.maxLetters)

    local Title = Input:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    Title:SetPoint("LEFT", 0, 16)
    Title:SetText(field.title)
    Title:SetFont("Fonts\\FRIZQT__.TTF", 11)

    local Texture = Input:CreateTexture()
    Texture:SetAllPoints(Input)
    Texture:SetSize(125, 15)
    Texture:SetColorTexture(0.1, 0.1, 0.1, 1)

    Input:SetPropagateKeyboardInput(false)
    
    Input:SetScript("OnEscapePressed", function(self, event) 
        Input:ClearFocus()
    end)

    Input:SetScript("OnEnterPressed", function(self, event)
        Input:ClearFocus()
    end)
end

--- MAP INPUT FIELDS TO FRAMES
for _, field in pairs(inputFields) do
	TextInput(field)
end

TextInputFields:Hide()
