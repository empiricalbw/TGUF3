DUF_LAYOUT = {
    {
        unit_id = "player",
        width   = 100,
        height  = 40,
        anchor  = {
            point = "TOPLEFT",
            dx    = 300,
            dy    = -300,
        },
        elements = {
            {
                class  = TGUF3.Texture,
                id     = "interface/icons/inv_mushroom_11",
                anchors = {
                    {point = "TOPLEFT"},
                    {point = "BOTTOMRIGHT"},
                },
            },
        },
    },
    {
        unit_id = "target",
        width   = 100,
        height  = 40,
        anchor  = {
            point        = "TOPLEFT",
            relativeUnit = "player",
            dy           = -45,
        },
        elements = {
            {
                class  = TGUF3.Texture,
                id     = "interface/icons/inv_mushroom_10",
                anchors = {
                    {point = "TOPLEFT"},
                    {point = "BOTTOMRIGHT"},
                },
            },
        },
    },
}
