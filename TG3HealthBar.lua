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
