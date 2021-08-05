--[[
--  Texture that is displayed only if the unit is currently the party/raid
--  leader.
--
--  Optional attributes:
--
--      id     - file name or file ID for the texture
--      coords - texture coordinates {left, right, top, bottom} with topleft
--               being (0,0) and bottomright being (1,1)
--      color  - vertex color to apply to the texture {r, g, b, a}
--]]
TGUF3.LeaderTexture = {
    _name  = "TGUF3.LeaderTexture",
    _xml   = "TG3LeaderTextureTemplate",
}
TG3LeaderTextureMixin = TGUF3.LeaderTexture

function TGUF3.LeaderTexture:Init(elem)
    local id     = elem.id or "Interface/GroupFrame/UI-Group-LeaderIcon"
    local coords = elem.coords or {0, 1, 0, 1}
    local color  = elem.color or {1, 1, 1, 1}
    
    self.Texture:SetTexture(id)
    self.Texture:SetTexCoord(unpack(coords))
    self.Texture:SetVertexColor(unpack(color))
end

function TGUF3.LeaderTexture:UPDATE_LEADER(unit)
    self:SetShown(unit.leader)
end
