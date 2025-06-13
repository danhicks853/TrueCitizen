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

local frame = CreateFrame("FRAME", "TrueCitizenFrame")
frame:RegisterEvent("CHAT_MSG_MONSTER_YELL")

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "CHAT_MSG_MONSTER_YELL" then
        local msg, sender = ...
        if sender == "Rhonin" then
            for _, yell in ipairs(rhoninYells) do
                if msg == yell then
                    SendChatMessage(yell, "YELL")
                    if yell == rhoninYells[#rhoninYells] and UnitName("player") == "Mithrix" then
                        SendChatMessage("Thanks for this addon, Drom!", "YELL")
                    end
                    break
                end
            end
        end
    end
end)
