TG3UnitFrameMixin = {}
TGUF3.UnitFrame = {}

local UnitFrames = {}

function TGUF3.UnitFrame:New(layout)
    -- Create the UnitFrame object.
    local f = CreateFrame("Button", nil, UIParent, "TG3UnitFrameTemplate")
    f:Init(layout)
    return f
end

function TG3UnitFrameMixin:Init(layout)
    -- Create the TGUnit.
    self.unit = TGUnit:new(layout.unit_id)

    -- Create the secure unit button..
    self:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    self:TG3SetPoint(layout.anchor)
    self:SetSize(layout.width, layout.height)
    RegisterUnitWatch(self)
    SecureUnitButton_OnLoad(self, layout.unit_id,
        function() self:MenuFunc() end)

    -- Create the dropdown frame.
    self.ddFrame = CreateFrame("Frame", nil, self, "UIDropDownMenuTemplate")
    self.ddFrame:SetSize(10, 10)
    UIDropDownMenu_Initialize(
        self.ddFrame,
        function() self:DropDown_Initialize() end,
        "MENU")

    -- Instantiate elements.
    TG3Element.MakeElems(self, self, layout.elements)

    -- Remember us.
    UnitFrames[self.unit.id] = self

    -- Update the unit frame.
    self.unit:AddListener(self)
end

function TG3UnitFrameMixin:TG3SetPoint(anchor)
    local point         = anchor.point
    local relativeFrame = UnitFrames[anchor.relativeUnit] or UIParent
    local relativePoint = anchor.relativePoint or point
    local dx            = anchor.dx or 0
    local dy            = anchor.dy or 0
    self:SetPoint(point, relativeFrame, relativePoint, dx, dy)
end

function TG3UnitFrameMixin:MenuFunc()
    -- Called when we get a right-click on the specified secure unit button.
    ToggleDropDownMenu(1, nil, self.ddFrame, "cursor", 20, 0)
end

function TG3UnitFrameMixin:DropDown_Initialize()
    local unit = self.unit.id
    local menu
    local name
    local id

    if UnitIsUnit(unit,"player") then
        menu = "SELF"
    elseif UnitIsUnit(unit,"pet") then
        menu = "PET"
    elseif UnitIsPlayer(unit) then
        id = UnitInRaid(unit)
        if id then
            menu = "RAID_PLAYER"
        elseif UnitInParty(unit) then
            menu = "PARTY"
        else
            menu = "PLAYER"
        end
    else
        menu = "TARGET"
        name = RAID_TARGET_ICON
    end

    UnitPopup_ShowMenu(self.ddFrame, menu, unit, name, id)
end

function TG3UnitFrameMixin:UPDATE_EXISTS(unit)
    if unit.exists then
        selfShow()
    else
        self:Hide()
    end
end
