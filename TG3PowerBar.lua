--[[
--  Status bar that tracks the power (mana, rage, energy, etc.) of the unit.
--
--  Optional attributes:
--
--      texture     - texture used in the status bar
--      manaColor   - color to use for mana
--      rageColor   - color to use for rage
--      energyColor - color to use for energy
--]]
TGUF3.PowerBar = {
    _name  = "TGUF3.PowerBar",
    _xml   = "TG3PowerBarTemplate",
    _ftype = "StatusBar",
}
TG3PowerBarMixin = TGUF3.PowerBar

function TGUF3.PowerBar:Init(elem)
    self.colors = {
        [0] = elem.manaColor or {0.376, 0.624, 1, 1},
        [1] = elem.rageColor or {0.675, 0.15, 0.15, 1},
        [3] = elem.energyColor or {0.75, 0.75, 0.25, 1},
    }

    local texture = elem.texture or "Interface/Addons/TGUF_2/DUF_Images/bg"
    self:SetStatusBarTexture(texture)
end

function TGUF3.PowerBar:UPDATE_POWER(unit)
    if not unit.exists then
        return
    end

    self:SetStatusBarColor(unpack(self.colors[unit.power.type]))
    self:SetMinMaxValues(0, unit.power.max)
    self:SetValue(unit.power.current)
end
