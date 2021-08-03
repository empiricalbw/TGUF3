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
                class     = TGUF3.Backdrop,
                edgeFile  = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize  = 20,
                edgeColor = {1, 1, 1, 1},
                bgColor   = {0, 0, 0, 1},
                insets    = {left=5, right=5, top=5, bottom=5},
                anchors   = {
                    {point = "TOPLEFT"},
                    {point = "BOTTOMRIGHT"},
                },

                elements = {
                    {
                        class    = TGUF3.String,
                        text     = "$nm",
                        alignH   = "CENTER",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "TOPLEFT"},
                            {point = "BOTTOMRIGHT"},
                        },
                    },
                }
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
                class     = TGUF3.Backdrop,
                edgeFile  = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize  = 20,
                edgeColor = {1, 1, 1, 1},
                bgColor   = {0, 0, 0, 1},
                insets    = {left=5, right=5, top=5, bottom=5},
                anchors   = {
                    {point = "TOPLEFT"},
                    {point = "BOTTOMRIGHT"},
                },

                elements = {
                    {
                        class    = TGUF3.String,
                        text     = "$nm",
                        alignH   = "CENTER",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "TOPLEFT"},
                            {point = "BOTTOMRIGHT"},
                        },
                    },
                }
            },
        },
    },
}
