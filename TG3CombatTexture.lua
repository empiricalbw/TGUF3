--[[
--  Texture that is displayed only if the unit is currently in combat.
--
--  Optional attributes:
--
--      id     - file name or file ID for the texture
--      coords - texture coordinates {left, right, top, bottom} with topleft
--               being (0,0) and bottomright being (1,1)
--      color  - vertex color to apply to the texture {r, g, b, a}
--]]
TGUF3.CombatTexture = {
    _name  = "TGUF3.CombatTexture",
    _xml   = "TG3CombatTextureTemplate",
}
TG3CombatTextureMixin = TGUF3.CombatTexture

function TGUF3.CombatTexture:Init(elem)
    local id    = elem.id or "Interface/CharacterFrame/UI-StateIcon"
    local color = elem.color or {1, 1, 1, 1}

    local coords
    if not elem.id then
        coords = elem.coords or {0.5, 1.0, 0, 0.5}
    else
        coords = elem.coords or {0, 1, 0, 1}
    end
    
    self.Texture:SetTexture(id)
    self.Texture:SetTexCoord(unpack(coords))
    self.Texture:SetVertexColor(unpack(color))
end

function TGUF3.CombatTexture:UPDATE_COMBAT(unit)
    self:SetShown(unit.combat)
end
