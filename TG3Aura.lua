local TG3Aura = {}

function TG3Aura:_Init(elem)
    local font         = elem.font or "Fonts/ARIALN.TTF"
    local fontSize     = elem.fontSize or 10
    local fontFlags    = elem.fontFlags or "OUTLINE, MONOCHROME"
    self.index         = elem.index
    self.dimension     = elem.dimension
    self.mineDimension = elem.mineDimension

    self.Count:SetFont(font, fontSize, fontFlags)
    self:SetScript("OnEnter", self.OnEnter)
    self:SetScript("OnLeave", self.OnLeave)
end

function TG3Aura:UpdateAura(unit, aura)
    if aura and aura.texture then
        self.Texture:SetTexture(aura.texture)

        if aura.applications > 1 then
            self.Count:SetText(aura.applications)
            self.Count:Show()
        else
            self.Count:Hide()
        end

        if aura.duration > 0 and aura.expirationTime > 0 then
            local start = aura.expirationTime - aura.duration
            self.Cooldown:SetCooldown(start, aura.duration)
            self.Cooldown:Show()
        else
            self.Cooldown:Hide()
        end

        if self.mineDimension and aura.source == "player" then
            self:SetWidth(self.mineDimension)
            self:SetHeight(self.mineDimension)
        else
            self:SetWidth(self.dimension)
            self:SetHeight(self.dimension)
        end

        self:Show()
    else
        self:Hide()
    end
end

function TG3Aura:OnLeave()
    GameTooltip:Hide()
end

TGUF3.Buff = {
    _name = "TGUF3.Buff",
    _xml  = "TG3BuffTemplate",
}
TG3BuffMixin = TGUF3.Buff

function TGUF3.Buff:Init(elem)
    Mixin(self, TG3Aura)
    self:_Init(elem)
end

function TGUF3.Buff:UPDATE_BUFFS(unit)
    self:UpdateAura(unit, unit.buffs[self.index])
end

function TGUF3.Buff:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
    GameTooltip:SetUnitBuff(self.unitFrame.unit.id, self.index)
end

TGUF3.Debuff = {
    _name = "TGUF3.Debuff",
    _xml  = "TG3DebuffTemplate",
}
TG3DebuffMixin = TGUF3.Debuff

function TGUF3.Debuff:Init(elem)
    Mixin(self, TG3Aura)
    self:_Init(elem)
end

function TGUF3.Debuff:UPDATE_DEBUFFS(unit)
    self:UpdateAura(unit, unit.debuffs[self.index])
end

function TGUF3.Debuff:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", 0, 0)
    GameTooltip:SetUnitDebuff(self.unitFrame.unit.id, self.index)
end
