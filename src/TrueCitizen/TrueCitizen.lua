-- TrueCitizen Addon
-- Makes your character yell along with Rhonin in Dalaran

local addonName, addon = ...
local rhoninYell = "Citizens of Dalaran! Raise your eyes to the skies and observe!"
local inDalaran = false

-- Create the main frame
local frame = CreateFrame("FRAME", "TrueCitizenFrame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("CHAT_MSG_MONSTER_YELL")

-- Event handler
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
        -- Check if player is in Dalaran (Northrend)
        local currentZone = GetRealZoneText()
        inDalaran = (currentZone == "Dalaran")
    elseif event == "CHAT_MSG_MONSTER_YELL" and inDalaran then
        local msg, sender = ...
        -- Check if Rhonin is the one yelling the specific line
        if sender == "Rhonin" and msg == rhoninYell then
            -- Make the player yell the same line
            RunMacroText("/y " .. rhoninYell)
        end
    end
end)

-- Slash command for testing
SLASH_TRUECITIZEN1 = "/truecitizen"
SlashCmdList["TRUECITIZEN"] = function()
    print("|cff33ff99TrueCitizen|r: " .. (inDalaran and "In Dalaran" or "Not in Dalaran"))
    if inDalaran then
        print("Will yell along with Rhonin when he gives his speech.")
    end
end
