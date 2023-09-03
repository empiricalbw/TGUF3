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

local CURE_MAGIC_CLASSES = {
    ["PALADIN"] = 1,    -- Cleanse
    ["PRIEST"]  = 1,    -- Dispel Magic / Mass Dispel
    ["WARLOCK"] = 1,    -- Felhunter's Devour Magic / Doomguard's Dispel
}

local CURE_DISEASE_CLASSES = {
    ["PALADIN"] = 1,    -- Cleanse
    ["SHAMAN"]  = 1,    -- Cure Toxins / Cleanse Spirit / Cleansing Totem
    ["PRIEST"]  = 1,    -- Abolish / Cure Disease
}

local CURE_CURSE_CLASSES = {
    ["DRUID"]   = 1,    -- Remove Curse
    ["MAGE"]    = 1,    -- Remove Curse
    ["SHAMAN"]  = 1,    -- Cleanse Spirit
}

local CURE_POISON_CLASSES = {
    ["DRUID"]   = 1,    -- Abolish / Cure Poison
    ["PALADIN"] = 1,    -- Cleanse / Purify
    ["SHAMAN"]  = 1,    -- Cure Toxins / Cleanse Spirit / Cleansing Totem
}

local DISPEL_MAGIC_CLASSES = {
    ["DEATHKNIGHT"] = 1,    -- Glyphed Icy Touch
    ["HUNTER"]      = 1,    -- Tranquilizing Shot
    ["PRIEST"]      = 1,    -- Dispel Magic / Mass Dispel
    ["SHAMAN"]      = 1,    -- Purge
    ["WARLOCK"]     = 1,    -- Felhunter's Devour Magic / Doomguard's Dispel
    ["WARRIOR"]     = 1,    -- Shield Slam
}

local DISPEL_ENRAGE_CLASSES = {
    ["HUNTER"]  = 1,    -- Tranquilizing Shot
}

local STEAL_CLASSES = {
    ["MAGE"]        = 1,    -- Spellsteal
}

local _, PLAYER_CLASS = UnitClass("player")
TGUF3.isHealer        = (HEALING_CLASSES[PLAYER_CLASS] ~= nil)
TGUF3.canCureMagic    = (CURE_MAGIC_CLASSES[PLAYER_CLASS] ~= nil)
TGUF3.canCureDisease  = (CURE_DISEASE_CLASSES[PLAYER_CLASS] ~= nil)
TGUF3.canCureCurse    = (CURE_CURSE_CLASSES[PLAYER_CLASS] ~= nil)
TGUF3.canCurePoison   = (CURE_POISON_CLASSES[PLAYER_CLASS] ~= nil)
TGUF3.canDispelMagic  = (DISPEL_MAGIC_CLASSES[PLAYER_CLASS] ~= nil)
TGUF3.canDispelEnrage = (DISPEL_ENRAGE_CLASSES[PLAYER_CLASS] ~= nil)
TGUF3.canSteal        = (STEAL_CLASSES[PLAYER_CLASS] ~= nil)

function TGUF3.ADDON_LOADED(addOnName)
    if addOnName ~= "TGUF3" then
        return
    end

    for i, layout in ipairs(DUF_FRAMES.Layout) do
        if not layout.playerClass or layout.playerClass == PLAYER_CLASS then
            TGUF3.UnitFrame:New(layout)
        end
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
