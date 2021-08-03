TGUF3.UnitFrame = {}
TGUF3.UnitFrame.__index = TGUF3.UnitFrame

local UnitFrames = {}

function TGUF3.UnitFrame:new(layout)
    -- Create the UnitFrame object.
    local unitFrame = {}
    setmetatable(unitFrame, self)
    unitFrame.unit = TGUnit:new(layout.unit_id)

    -- Figure out where we are going to anchor this frame.
    if layout.anchor_frame == nil then
        anchor_frame = UIParent
    else
        anchor_frame = UnitFrames[layout.anchor_frame]
    end

    -- Create the secure unit button..
    local f = CreateFrame("Button", nil, UIParent, "SecureUnitButtonTemplate")
    f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    f:SetPoint(layout.my_anchor, anchor_frame, layout.target_anchor, layout.dx,
               layout.dy)
    f:SetSize(layout.width, layout.height)
    f.unitFrame = unitFrame
    RegisterUnitWatch(f)
    SecureUnitButton_OnLoad(f, layout.unit_id, TGUF3.UnitFrame.MenuFunc)

    -- Create the dropdown frame.
    f.ddFrame = CreateFrame("Frame", nil, f, "UIDropDownMenuTemplate")
    f.ddFrame:SetSize(10, 10)
    f.ddFrame.unitFrame = unitFrame
    UIDropDownMenu_Initialize(f.ddFrame, TGUF3.UnitFrame.DropDown_Initialize,
                              "MENU")

    -- Instantiate elements.
    TGUF3.Element.make_elems(f, f, layout.elements)

    -- Remember us.
    UnitFrames[layout.unit_id] = f

    -- Update the unit frame.
    unitFrame.unit:AddListener(unitFrame)

    return unitFrame
end

function TGUF3.UnitFrame.MenuFunc(f, unit, button)
    -- Called when we get a right-click on the specified secure unit button.
    ToggleDropDownMenu(1, nil, f.ddFrame, "cursor", 20, 0)
end

function TGUF3.UnitFrame.DropDown_Initialize(ddFrame)
    local unitFrame = ddFrame.unitFrame
    local unit = unitFrame.unit.id
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
        menu = "RAID_TARGET_ICON"
        name = RAID_TARGET_ICON
    end

    UnitPopup_ShowMenu(ddFrame, menu, unit, name, id)
end

function TGUF3.UnitFrame:UPDATE_EXISTS(unit)
    --[[
    if unit.exists then
        self.frame:Show()
    else
        self.frame:Hide()
    end
    ]]
end
