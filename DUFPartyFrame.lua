DUF_FRAMES.Party = {
    {
        class     = TGUF3.Border,
        strata    = "MEDIUM",
        edgeFile  = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize  = 20,
        edgeColor = {1, 1, 1, 1},
    },
    {
        class = TGUF3.Texture,
        color = {0, 0, 0, 1},
        anchors = {
            {point = "TOPLEFT", dx = 5, dy = -5},
            {point = "BOTTOMRIGHT", dx = -5, dy = 5},
        },

        elements = {
            -- Model.
            {
                class   = TGUF3.Model,
                strata  = "MEDIUM",
                key     = "Model",
                camera  = "BODY",
                width   = 50,
                anchors = {
                    {point = "LEFT", dx = -10},
                    {point = "TOP", dy = 10},
                    {point = "BOTTOM", dy = 10},
                },
            },

            -- Health bar.
            {
                class   = TGUF3.HealthBar,
                key     = "HealthBar",
                color   = {0.271, 0.655, 0.529, 1},
                anchors = {
                    {point = "TOPLEFT"},
                    {point = "RIGHT"},
                    {point = "BOTTOM", relativePoint = "CENTER"},
                },

                elements = {
                    -- Combat icon.
                    {
                        class   = TGUF3.CombatTexture,
                        width   = 20,
                        height  = 20,
                        anchors = {
                            {point = "LEFT", dx = 25},
                        }
                    },

                    -- Name string.
                    {
                        class    = TGUF3.String,
                        key      = "Name",
                        text     = "$nm",
                        alignH   = "LEFT",
                        alignV   = "TOP",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "TOP", dy = -2},
                            {point = "LEFT", relativeKey = "Model",
                             relativePoint = "RIGHT", dx = 5},
                            {point = "BOTTOMRIGHT", dx = -30},
                        },
                    },

                    -- Health string.
                    {
                        class    = TGUF3.String,
                        text     = "$hc/$hm",
                        alignH   = "RIGHT",
                        alignV   = "TOP",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "TOPLEFT", relativeKey = "Name"},
                            {point = "BOTTOMRIGHT", dx = -5},
                        },
                    },
                },
            },

            -- Power bar.
            {
                class    = TGUF3.PowerBar,
                anchors = {
                    {point = "TOPLEFT", relativeKey = "HealthBar",
                     relativePoint = "BOTTOMLEFT"},
                    {point = "BOTTOMRIGHT"},
                },

                elements = {
                    -- Class/level string.
                    {
                        class    = TGUF3.String,
                        key      = "ClassLevel",
                        text     = "$lv $ccl",
                        alignH   = "LEFT",
                        alignV   = "TOP",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "TOP", dy = -2},
                            {point = "BOTTOM"},
                            {point = "LEFT", relativeKey = "Name"},
                            {point = "RIGHT", relativeKey = "Name"},
                        },
                    },

                    -- Power string.
                    {
                        class    = TGUF3.String,
                        text     = "$pc/$pm",
                        alignH   = "RIGHT",
                        alignV   = "TOP",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "TOPLEFT", relativeKey = "ClassLevel"},
                            {point = "BOTTOMRIGHT", dx = -5},
                        },
                    },
                }
            },
        }
    },
}
