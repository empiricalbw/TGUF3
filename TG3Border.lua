--[[
--  Frame that just provides a border texture.  Typically you may wish to place
--  this in a higher strata (i.e. "MEDIUM") so that it appears above all other
--  frames that are part of the unit frame.
--
--  Required attributes:
--
--      edgeFile - edge texture file (string)
--      edgeSize - size of the corners (int)
--
--  Optional attributes:
--
--      edgeColor    - color to apply to the border {r, g, b, a}
--      colorize     - true/false; whether or not to apply following colors:
--      magicColor   - color to apply to the border if magic debuff present
--      diseaseColor - color to apply to the border if disease present
--      curseColor   - color to apply to the border if curse present
--      poisonColor  - color to apply to the border if poison present
--]]
TGUF3.Border = {
    _name = "TGUF3.Border",
    _xml  = "TG3BorderTemplate",
}
TG3BorderMixin = TGUF3.Border

function TGUF3.Border:Init(elem)
    local backdrop = {
        edgeFile = elem.edgeFile,
        edgeSize = elem.edgeSize,
    }
    self.edgeColor    = elem.edgeColor    or {1, 1, 1, 1}
    self.colorize     = elem.colorize
    self.magicColor   = elem.magicColor   or {0.2, 0.6, 1, 1}
    self.diseaseColor = elem.diseaseColor or {0.6, 0.4, 0, 1}
    self.curseColor   = elem.curseColor   or {0.6, 0, 1, 1}
    self.poisonColor  = elem.poisonColor  or {0, 0.6, 0, 1}
    self.enrageColor  = elem.enrageColor  or {0.6, 0, 0, 1}

    self:SetBackdrop(backdrop)
    self:SetBackdropBorderColor(unpack(self.edgeColor))
end

function TGUF3.Border:UPDATE_DEBUFFS(unit)
    if not self.colorize or unit.reaction ~= TGU.REACTION_FRIENDLY then
        return
    end

    if TGUF3.canCureMagic and unit.debuffCounts.Magic > 0 then
        self:SetBackdropBorderColor(unpack(self.magicColor))
    elseif TGUF3.canCureDisease and unit.debuffCounts.Disease > 0 then
        self:SetBackdropBorderColor(unpack(self.diseaseColor))
    elseif TGUF3.canCureCurse and unit.debuffCounts.Curse > 0 then
        self:SetBackdropBorderColor(unpack(self.curseColor))
    elseif TGUF3.canCurePoison and unit.debuffCounts.Poison > 0 then
        self:SetBackdropBorderColor(unpack(self.poisonColor))
    else
        self:SetBackdropBorderColor(unpack(self.edgeColor))
    end
end

function TGUF3.Border:UPDATE_BUFFS(unit)
    if not self.colorize or unit.reaction ~= TGU.REACTION_HOSTILE then
        return
    end

    TGUF3.canDispelMagic = true
    if TGUF3.canDispelMagic and unit.buffCounts.Magic > 0 then
        self:SetBackdropBorderColor(unpack(self.magicColor))
    elseif TGUF3.canDispelEnrage and unit.buffCounts.Enrage > 0 then
        self:SetBackdropBorderColor(unpack(self.enrageColor))
    else
        self:SetBackdropBorderColor(unpack(self.edgeColor))
    end
end

function TGUF3.Border:UPDATE_REACTION(unit)
    self:UPDATE_BUFFS(unit)
    self:UPDATE_DEBUFFS(unit)
end
