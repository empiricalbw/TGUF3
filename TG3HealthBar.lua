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
    self.icolor      = elem.icolor      or {unpack(self.color)}
    self.ihighColor  = elem.ihighColor  or {unpack(self.highColor)}
    self.ilowColor   = elem.ilowColor   or {unpack(self.lowColor)}
    self.tappedColor = elem.tappedColor or {0.5, 0.5, 0.5, 1}
    self.highPercent = (elem.highPercent or 60) / 100
    self.lowPercent  = (elem.lowPercent  or 30) / 100

    local ialpha       = elem.ialpha      or 0.67
    self.icolor[4]     = ialpha
    self.ihighColor[4] = ialpha
    self.ilowColor[4]  = ialpha

    self.realWidth = self:GetWidth()

    local texture = elem.texture or "Interface/Addons/TGUF3/DUF_Images/bg"
    self.BackBar.Texture:SetTexture(texture)
    self.BackBar:Hide()
    self.FrontBar.Texture:SetTexture(texture)
    self.FrontBar:Hide()
end

function TGUF3.HealthBar:SetBar(bar, tapped, health, maxHealth, highColor,
        lowColor, color)
    local p = health / maxHealth
    local pw = math.floor(p * self.realWidth + 0.5)
    if pw <= 0 then
        pw = 1
    end
    bar:SetWidth(pw)

    if tapped then
        bar.Texture:SetVertexColor(unpack(self.tappedColor))
    elseif self.colorize then
        if p <= self.lowPercent then
            bar.Texture:SetVertexColor(unpack(lowColor))
        elseif p <= self.highPercent then
            p = (p - self.lowPercent)/(self.highPercent - self.lowPercent)
            bar.Texture:SetVertexColor(interp(p, lowColor, highColor))
        elseif p < 1 then
            p = (p - self.highPercent)/(1 - self.highPercent)
            bar.Texture:SetVertexColor(interp(p, highColor, color))
        else
            bar.Texture:SetVertexColor(unpack(color))
        end
    else
        bar.Texture:SetVertexColor(unpack(color))
    end

    bar:Show()
end

function TGUF3.HealthBar:UPDATE_HEALTH(unit)
    if not unit.exists then
        return
    end

    local incomingHeals = unit.incomingHeals or 0
    local incomingHealth = unit.health.current + incomingHeals
    local maxHealth = unit.health.max
    incomingHealth = math.min(incomingHealth, maxHealth)

    -- Back bar is the incoming heals bar.
    if incomingHeals ~= 0 then
        self:SetBar(self.BackBar, unit.tapped, incomingHealth, maxHealth,
                    self.ihighColor, self.ilowColor, self.icolor)
    else
        self.BackBar:Hide()
    end

    -- Front bar is the actual health bar.
    self:SetBar(self.FrontBar, unit.tapped, unit.health.current,
                maxHealth, self.highColor, self.lowColor, self.color)
end

TGUF3.HealthBar.UPDATE_TAPPED = TGUF3.HealthBar.UPDATE_HEALTH
TGUF3.HealthBar.UPDATE_INCOMINGHEALS = TGUF3.HealthBar.UPDATE_HEALTH
