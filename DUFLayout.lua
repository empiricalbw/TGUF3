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
        unit_id  = "party1",
        width    = 202,
        height   = 52,
        elements = DUF_FRAMES.Party,
        anchor   = {
            point         = "TOPLEFT",
            relativeUnit  = "player",
            relativePoint = "BOTTOMLEFT",
            dy            = PARTY_SPACING + 14,
        }
    },
    {
        unit_id  = "party2",
        width    = 202,
        height   = 52,
        elements = DUF_FRAMES.Party,
        anchor   = {
            point         = "TOPLEFT",
            relativeUnit  = "party1",
            relativePoint = "BOTTOMLEFT",
            dy            = PARTY_SPACING,
        }
    },
    {
        unit_id  = "party3",
        width    = 202,
        height   = 52,
        elements = DUF_FRAMES.Party,
        anchor   = {
            point         = "TOPLEFT",
            relativeUnit  = "party2",
            relativePoint = "BOTTOMLEFT",
            dy            = PARTY_SPACING,
        }
    },
    {
        unit_id  = "party4",
        width    = 202,
        height   = 52,
        elements = DUF_FRAMES.Party,
        anchor   = {
            point         = "TOPLEFT",
            relativeUnit  = "party3",
            relativePoint = "BOTTOMLEFT",
            dy            = PARTY_SPACING,
        }
    },
    {
        unit_id  = "target",
        width    = 252,
        height   = 50,
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
