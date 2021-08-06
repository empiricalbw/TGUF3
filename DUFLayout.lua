local PARTY_SPACING = -31

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
        anchors  = {
            point         = "LEFT",
            relativeUnit  = "player",
            relativePoint = "RIGHT",
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
        height   = 42,
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
            point         = "TOPLEFT",
            relativeUnit  = "target",
            relativePoint = "TOPRIGHT",
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
