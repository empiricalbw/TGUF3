TGUF3 = {
    Frames        = {},
    PartyFrames   = {},
    RaidFrames    = {},
    isHealer      = nil,
    priorityTable = {},
}

local ROLE_PRIORITY = {
    TANK    = 1,
    HEALER  = 2,
    DAMAGER = 3,
}

local RAID_ORDER = {
    ["WARRIOR"]     = 11,
    ["DEATHKNIGHT"] = 12,
    ["PALADIN"]     = 13,
    ["DRUID"]       = 14,
    ["ROGUE"]       = 15,
    ["SHAMAN"]      = 16,
    ["MAGE"]        = 17,
    ["WARLOCK"]     = 18,
    ["PRIEST"]      = 19,
    ["HUNTER"]      = 20,
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

local _, PLAYER_CLASS = UnitClass("player")
TGUF3.isHealer        = (HEALING_CLASSES[PLAYER_CLASS] ~= nil)
TGUF3.canCureMagic    = (CURE_MAGIC_CLASSES[PLAYER_CLASS] ~= nil)
TGUF3.canCureDisease  = (CURE_DISEASE_CLASSES[PLAYER_CLASS] ~= nil)
TGUF3.canCureCurse    = (CURE_CURSE_CLASSES[PLAYER_CLASS] ~= nil)
TGUF3.canCurePoison   = (CURE_POISON_CLASSES[PLAYER_CLASS] ~= nil)
TGUF3.canDispelMagic  = (DISPEL_MAGIC_CLASSES[PLAYER_CLASS] ~= nil)
TGUF3.canDispelEnrage = (DISPEL_ENRAGE_CLASSES[PLAYER_CLASS] ~= nil)

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

function TGUF3.PLAYER_ENTERING_WORLD()
    --print("TGUF3.PLAYER_ENTERING_WORLD")
    TGUF3.ProcessGroupState()
end

function TGUF3.PLAYER_REGEN_ENABLED()
    --print("TGUF3.PLAYER_REGEN_ENABLED")
    TGUF3.ProcessGroupState()
end

function TGUF3.GROUP_JOINED()
    --print("TGUF3.GROUP_JOINED")
    TGUF3.ProcessGroupState()
end

function TGUF3.GROUP_LEFT()
    print("TGUF3.GROUP_LEFT")
    TGUF3.priorityTable = {}
    TGUF3.ProcessGroupState()
end

function TGUF3.RAID_ROSTER_UPDATE()
    --print("TGUF3.RAID_ROSTER_UPDATE")
    TGUF3.ProcessGroupState()
end

function TGUF3.GROUP_ROSTER_UPDATE()
    --print("TGUF3.GROUP_ROSTER_UPDATE")
    TGUF3.ProcessGroupState()
end

function TGUF3.LTPartyUnit(l_id, r_id)
    local l_role = UnitGroupRolesAssigned(l_id)
    local r_role = UnitGroupRolesAssigned(r_id)
    local l_prio = ROLE_PRIORITY[l_role] or 10
    local r_prio = ROLE_PRIORITY[r_role] or 10
    --[[
    print("TGUF3.LTPartyUnit("..l_id..", "..r_id..") l_role "..l_role..
          " r_role "..r_role.." l_prio "..tostring(l_prio)..
          " r_prio "..tostring(r_prio))
          ]]

    if l_prio < r_prio then
        --print("--- Returns true")
        return true
    end
    if l_prio > r_prio then
        --print("--- Returns false")
        return false
    end

    --print("--- Returns l_id < r_id")
    return l_id < r_id
end

function TGUF3.LTRaidUnit(l_id, r_id)
    local _, l_class, _ = UnitClass(l_id)
    local _, r_class, _ = UnitClass(r_id)
    local l_priority    = RAID_ORDER[l_class]
    local r_priority    = RAID_ORDER[r_class]

    local l_name = UnitName(l_id)
    local r_name = UnitName(r_id)
    l_priority = TGUF3.priorityTable[l_name] or l_priority
    r_priority = TGUF3.priorityTable[r_name] or r_priority

    return l_priority < r_priority
end

function TGUF3.ProcessGroupState()
    local inRaid = IsInRaid()
    for id, f in pairs(TGUF3.Frames) do
        f:UpdateRaidVisibility(inRaid)
    end

    local sortedParty = {}
    for i=1, 4 do
        local id = "party"..tostring(i)
        if UnitExists(id) then
            table.insert(sortedParty, id)
        end
    end
    table.sort(sortedParty, TGUF3.LTPartyUnit)

    for i=1, 4 do
        --print("Party frame "..tostring(i)..": "..tostring(sortedParty[i]))
        TGUF3.PartyFrames[i]:Reassign(sortedParty[i])
    end

    if not inRaid then
        return
    end

    local sortedRaid = {}
    for i=1, 40 do
        local id = "raid"..tostring(i)
        if UnitClass(id) then
            table.insert(sortedRaid, id)
        end
    end
    table.sort(sortedRaid, TGUF3.LTRaidUnit)

    for i=1, 40 do
        TGUF3.RaidFrames[i]:Reassign(sortedRaid[i])
    end
end

function TGUF3.DisableBlizzardFrames()
    local hidePlayer
    local hideTarget
    local hideParty
    local hideRaid

    for id, _ in pairs(TGUF3.Frames) do
        if id == "player" then
            hidePlayer = true
        elseif id:find("^party") then
            hideParty = true
        elseif id:find("^raid") then
            hideRaid = true
        elseif id == "target" then
            hideTarget = true
        end
    end

    if hidePlayer then
        TGUF3.HideBlizzardPlayerFrames()
    end
    if hideParty then
        TGUF3.HideBlizzardPartyFrames()
    end
    if hideRaid then
        TGUF3.HideBlizzardRaidFrames()
    end
    if hideTarget then
        TGUF3.HideBlizzardTargetFrames()
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

function TGUF3.HideBlizzardRaidFramesHook()
    CompactRaidFrameManager:UnregisterAllEvents()
    CompactRaidFrameContainer:UnregisterAllEvents()
    CompactRaidFrameManager:Hide()
    local shown = CompactRaidFrameManager_GetSetting("IsShown")
    if shown and shown ~= "0" then
        CompactRaidFrameManager_SetSetting("IsShown", "0")
    end
end

function TGUF3.HideBlizzardRaidFrames()
    hooksecurefunc("CompactRaidFrameManager_UpdateShown",
                   TGUF3.HideBlizzardRaidFramesHook)

    TGUF3.HideBlizzardRaidFramesHook()

    CompactRaidFrameContainer:HookScript("OnShow",
                                         TGUF3.HideBlizzardRaidFramesHook)
    CompactRaidFrameManager:HookScript("OnShow",
                                       TGUF3.HideBlizzardRaidFramesHook)
end

function TGUF3.HideBlizzardTargetFrames()
    TargetFrame:UnregisterAllEvents()
    TargetFrame:Hide()
    ComboFrame:UnregisterAllEvents()
end

function TGUF3.SetPriorityHandler(dd, index)
    local unit = dd.config.unit
    local priority = index
    if index == 4 then
        priority = nil
    end
    TGUF3.priorityTable[UnitName(unit)] = priority
    TGUF3.ProcessGroupState()
    TGUnitPopup.HideUnitPopup()
end

function TGUF3.PriorityGenerator(unit)
    local c = TGUnitPopup.DropDownConfig:New(unit, 16, TGUF3.SetPriorityHandler)
    c:AddLine(" 1", TGUF3.SetPriorityHandler)
    c:AddLine(" 2", TGUF3.SetPriorityHandler)
    c:AddLine(" 3", TGUF3.SetPriorityHandler)
    c:AddLine(" None", TGUF3.SetPriorityHandler)
    local priority = TGUF3.priorityTable[UnitName(unit)]
    if priority ~= nil then
        c.items[priority].checked = true
    end

    return c
end

TGUF3.SelfGenerator = TGUnitPopup.configGenerators["SELF"]
TGUnitPopup.configGenerators["SELF"] = function(unit)
    local c = TGUF3.SelfGenerator(unit)
    if IsInRaid() then
        c:InsertLine(2, " Set Priority", nil, TGUF3.PriorityGenerator(unit))
    end
    return c
end

TGUnitPopup.configGenerators["RAID_PLAYER"] = function(unit)
    local c = TGUnitPopup.DropDownConfig:New(unit, 16)
    c:AddLine("!"..UnitName(unit))
    c:AddLine(" Set Priority", nil, TGUF3.PriorityGenerator(unit))
    c:AddLine(" Raid Target Icon", nil,
              TGUnitPopup.configGenerators["RAID_TARGET_ICON"](unit))

    return c
end

TGEventManager.Register(TGUF3)
