-- TrueCitizen Addon
-- Makes your character yell along with Rhonin in Dalaran

local addonName, addon = ...
local rhoninYells = {
    "Citizens of Dalaran! Raise your eyes to the skies and observe!",
    "Today our world's destruction has been averted in defiance of our very makers!",
    "Algalon the Observer, herald of the titans, has been defeated by our brave comrades in the depths of the titan city of Ulduar.",
    "Algalon was sent here to judge the fate of our world.",
    "He found a planet whose races had deviated from the titans' blueprints. A planet where not everything had gone according to plan.",
    "Cold logic deemed our world not worth saving. Cold logic, however, does not account for the power of free will. It's up to each of us to prove this is a world worth saving.",
    "That our lives... our lives are worth living."
}
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
        -- Check if Rhonin is the one yelling any of his speech lines
        if sender == "Rhonin" then
            -- Check if this is one of Rhonin's speech lines
            for _, yell in ipairs(rhoninYells) do
                if msg == yell then
                    -- Make the player yell the same line
                    SendChatMessage(yell, "YELL")
                    
                    -- If this is the last line and player is Mithrix, add a special message
                    if yell == rhoninYells[#rhoninYells] and UnitName("player") == "Mithrix" then
                        C_Timer.After(2, function()
                            SendChatMessage("Thanks for this addon, Drom!", "YELL")
                        end)
                    end
                    break
                end
            end
        end
    end
end)

-- Slash command for testing and control
SLASH_TRUECITIZEN1 = "/truecitizen"
SLASH_TRUECITIZEN2 = "/tc"  -- Add an alias for convenience
SlashCmdList["TRUECITIZEN"] = function(msg)
    local cmd = strlower(strtrim(msg or ""))
    
    if cmd == "test" then
        -- Test the yell functionality
        local testMsg = "Testing TrueCitizen addon!"
        SendChatMessage(testMsg, "YELL")
        print("|cff33ff99TrueCitizen|r: Test yell sent!")
    elseif cmd == "status" then
        -- Show status information
        print("|cff33ff99TrueCitizen|r: " .. (inDalaran and "In Dalaran" or "Not in Dalaran"))
        if inDalaran then
            print("Will yell along with Rhonin when he gives his speech.")
        end
    else
        -- Show help
        print("|cff33ff99TrueCitizen Commands:|r")
        print("|cff33ff99/truecitizen test|r - Test the yell functionality")
        print("|cff33ff99/truecitizen status|r - Show addon status")
        print("|cff33ff99/truecitizen help|r - Show this help")
    end
end
