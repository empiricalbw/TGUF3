--[[
--  Texture that is displayed only if the unit is currently flagged for PVP.
--
--  Optional attributes:
--
--      id     - file name or file ID for the texture
--      coords - texture coordinates {left, right, top, bottom} with topleft
--               being (0,0) and bottomright being (1,1)
--      color  - vertex color to apply to the texture {r, g, b, a}
--]]
TGUF3.PVPTexture = {
    _name  = "TGUF3.PVPTexture",
    _xml   = "TG3PVPTextureTemplate",
}
TG3PVPTextureMixin = TGUF3.PVPTexture

function TGUF3.PVPTexture:Init(elem)
    local id    = elem.id or "Interface/GroupFrame/UI-Group-PVP-Alliance"
    local color = elem.color or {1, 1, 1, 1}

    local coords
    if not elem.id then
        coords = elem.coords or {0, 1, 0, 1}
    else
        coords = elem.coords or {0, 1, 0, 1}
    end
    
    self.Texture:SetTexture(id)
    self.Texture:SetTexCoord(unpack(coords))
    self.Texture:SetVertexColor(unpack(color))
end

function TGUF3.PVPTexture:UPDATE_PVPSTATUS(unit)
    local inPVP = (unit.pvpStatus ~= TGU.PVP_NONE)
    self:SetShown(inPVP)
end
