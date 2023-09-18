local PARTY_SPACING = -31 - 8

DUF_FRAMES.Layout = {
    {
        unit_id  = "player",
        width    = 212,
        height   = 64,
        elements = DUF_FRAMES.Player,
        anchor   = {
            point = "TOPLEFT",
            dx    = 14,
            dy    = -14,
        },
    },
    {
        unit_id  = "pet",
        width    = 125,
        height   = 38,
        elements = DUF_FRAMES.Pet,
        anchor   = {
            point         = "LEFT",
            relativeUnit  = "player",
            relativePoint = "RIGHT",
            dx            = -3,
        },
    },
    {
        unit_id  = "pettarget",
        width    = 92,
        height   = 23,
        elements = DUF_FRAMES.PetTarget,
        anchor   = {
            point         = "LEFT",
            relativeUnit  = "pet",
            relativePoint = "RIGHT",
            dx            = -3,
        },
    },
    {
        unit_id  = "target",
        width    = 252,
        height   = 66,
        elements = DUF_FRAMES.Target,
        anchor  = {
            point = "TOPLEFT",
            dx    = 920,
            dy    = -776,
        },
    },
    {
        unit_id     = "player",
        is_alias    = 1,
        playerClass = "ROGUE",
        width       = 240,
        height      = 1,
        elements    = DUF_FRAMES.ComboPoints,
        anchor = {
            point         = "BOTTOMLEFT",
            relativeUnit  = "target",
            relativePoint = "TOPLEFT",
            dy            = 32,
        },
    },
    {
        unit_id  = "targettarget",
        width    = 182,
        height   = 42,
        elements = DUF_FRAMES.Generic,
        anchor  = {
            point         = "LEFT",
            relativeUnit  = "target",
            relativePoint = "RIGHT",
            dx            = -4,
        },
    },
}

-- Add party frames.
for i=1, 4 do
    local relativeUnit = {
        "player",
        "party1",
        "party2",
        "party3",
    }

    local f = {
        unit_id    = "party"..tostring(i),
        width      = 202,
        height     = 52,
        elements   = DUF_FRAMES.Party,
        hideInRaid = true,
        trackRange = true,
        anchor     = {
            point         = "TOPLEFT",
            relativeUnit  = relativeUnit[i],
            relativePoint = "BOTTOMLEFT",
            dy            = PARTY_SPACING,
        }
    }

    table.insert(DUF_FRAMES.Layout, f)
end

-- Add party pet frames.
for i=1, 4 do
    local f = {
        unit_id  = "partypet"..tostring(i),
        width    = 125,
        height   = 38,
        elements = DUF_FRAMES.Pet,
        hideInRaid = true,
        trackRange = true,
        anchor   = {
            point         = "LEFT",
            relativeUnit  = "party"..tostring(i),
            relativePoint = "RIGHT",
            dx            = -3,
        },
    }

    table.insert(DUF_FRAMES.Layout, f)
end

-- Add raid frames.
local raid1 = {
    unit_id    = "raid1",
    width      = 100,
    height     = 16,
    elements   = DUF_FRAMES.RaidLeft,
    trackRange = true,
    anchor     = {
        point         = "TOPLEFT",
        relativeUnit  = "player",
        relativePoint = "BOTTOMLEFT",
        dx            = 20,
        dy            = PARTY_SPACING + 16,
    },
}
table.insert(DUF_FRAMES.Layout, raid1)

local raid2 = {
    unit_id    = "raid2",
    width      = 100,
    height     = 16,
    elements   = DUF_FRAMES.RaidRight,
    trackRange = true,
    anchor     = {
        point         = "TOPLEFT",
        relativeUnit  = "raid1",
        relativePoint = "TOPRIGHT",
        dx            = 1,
    },
}
table.insert(DUF_FRAMES.Layout, raid2)

local RAID_FRAME = {
    [0] = DUF_FRAMES.RaidRight,
    [1] = DUF_FRAMES.RaidLeft,
}

for i=3, 40 do
    local relativeUnit = "raid"..tostring(i - 2)
    local f = {
        unit_id    = "raid"..tostring(i),
        width      = 100,
        height     = 16,
        elements   = RAID_FRAME[i % 2],
        trackRange = true,
        anchor     = {
            point         = "TOPLEFT",
            relativeUnit  = relativeUnit,
            relativePoint = "BOTTOMLEFT",
            dy            = -1,
        },
    }
    table.insert(DUF_FRAMES.Layout, f)
end
