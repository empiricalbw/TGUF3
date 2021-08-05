--[[
--  Status bar that tracks the health of the unit.  The status bar can
--  optionally change color dynamically based on the health of the unit.  The
--  color is linearly interpolated across the upper two regions in the health
--  bar and kept at a solid color for the bottom region:
--
--      +----------+------------------+-----------------+
--      | lowColor | low to highColor | high to "color" |
--      +----------+------------------+-----------------+
--              lowPercent         highPercent
--
--  Optional attributes:
--
--      texture     - texture used in the healthbar
--      colorize    - whether or not to dynamically change color based on
--                    percent health remaining (boolean)
--      color       - color to use when not colorizing; color to use for top end
--                    of high range, i.e. max health ({r, g, b, a} color)
--      highColor   - color used at highPercent breakpoint
--      lowColor    - color used at lowPercent breakpoint
--      tappedColor - color to use when targetting a "tapped" mob
--      highPercent - high breakpoint percentage (0 - 100)
--      lowPercent  - low breakpoint percentage (0 - 100)
--]]
TGUF3.HealthBar = {
    _name  = "TGUF3.HealthBar",
    _xml   = "TG3HealthBarTemplate",
    _ftype = "StatusBar",
}
TG3HealthBarMixin = TGUF3.HealthBar

local function interp(p, c_low, c_high)
    local r = c_low[1] + p*(c_high[1] - c_low[1])
    local g = c_low[2] + p*(c_high[2] - c_low[2])
    local b = c_low[3] + p*(c_high[3] - c_low[3])
    local a = c_low[4] + p*(c_high[4] - c_low[4])
    return r, g, b, a
end

function TGUF3.HealthBar:Init(elem)
    self.colorize    = elem.colorize    or true
    self.color       = elem.color       or {0, 1, 0, 1}
    self.highColor   = elem.highColor   or {1, 1, 0, 1}
    self.lowColor    = elem.lowColor    or {1, 0, 0, 1}
    self.tappedColor = elem.tappedColor or {0.5, 0.5, 0.5, 1}
    self.highPercent = (elem.highPercent or 60) / 100
    self.lowPercent  = (elem.lowPercent  or 30) / 100

    local texture = elem.texture or "Interface/Addons/TGUF_2/DUF_Images/bg"
    self:SetStatusBarTexture(texture)
end

function TGUF3.HealthBar:UPDATE_HEALTH(unit)
    if not unit.exists then
        return
    end

    if unit.tapped then
        self:SetStatusBarColor(unpack(self.tappedColor))
    elseif self.colorize then
        local p = unit.health.current / unit.health.max
        if p <= self.lowPercent then
            self:SetStatusBarColor(unpack(self.lowColor))
        elseif p <= self.highPercent then
            p = (p - self.lowPercent)/(self.highPercent - self.lowPercent)
            self:SetStatusBarColor(interp(p, self.lowColor, self.highColor))
        elseif p < 1 then
            p = (p - self.highPercent)/(1 - self.highPercent)
            self:SetStatusBarColor(interp(p, self.highColor, self.color))
        else
            self:SetStatusBarColor(unpack(self.color))
        end
    else
        self:SetStatusBarColor(unpack(self.color))
    end
    self:SetMinMaxValues(0, unit.health.max)
    self:SetValue(unit.health.current)
end

TGUF3.HealthBar.UPDATE_TAPPED = TGUF3.HealthBar.UPDATE_HEALTH
