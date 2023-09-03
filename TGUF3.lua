TGUF3 = {
    Frames      = {},
    isHealer    = nil,
}

local HEALING_CLASSES = {
    ["PRIEST"]  = 1,
    ["DRUID"]   = 1,
    ["SHAMAN"]  = 1,
    ["PALADIN"] = 1,
}

local _, PLAYER_CLASS = UnitClass("player")
TGUF3.isHealer = (HEALING_CLASSES[PLAYER_CLASS] ~= nil)

function TGUF3.ADDON_LOADED(addOnName)
    if addOnName ~= "TGUF3" then
        return
    end

    for i, layout in ipairs(DUF_FRAMES.Layout) do
        TGUF3.UnitFrame:New(layout)
    end

    TGUF3.DisableBlizzardFrames()
    BuffFrame_Update()
end

function TGUF3.DisableBlizzardFrames()
    local hidePlayer
    local hideTarget
    local hideParty
    local hideFocus

    for id, _ in pairs(TGUF3.Frames) do
        if id == "player" then
            hidePlayer = true
        elseif id:find("^party") then
            hideParty = true
        elseif id == "target" then
            hideTarget = true
        elseif id == "focus" then
            hideFocus = true
        end
    end

    if hidePlayer then
        TGUF3.HideBlizzardPlayerFrames()
    end
    if hideParty then
        TGUF3.HideBlizzardPartyFrames()
    end
    if hideTarget then
        TGUF3.HideBlizzardTargetFrames()
    end
    if hideFocus then
        TGUF3.HideBlizzardFocusFrames()
    end
end

function TGUF3.HideBlizzardPlayerFrames()
    PlayerFrame:UnregisterAllEvents()
    PlayerFrameHealthBar:UnregisterAllEvents()
    PlayerFrameManaBar:UnregisterAllEvents()
    PlayerFrame:Hide()
end

function TGUF3.HideBlizzardPartyFrames()
    for i=1, 4 do
        local f = _G["PartyMemberFrame"..i]
        f:UnregisterAllEvents()
        f:Hide()
        f.Show = function() end
    end
end

function TGUF3.HideBlizzardTargetFrames()
    TargetFrame:UnregisterAllEvents()
    TargetFrame:Hide()
    ComboFrame:UnregisterAllEvents()
end

function TGUF3.HideBlizzardFocusFrames()
    FocusFrame:UnregisterAllEvents()
    FocusFrame:Hide()
end

TGEventManager.Register(TGUF3)
