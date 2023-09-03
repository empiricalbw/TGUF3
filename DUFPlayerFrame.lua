DUF_FRAMES.Player = {
    {
        class     = TGUF3.Border,
        strata    = "MEDIUM",
        edgeFile  = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize  = 20,
        edgeColor = {1, 1, 1, 1},
        colorize  = true,
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
                frameLevel = 100,
                camera  = "BODY",
                width   = 46,
                height  = 80,
                anchors = {
                    {point = "LEFT", dx = -5},
                    {point = "BOTTOM"},
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
                targetColor = {1, 1, 1, 0.2},
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
                        text     = "$nc",
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

            -- Blue line texture.
            {
                class    = TGUF3.Texture,
                key      = "HorizDivider",
                color    = {50/255, 105/255, 107/255, 0.5},
                anchors  = {
                    {point = "TOPLEFT", relativeKey = "HealthBar",
                     relativePoint = "BOTTOMLEFT"},
                    {point = "BOTTOMRIGHT", relativeKey = "HealthBar",
                     relativePoint = "BOTTOMRIGHT", dy = -1},
                 },
            },

            -- Power bar.
            {
                class    = TGUF3.PowerBar,
                key      = "PowerBar",
                anchors = {
                    {point = "TOPLEFT", relativeKey = "HorizDivider",
                     relativePoint = "BOTTOMLEFT"},
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

            -- Debuffs.
            {
                class         = TGUF3.DebuffList,
                width         = 16,
                height        = 16,
                mineDimension = 20,
                valign        = "TOP",
                anchors = {
                    {point = "TOPLEFT", relativeKey = "PowerBar",
                     relativePoint = "BOTTOMLEFT", dy = -3},
                }
            },

            -- Role icon.
            {
                strata   = "MEDIUM",
                class    = TGUF3.RoleIconTexture,
                width    = 20,
                height   = 20,
                anchors = {
                    {point = "CENTER", relativePoint = "BOTTOMLEFT"},
                },
            },
        }
    },
}
