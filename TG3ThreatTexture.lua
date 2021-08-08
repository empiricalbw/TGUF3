--[[
--  Colorized texture that tracks the threat the player has on the unit.
--
--  Required attributes:
--
--      id  - texture id or path
--
--  Optional attribtues (all {r, g, b, a} colors):
--
--      highColor   - tanking and have highest threat (red)
--      mediumColor - tanking but someone else has highest threat (orange)
--      lowColor    - not tanking (yellow)
--]]
TGUF3.ThreatTexture = {
    _name  = "TGUF3.ThreatTexture",
    _xml   = "TG3ThreatTextureTemplate",
    _ftype = "StatusBar",
}
TG3ThreatTextureMixin = TGUF3.ThreatTexture

function TGUF3.ThreatTexture:Init(elem)
    self.lowColor    = elem.lowColor    or {1, 1, 0, 1}
    self.mediumColor = elem.mediumColor or {1, 0.5, 0.25, 1}
    self.highColor   = elem.highColor   or {1, 0.1, 0.1, 1}

    self.Spark:ClearAllPoints()
    self.Spark:SetHeight(32 * self:GetHeight() / 9)
    self.Spark:SetWidth(32)

    local id = elem.id or "Interface/Addons/TGUF_2/DUF_Images/bg"
    self:SetStatusBarTexture(id)
    self:SetMinMaxValues(0, 1)
    self:SetValue(0)
end

function TGUF3.ThreatTexture:UPDATE_THREAT(unit)
    if unit.threat.status == nil or not unit.threat.ceiling or
       unit.threat.ceiling == "Fade"
    then
        self:SetMinMaxValues(0, 1)
        self:SetValue(0)
        self.Spark:Hide()
        return
    end

    local color
    if unit.threat.status == 3 then
        color = self.highColor
    elseif unit.threat.status == 2 then
        color = self.mediumColor
    else
        color = self.lowColor
    end

    self:SetStatusBarColor(unpack(color))
    self:SetMinMaxValues(0, unit.threat.ceiling)
    self:SetValue(unit.threat.current)

    if unit.threat.ratio then
        local x = unit.threat.ratio * self:GetWidth()
        self.Spark:SetPoint("CENTER", self, "LEFT", x, 0)
        self.Spark:Show()
    else
        self.Spark:Hide()
    end
end
