--[[
--  Texture that displays the raid icon currently assigned to the unit.
--
--  No attributes.
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
