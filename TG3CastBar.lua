--[[
--  Status bar that tracks the current spellcast of the unit.
--
--  Optional attributes:
--
--      texture     - texture used in the status bar
--]]
TGUF3.CastBar = {
    _name  = "TGUF3.CastBar",
    _xml   = "TG3CastBarTemplate",
}
TG3CastBarMixin = TGUF3.CastBar

local BAR_COLORS = {
    ["Casting"] = {
        r = 1,
        g = 1,
        b = 0.25,
        a = 1,
    },
    ["Channeling"] = {
        r = 0.25,
        g = 1,
        b = 0.25,
        a = 1,
    },
}

function TGUF3.CastBar:Init(elem)
    local texture = elem.texture or "Interface/Addons/TGUF3/DUF_Images/bg"
    self.Bar.Texture:SetTexture(texture)
    self.Bar:Hide()
    self.Bar:SetScript("OnUpdate", function() self:OnUpdate() end)
    self.realWidth = self.SizeFrame:GetWidth()
end

function TGUF3.CastBar:UPDATE_CLEU_SPELL(unit)
    local castInfo = unit.cleuCastInfo
    if unit.exists and castInfo.spellInfo ~= nil then
        local color = BAR_COLORS["Casting"]
        self.Bar.Texture:SetVertexColor(color.r, color.g, color.b)
        self.Bar:Show()
        self:OnUpdate()
    else
        self.Bar:Hide()
    end
end

function TGUF3.CastBar:OnUpdate()
    local castInfo = self.unitFrame.unit.cleuCastInfo
    local duration = castInfo.spellInfo.castTime
    local percent
    if duration ~= nil then
        self.Bar.Spark:Show()
        percent = (GetTime() - castInfo.timestamp) / duration
    else
        self.Bar.Spark:Hide()
        percent = 1
    end
    if percent < 0 then
        percent = 0
    end
    if percent > 1 then
        percent = 1
    end

    if castInfo.spellType == "Channeling" then
        percent = 1 - percent
    end

    local pw = math.floor(percent * self.realWidth + 0.5)
    if pw <= 0 then
        pw = 1
    end
    self.Bar:SetWidth(pw)
end
