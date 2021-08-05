--[[
--  Color texture that tracks the difficulty of the unit compared to the level
--  of the player.
--
--  Optional attribtues (all {r, g, b, a} colors):
--
--      backgroundColor - used when targeting a friendly PC
--      impossibleColor - used when unit is 5 or more levels higher ("red")
--      veryHardColor   - used when unit is 3-4 levels higher ("orange")
--      hardColor       - used when unit is within +-2 levels ("yellow")
--      standardColor   - used when unit is within the quest green level range
--                        ("green")
--      trivialColor    - used when the unit is below the quest green level
--                        range and won't award XP ("gray")
--]]
TGUF3.ConTexture = {
    _name  = "TGUF3.ConTexture",
    _xml   = "TG3ConTextureTemplate",
}
TG3ConTextureMixin = TGUF3.ConTexture

function TGUF3.ConTexture:Init(elem)
    self.backgroundColor = elem.backgroundColor or {0.5, 0.5, 0.5, 0.3}
    self.impossibleColor = elem.impossibleColor or {1, 0.1, 0.1, 0.35}
    self.veryHardColor   = elem.veryHardColor   or {1, 0.5, 0.25, 0.5}
    self.hardColor       = elem.hardColor       or {1, 1, 0, 0.5}
    self.standardColor   = elem.standardColor   or {0.25, 0.55, 0.25}
    self.trivialColor    = elem.trivialColor    or {0.5, 0.5, 0.5, 0.5}
    
    self.tguMask = bit.bor(TGU.FLAGS.LEVEL,
                           TGU.FLAGS.NPC,
                           TGU.FLAGS.REACTION)
end

function TGUF3.ConTexture:UPDATE_BITMASK(unit, flags)
    if not unit.exists then
        return
    end

    local color
    if not unit.npc and unit.reaction == TGU.REACTION_FRIENDLY then
        -- Friendly PCs don't get a colored background.
        color = self.backgroundColor
    else
        local diff = unit.level - UnitLevel("player")
        if diff >= 5 then
            color = self.impossibleColor
        elseif diff >= 3 then
            color = self.veryHardColor
        elseif diff >= -2 then
            color = self.hardColor
        elseif diff >= -GetQuestGreenRange() then
            color = self.standardColor
        else
            color = self.trivialColor
        end
    end

    self.Texture:SetColorTexture(unpack(color))
end
