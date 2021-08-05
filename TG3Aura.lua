local TG3Aura = {}

function TG3Aura:Init(elem)
    local font      = elem.font or "Fonts/ARIALN.TTF"
    local fontSize  = elem.fontSize or 10
    local fontFlags = elem.fontFlags or "OUTLINE, MONOCHROME"
    self.index      = elem.index

    self.Count:SetFont(font, fontSize, fontFlags)
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

        self:Show()
    else
        self:Hide()
    end
end

TGUF3.Buff = {
    _name = "TGUF3.Buff",
    _xml  = "TG3BuffTemplate",
}
TG3BuffMixin = TGUF3.Buff

function TGUF3.Buff:Init(elem)
    TG3Aura.Init(self, elem)
end

function TGUF3.Buff:UPDATE_BUFFS(unit)
    TG3Aura.UpdateAura(self, unit, unit.buffs[self.index])
end

TGUF3.Debuff = {
    _name = "TGUF3.Debuff",
    _xml  = "TG3DebuffTemplate",
}
TG3DebuffMixin = TGUF3.Debuff

function TGUF3.Debuff:Init(elem)
    TG3Aura.Init(self, elem)
end

function TGUF3.Debuff:UPDATE_DEBUFFS(unit)
    TG3Aura.UpdateAura(self, unit, unit.debuffs[self.index])
end
