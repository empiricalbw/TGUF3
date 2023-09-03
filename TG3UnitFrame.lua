TGUF3.UnitFrame = {}
TG3UnitFrameMixin = TGUF3.UnitFrame

function TGUF3.UnitFrame:New(layout)
    -- Create the UnitFrame object.
    local f = CreateFrame("Button", nil, UIParent, "TG3UnitFrameTemplate")
    f:Init(layout)
    return f
end

function TGUF3.UnitFrame:Init(layout)
    -- Create the TGUnit.
    self.unit = TGUnit:new(layout.unit_id)
    self.default_unit_id = layout.unit_id

    -- Create the secure unit button..
    self:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    self:TG3SetPoint(layout.anchor)
    self:SetSize(layout.width, layout.height)
    self:SetScript("OnEnter", TGUF3.UnitFrame.OnEnter)
    self:SetScript("OnLeave", TGUF3.UnitFrame.OnLeave)
    RegisterUnitWatch(self)
    SecureUnitButton_OnLoad(self, layout.unit_id,
        function() self:MenuFunc() end)
    self.hideInRaid = layout.hideInRaid
    self.trackRange = layout.trackRange
    self.hidden     = false
    --[[
    if self.hideInRaid then
        print(self.unit.id..": hidden in raids")
    end
    ]]

    -- Table of key frames.
    self.keyFrames = {}

    -- Instantiate elements.
    TGUF3.Element.MakeElems(self, self, layout.elements)

    -- Record this unit frame.
    TGUF3.Frames[self.unit.id] = self
    if self.unit.id:find("^partypet") then
            -- Nothing.
    elseif self.unit.id:find("^party") then
        local pk = tonumber(self.unit.id:sub(6))
        TGUF3.PartyFrames[pk] = self
        self.partyFrameIndex  = pk
    elseif self.unit.id:find("^raid") then
        local rk = tonumber(self.unit.id:sub(5))
        TGUF3.RaidFrames[rk] = self
    end

    -- Update the unit frame.
    self.unit:AddListener(self)
end

function TGUF3.UnitFrame:Reassign(unit_id)
    unit_id = unit_id or self.default_unit_id
    if not self:CanChangeProtectedState() then
        --print(self.unit.id..": Combat lockout for reassign")
        return
    end

    local old_unit = self.unit
    local new_unit = TGUnit:new(unit_id)

    self.unit:RemoveListener(self)
    TGUF3.Element.Reassign(self, old_unit, new_unit)
    self.unit = new_unit
    SecureUnitButton_OnLoad(self, self.unit.id, self.menu)
    self.unit:AddListener(self)
end

function TGUF3.UnitFrame:UpdateRaidVisibility(inRaid)
    if not self.hideInRaid then
        return
    end

    if not self:CanChangeProtectedState() then
        --print(self.unit.id..": Combat lockout")
        return
    end

    if inRaid then
        self:RaidHide()
    else
        self:RaidShow()
    end
end

function TGUF3.UnitFrame:RaidHide()
    if not self.hidden then
        self:Hide()
        UnregisterUnitWatch(self)
        self.hidden = true
    end
end

function TGUF3.UnitFrame:RaidShow()
    if self.hidden then
        RegisterUnitWatch(self)
        self:Show()
        self.hidden = false
    end
end

function TGUF3.UnitFrame:RaisePartyFrame()
    assert(self.partyFrameIndex ~= nil)
    if self.partyFrameIndex == 1 then
        return
    end

    -- This frame and the frame above us need to swap units.
    local targetFrame = TGUF3.PartyFrames[self.partyFrameIndex - 1]
    local currentUnit = self.unit
    local targetUnit  = targetFrame.unit
    -- TODO
end

function TGUF3.UnitFrame:TG3SetPoint(anchor)
    local point         = anchor.point
    local relativeFrame = TGUF3.Frames[anchor.relativeUnit] or UIParent
    local relativePoint = anchor.relativePoint or point
    local dx            = anchor.dx or 0
    local dy            = anchor.dy or 0
    self:SetPoint(point, relativeFrame, relativePoint, dx, dy)
end

function TGUF3.UnitFrame:OnEnter()
    GameTooltip_SetDefaultAnchor(GameTooltip, self)
    GameTooltip:SetUnit(self.unit.id)
    GameTooltipTextLeft1:SetTextColor(GameTooltip_UnitColor(self.unit.id))
end

function TGUF3.UnitFrame:OnLeave()
    GameTooltip:FadeOut()
end

function TGUF3.UnitFrame:MenuFunc()
    -- Called when we get a right-click on the specified secure unit button.
    TGUnitPopup.ShowUnitPopup(self.unit.id)
end

function TGUF3.UnitFrame:UPDATE_GUID(unit)
    TGUnitPopup.HideUnitPopup(unit.id)
end

function TGUF3.UnitFrame:UpdateVisibility()
    if not self.trackRange then
        return
    end

    if self.unit.reaction == TGU.REACTION_FRIENDLY then
        if TGUF3.isHealer then
            if self.unit.inHealingRange then
                self:SetAlpha(1)
            elseif self.unit.isVisible then
                self:SetAlpha(0.3)
            else
                self:SetAlpha(0.065)
            end
        elseif self.unit.isVisible then
            self:SetAlpha(1)
        else
            self:SetAlpha(0.125)
        end
    else
        self:SetAlpha(1)
    end
end

function TGUF3.UnitFrame:UPDATE_INHEALINGRANGE(unit)
    self:UpdateVisibility()
end

function TGUF3.UnitFrame:UPDATE_ISVISIBLE(unit)
    self:UpdateVisibility()
end

function TGUF3.UnitFrame:UPDATE_REACTION(unit)
    self:UpdateVisibility()
end
