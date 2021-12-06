--[[
--  Texture that displays the raid icon currently assigned to the unit.
--
--  Optional attributes:
--
--      id     - file name or file ID for the texture
--      coords - texture coordinates {left, right, top, bottom} with topleft
--               being (0,0) and bottomright being (1,1)
--      color  - vertex color to apply to the texture {r, g, b, a}
--]]
TGUF3.RaidIconTexture = {
    _name  = "TGUF3.RaidIconTexture",
    _xml   = "TG3RaidIconTextureTemplate",
}
TG3RaidIconTextureMixin = TGUF3.RaidIconTexture

function TGUF3.RaidIconTexture:Init(elem)
end

function TGUF3.RaidIconTexture:UPDATE_RAIDICON(unit)
    if unit.raidIcon then
        SetRaidTargetIconTexture(self.Texture, unit.raidIcon)
        self:Show()
    else
        self:Hide()
    end
end
