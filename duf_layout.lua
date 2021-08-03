DUF_LAYOUT = {
    {
        unit_id       = "player",
        my_anchor     = "TOPLEFT",
        anchor_frame  = nil,
        target_anchor = "TOPLEFT",
        dx            = 300,
        dy            = -300,
        width         = 100,
        height        = 40,
        elements = {
            {
                class  = TGUF3.Texture,
                id     = "interface/icons/inv_mushroom_11",
                anchors = {
                    {
                        my_anchor     = "TOPLEFT",
                        anchor_frame  = nil,
                        target_anchor = "TOPLEFT",
                        dx            = 0,
                        dy            = 0,
                    },
                    {
                        my_anchor     = "BOTTOMRIGHT",
                        anchor_frame  = nil,
                        target_anchor = "BOTTOMRIGHT",
                        dx            = 0,
                        dy            = 0,
                    },
                },
            },
        },
    },
    {
        unit_id       = "target",
        my_anchor     = "TOPLEFT",
        anchor_frame  = "player",
        target_anchor = "TOPLEFT",
        dx            = 0,
        dy            = -45,
        width         = 100,
        height        = 40,
        elements = {
            {
                class  = TGUF3.Texture,
                id     = "interface/icons/inv_mushroom_10",
                anchors = {
                    {
                        my_anchor     = "TOPLEFT",
                        anchor_frame  = nil,
                        target_anchor = "TOPLEFT",
                        dx            = 0,
                        dy            = 0,
                    },
                    {
                        my_anchor     = "BOTTOMRIGHT",
                        anchor_frame  = nil,
                        target_anchor = "BOTTOMRIGHT",
                        dx            = 0,
                        dy            = 0,
                    },
                },
            },
        },
    },
}
