DUF_FRAMES.Party = {
    {
        class     = TGUF3.Border,
        strata    = "MEDIUM",
        edgeFile  = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize  = 20,
        edgeColor = {1, 1, 1, 1},
    },
    {
        class   = TGUF3.Texture,
        strata  = "LOW",
        color   = {0, 0, 0, 0},
        anchors = {
            {point = "TOPLEFT", dx = 5, dy = -5},
            {point = "BOTTOMRIGHT", dx = -5, dy = 5},
        },

        elements = {
            -- Leader icon.
            {
                class   = TGUF3.LeaderTexture,
                key     = "Leader",
                width   = 12,
                height  = 12,
                anchors = {
                    {point = "TOPRIGHT", relativePoint = "TOPLEFT", dx = -3},
                }
            },

            -- Master looter icon.
            {
                class   = TGUF3.LootMasterTexture,
                width   = 12,
                height  = 12,
                anchors = {
                    {point = "TOPLEFT", relativeKey = "Leader",
                     relativePoint = "BOTTOMLEFT"},
                }
            },

            -- Model.
            {
                class   = TGUF3.Model,
                strata  = "MEDIUM",
                frameLevel = 100,
                camera  = "BODY",
                width   = 46,
                height  = 47,
                anchors = {
                    {point = "LEFT", dx = -5},
                    {point = "BOTTOM", dy = 0},
                },
            },

            -- Target highlight.
            {
                class = TGUF3.Texture,
                frameLevel = 200,
                anchors = {
                    {point = "TOPLEFT"},
                    {point = "BOTTOMRIGHT"},
                },
                targetHighlight = "Interface/QuestFrame/UI-QuestTitleHighlight",
                targetColor = {1, 1, 1, 0.3},
            },

            -- Health bar.
            {
                class   = TGUF3.HealthBar,
                key     = "HealthBar",
                color   = {0.271, 0.655, 0.529, 1},
                anchors = {
                    {point = "TOPLEFT"},
                    {point = "RIGHT"},
                    {point = "BOTTOM", dy = 16},
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
                class   = TGUF3.PowerBar,
                key     = "PowerBar",
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

            -- Buffs.
            {
                class         = TGUF3.BuffList,
                width         = 16,
                height        = 16,
                mineDimension = 20,
                align         = "BOTTOM",
                anchors = {
                    {point = "BOTTOMLEFT", relativeKey = "HealthBar",
                     relativePoint = "TOPLEFT", dy = 3},
                }
            },

            -- Debuffs.
            {
                class         = TGUF3.DebuffList,
                width         = 16,
                height        = 16,
                mineDimension = 20,
                align         = "TOP",
                anchors = {
                    {point = "TOPLEFT", relativeKey = "PowerBar",
                     relativePoint = "BOTTOMLEFT", dy = -3},
                }
            },
        }
    },
}
