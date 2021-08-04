local DUF_GENERIC_ELEMENTS = {
    {
        class     = TGUF3.Backdrop,
        edgeFile  = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize  = 20,
        edgeColor = {1, 1, 1, 1},
        bgColor   = {0, 0, 0, 1},
        insets    = {left=5, right=5, top=5, bottom=5},

        elements = {
            {
                class   = TGUF3.HealthBar,
                color   = {0.271, 0.655, 0.529, 1},
                anchors = {
                    {point = "TOPLEFT", dx=5, dy=-5},
                    {point = "BOTTOMRIGHT", dx=-5, dy=5},
                },

                elements = {
                    -- 1: Name string.
                    {
                        class    = TGUF3.String,
                        key      = "Name",
                        text     = "$nm",
                        alignH   = "LEFT",
                        alignV   = "TOP",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "TOPLEFT", dx=5, dy=-3},
                            {point = "BOTTOM", relativePoint = "CENTER"},
                            {point = "RIGHT", dx=-30},
                        },
                    },

                    -- 2: Health string.
                    {
                        class    = TGUF3.String,
                        text     = "$hc/$hm",
                        alignH   = "RIGHT",
                        alignV   = "TOP",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "TOPLEFT", relativeKey="Name"},
                            {point = "RIGHT", dx=-5},
                            {point = "BOTTOM", relativePoint = "CENTER"},
                        },
                    },

                    -- 3: Class/level string.
                    {
                        class    = TGUF3.String,
                        key      = "ClassLevel",
                        text     = "$lv $ccl",
                        alignH   = "LEFT",
                        alignV   = "BOTTOM",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "BOTTOMLEFT", dx=5, dy=5},
                            {point = "TOP", relativePoint = "CENTER"},
                            {point = "RIGHT", dx=-30},
                        },
                    },

                    -- 4: Power string.
                    {
                        class    = TGUF3.String,
                        text     = "$pc/$pm",
                        alignH   = "RIGHT",
                        alignV   = "TOP",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "TOPLEFT", relativeKey="ClassLevel"},
                            {point = "BOTTOMRIGHT", dx=-5, dy=5},
                        },
                    },
                }
            },
        }
    },
}

DUF_LAYOUT = {
    {
        unit_id = "player",
        width   = 200,
        height  = 40,
        anchor  = {
            point = "TOPLEFT",
            dx    = 300,
            dy    = -300,
        },

        elements = DUF_GENERIC_ELEMENTS,
    },
    {
        unit_id = "target",
        width   = 200,
        height  = 40,
        anchor  = {
            point        = "TOPLEFT",
            relativeUnit = "player",
            dy           = -45,
        },

        elements = DUF_GENERIC_ELEMENTS,
    },
}
