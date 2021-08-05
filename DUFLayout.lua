DUF_FRAMES.Layout = {
    {
        unit_id = "player",
        width   = 200,
        height  = 40,
        anchor  = {
            point = "TOPLEFT",
            dx    = 300,
            dy    = -300,
        },

        elements = DUF_FRAMES.Party,
    },
    {
        unit_id = "target",
        width   = 200,
        height  = 40,
        anchor  = {
            point         = "TOPLEFT",
            relativePoint = "BOTTOMLEFT",
            relativeUnit  = "player",
            dy            = -5,
        },

        elements = DUF_FRAMES.Target,
    },
}
