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
            relativeUnit  = "target",
            relativePoint = "BOTTOMRIGHT",
        },
    },
}
