DUF_FRAMES.Player = {
    {
        class     = TGUF3.Border,
        strata    = "MEDIUM",
        edgeFile  = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize  = 20,
        edgeColor = {1, 1, 1, 1},
    },
    {
        class = TGUF3.Texture,
        color = {0, 0, 0, 0},
        anchors = {
            {point = "TOPLEFT", dx = 5, dy = -5},
            {point = "BOTTOMRIGHT", dx = -5, dy = 5},
        },

        elements = {
            -- Leader icon.
            {
                class   = TGUF3.LeaderTexture,
                width   = 12,
                height  = 12,
                anchors = {
                    {point = "BOTTOMLEFT", relativePoint = "TOPLEFT",
                     dx = 0, dy = 2},
                }
            },

            -- Master looter icon.
            {
                class   = TGUF3.LootMasterTexture,
                width   = 12,
                height  = 12,
                anchors = {
                    {point = "BOTTOMLEFT", relativePoint = "TOPLEFT",
                     dx = 20, dy = 3},
                }
            },

            -- Model.
            {
                class   = TGUF3.Model,
                strata  = "MEDIUM",
                camera  = "BODY",
                width   = 46,
                height  = 80,
                anchors = {
                    {point = "LEFT", dx = -5},
                    {point = "BOTTOM"},
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
                        key     = "Combat",
                        width   = 20,
                        height  = 20,
                        anchors = {
                            {point = "LEFT", dx = 32, dy = 1},
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
                            {point = "LEFT", relativeKey="Combat",
                             relativePoint = "RIGHT", dx = 2, dy = -2},
                            {point = "BOTTOMRIGHT", dx = -30, dy = 4},
                        },
                    },

                    -- Health string.
                    {
                        class    = TGUF3.String,
                        text     = "$hc/$hm",
                        alignH   = "RIGHT",
                        alignV   = "MIDDLE",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "TOPLEFT", relativeKey="Name"},
                            {point = "BOTTOM", relativeKey="Name"},
                            {point = "RIGHT", dx = -5},
                        },
                    },

                    -- Class/level string.
                    {
                        class    = TGUF3.String,
                        key      = "ClassLevel",
                        text     = "$lv $ccl",
                        alignH   = "LEFT",
                        alignV   = "BOTTOM",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "TOPLEFT", relativeKey="Name"},
                            {point = "BOTTOMRIGHT", relativeKey="Name"},
                        },
                    },
                },
            },

            -- Power bar.
            {
                class    = TGUF3.PowerBar,
                anchors = {
                    {point = "TOPLEFT", relativeKey = "HealthBar",
                     relativePoint = "BOTTOMLEFT", dy = -1},
                    {point = "BOTTOMRIGHT"},
                },

                elements = {
                    -- Power string.
                    {
                        class    = TGUF3.String,
                        text     = "$pc/$pm",
                        alignH   = "RIGHT",
                        alignV   = "MIDDLE",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "TOPLEFT"},
                            {point = "BOTTOMRIGHT", dx = -5},
                        },
                    },
                }
            },
        }
    },
}
