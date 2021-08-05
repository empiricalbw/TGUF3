DUF_FRAMES.Layout = {
    {
        unit_id = "player",
        width   = 212,
        height  = 64,
        anchor  = {
            point = "TOPLEFT",
            dx    = 14,
            dy    = -80,
        },

        elements = DUF_FRAMES.Player,
    },
    {
        unit_id = "target",
        width   = 200,
        height  = 40,
        anchor  = {
            point         = "TOPLEFT",
            relativePoint = "BOTTOMLEFT",
            relativeUnit  = "player",
            dy            = -25,
        },

        elements = DUF_FRAMES.Target,
    },
}
