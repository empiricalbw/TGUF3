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
    {
        unit_id  = "focus",
        width    = 150,
        height   = 42,
        elements = DUF_FRAMES.Generic,
        anchor   = {
            point         = "TOPLEFT",
            relativeUnit  = "targettarget",
            relativePoint = "BOTTOMLEFT",
            dy            = -40,
        },
    },
}

-- Add party frames.
for i=1, 4 do
    local relativeUnit
    local dy
    if i == 1 then
        relativeUnit = "player"
        dy           = PARTY_SPACING
    else
        relativeUnit = "party"..tostring(i - 1)
        dy           = PARTY_SPACING
    end

    local f = {
        unit_id    = "party"..tostring(i),
        width      = 202,
        height     = 52,
        elements   = DUF_FRAMES.Party,
        hideInRaid = true,
        anchor     = {
            point         = "TOPLEFT",
            relativeUnit  = relativeUnit,
            relativePoint = "BOTTOMLEFT",
            dy            = dy,
        }
    }

    table.insert(DUF_FRAMES.Layout, f)
end
