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
-- Create the main frame
local frame = CreateFrame("FRAME", "TrueCitizenFrame")
frame:RegisterEvent("CHAT_MSG_MONSTER_YELL")

-- Event handler
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "CHAT_MSG_MONSTER_YELL" then
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
                        local delay = 2  -- 2 second delay
                        local elapsed = 0
                        local f = CreateFrame("Frame")
                        f:SetScript("OnUpdate", function(self, addTime)
                            elapsed = elapsed + addTime
                            if elapsed >= delay then
                                SendChatMessage("Thanks for this addon, Drom!", "YELL")
                                self:SetScript("OnUpdate", nil)
                            end
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
        print("|cff33ff99TrueCitizen|r: Active and ready to yell with Rhonin!")
    else
        -- Show help
        print("|cff33ff99TrueCitizen Commands:|r")
        print("|cff33ff99/truecitizen test|r - Test the yell functionality")
        print("|cff33ff99/truecitizen status|r - Show addon status")
        print("|cff33ff99/truecitizen help|r - Show this help")
    end
end
