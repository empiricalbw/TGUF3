TGUF3.Model = {
    _name  = "TGUF3.Model",
    _xml   = "TG3ModelTemplate",
    _ftype = "PlayerModel",
}
TG3ModelMixin = TGUF3.Model

function TGUF3.Model:Init(elem)
    self.backgroundColor = elem.backgroundColor or {0.5, 0.5, 0.5, 0.3}
    self.impossibleColor = elem.impossibleColor or {1, 0.1, 0.1, 0.5}
    self.veryHardColor   = elem.veryHardColor   or {1, 0.5, 0.25, 0.5}
    self.hardColor       = elem.hardColor       or {1, 1, 0, 0.5}
    self.standardColor   = elem.standardColor   or {0.25, 0.75, 0.25}
    self.trivialColor    = elem.trivialColor    or {0.5, 0.5, 0.5, 0.5}
    
    self.tguMask = bit.bor(TGU.FLAGS.LEVEL,
                           TGU.FLAGS.NPC,
                           TGU.FLAGS.REACTION)
end

function TGUF3.Model:UPDATE_BITMASK(unit, flags)
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
        elseif diff >= 2 then
            color = self.hardColor
        elseif diff >= -GetQuestGreenRange() then
            color = self.standardColor
        else
            color = self.trivialColor
        end
    end

    self.Background:SetColorTexture(unpack(color))
end