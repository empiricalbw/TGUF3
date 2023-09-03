--[[
--  Texture that displays the role icon currently assigned to the unit.
--
--  No attributes.
--]]
TGUF3.RoleIconTexture = {
    _name  = "TGUF3.RoleIconTexture",
    _xml   = "TG3RoleIconTextureTemplate",
}
TG3RoleIconTextureMixin = TGUF3.RoleIconTexture

local VISIBLE_ROLES = {
    ["TANK"]    = 1,
    ["HEALER"]  = 1,
    ["DAMAGER"] = 1,
}

function TGUF3.RoleIconTexture:Init(elem)
end

function TGUF3.RoleIconTexture:UPDATE_ROLE(unit)
    if unit.role and VISIBLE_ROLES[unit.role] then
        self.Texture:SetTexCoord(GetTexCoordsForRole(unit.role))
        self:Show()
    else
        self:Hide()
    end
end
