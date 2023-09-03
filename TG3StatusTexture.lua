--[[
--  Frame that justs supplies a solid texture whose color tracks the status of
--  the unit if we can cure or dispel it in some way.
--
--  At least one of id or color (possibly both) should be supplied.
--
--  Optional attributes:
--
--      magicColor   - color to apply to the border if magic debuff present
--      diseaseColor - color to apply to the border if disease present
--      curseColor   - color to apply to the border if curse present
--      poisonColor  - color to apply to the border if poison present
--      color        - color to apply if nothing else present, defaults to
--                     transparent
--]]
TGUF3.StatusTexture = {
    _name = "TGUF3.StatusTexture",
    _xml  = "TG3StatusTextureTemplate",
}
TG3StatusTextureMixin = TGUF3.StatusTexture

function TGUF3.StatusTexture:Init(elem)
    self.color        = elem.color        or {1, 1, 1, 0}
    self.magicColor   = elem.magicColor   or {0.2, 0.6, 1, 1}
    self.diseaseColor = elem.diseaseColor or {0.6, 0.4, 0, 1}
    self.curseColor   = elem.curseColor   or {0.6, 0, 1, 1}
    self.poisonColor  = elem.poisonColor  or {0, 0.6, 0, 1}
    self.enrageColor  = elem.enrageColor  or {0.6, 0, 0, 1}

    if elem.texture ~= nil then
        self.Texture:SetTexture(elem.texture)
    else
        self.Texture:SetColorTexture(1, 1, 1, 1)
    end
end

function TGUF3.StatusTexture:UPDATE_DEBUFFS(unit)
    if unit.reaction ~= TGU.REACTION_FRIENDLY then
        return
    end

    if TGUF3.canCureMagic and unit.debuffCounts.Magic > 0 then
        self.Texture:SetVertexColor(unpack(self.magicColor))
    elseif TGUF3.canCureDisease and unit.debuffCounts.Disease > 0 then
        self.Texture:SetVertexColor(unpack(self.diseaseColor))
    elseif TGUF3.canCureCurse and unit.debuffCounts.Curse > 0 then
        self.Texture:SetVertexColor(unpack(self.curseColor))
    elseif TGUF3.canCurePoison and unit.debuffCounts.Poison > 0 then
        self.Texture:SetVertexColor(unpack(self.poisonColor))
    else
        self.Texture:SetVertexColor(unpack(self.color))
    end
end

function TGUF3.StatusTexture:UPDATE_BUFFS(unit)
    if unit.reaction ~= TGU.REACTION_HOSTILE then
        return
    end

    TGUF3.canDispelMagic = true
    if TGUF3.canDispelMagic and unit.buffCounts.Magic > 0 then
        self.Texture:SetVertexColor(unpack(self.magicColor))
    elseif TGUF3.canDispelEnrage and unit.buffCounts.Enrage > 0 then
        self.Texture:SetVertexColor(unpack(self.enrageColor))
    elseif TGUF3.canSteal and unit.buffCounts.Stealable > 0 then
        self.Texture:SetVertexColor(unpack(self.magicColor))
    else
        self.Texture:SetVertexColor(unpack(self.color))
    end
end

function TGUF3.StatusTexture:UPDATE_REACTION(unit)
    self:UPDATE_BUFFS(unit)
    self:UPDATE_DEBUFFS(unit)
end
