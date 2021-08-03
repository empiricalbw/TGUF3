TGUF3.HealthBar = {
    _name  = "TGUF3.HealthBar",
    _xml   = "TG3HealthBarTemplate",
    _ftype = "StatusBar",
}
TG3HealthBarMixin = TGUF3.HealthBar

function TGUF3.HealthBar:Init(elem)
    self.colorize    = elem.colorize    or true
    self.color       = elem.color       or {0, 1, 0, 1}
    self.highColor   = elem.highColor   or {1, 1, 0, 1}
    self.lowColor    = elem.lowColor    or {1, 0, 0, 1}
    self.tappedColor = elem.tappedColor or {0.5, 0.5, 0.5, 1}
    self.highPercent = elem.highPercent or 60
    self.lowPercent  = elem.lowPercent  or 30

    local texture = elem.texture or "Interface/Addons/TGUF_2/DUF_Images/bg"
    self:SetStatusBarTexture(texture)
end

function TGUF3.HealthBar:UPDATE_HEALTH(unit)
    if not unit.exists then
        return
    end

    if unit.tapped then
        self:SetStatusBarColor(unpack(self.tappedColor))
    else
        self:SetStatusBarColor(unpack(self.color))
    end
    self:SetMinMaxValues(0, unit.health.max)
    self:SetValue(unit.health.current)
end

TGUF3.HealthBar.UPDATE_TAPPED = TGUF3.HealthBar.UPDATE_HEALTH
