--[[
--  Texture that is displayed only if the unit is currently the master looter.
--
--  Optional attributes:
--
--      id     - file name or file ID for the texture
--      coords - texture coordinates {left, right, top, bottom} with topleft
--               being (0,0) and bottomright being (1,1)
--      color  - vertex color to apply to the texture {r, g, b, a}
--]]
TGUF3.LootMasterTexture = {
    _name  = "TGUF3.LootMasterTexture",
    _xml   = "TG3LootMasterTextureTemplate",
}
TG3LootMasterTextureMixin = TGUF3.LootMasterTexture

function TGUF3.LootMasterTexture:Init(elem)
    local id     = elem.id or "Interface/GroupFrame/UI-Group-MasterLooter"
    local coords = elem.coords or {0, 1, 0, 1}
    local color  = elem.color or {1, 1, 1, 1}
    
    self.Texture:SetTexture(id)
    self.Texture:SetTexCoord(unpack(coords))
    self.Texture:SetVertexColor(unpack(color))
end

function TGUF3.LootMasterTexture:UPDATE_LOOT_MASTER(unit)
    self:SetShown(unit.lootMaster)
end
