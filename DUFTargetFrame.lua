DUF_FRAMES.Target = {
    {
        class     = TGUF3.Border,
        strata    = "MEDIUM",
        edgeFile  = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize  = 20,
        edgeColor = {1, 1, 1, 1},
    },
    {
        class   = TGUF3.Texture,
        color   = {0, 0, 0, 0},
        anchors = {
            {point = "TOPLEFT", dx = 5, dy = -5},
            {point = "BOTTOMRIGHT", dx = -5, dy = 5},
        },

        elements = {
            -- Consideration texture.
            {
                class   = TGUF3.ConTexture,
                width   = 40,
                anchors = {
                    {point = "TOPLEFT"},
                    {point = "BOTTOM"},
                },

                elements = {
                    -- Model.
                    {
                        class   = TGUF3.Model,
                        key     = "Model",
                        camera  = "HEAD",
                    },
                },
            },

            -- Health bar.
            {
                class   = TGUF3.HealthBar,
                key     = "HealthBar",
                color   = {0.271, 0.655, 0.529, 1},
                height  = 20,
                anchors = {
                    {point = "TOPLEFT", relativeKey = "Model",
                     relativePoint = "TOPRIGHT"},
                    {point = "RIGHT"},
                },

                elements = {
                    -- Combat icon.
                    {
                        class   = TGUF3.CombatTexture,
                        width   = 20,
                        height  = 20,
                        anchors = {
                            {point = "LEFT", dx = 5},
                        },
                    },

                    -- Name string.
                    {
                        class    = TGUF3.String,
                        key      = "Name",
                        text     = "$nm",
                        alignH   = "LEFT",
                        alignV   = "MIDDLE",
                        font     = "DUF_Font1.ttf",
                        anchors  = {
                            {point = "TOPLEFT", dx = 25},
                            {point = "BOTTOMRIGHT", dx = -70},
                        },
                    },

                    -- Health string.
                    {
                        class    = TGUF3.String,
                        text     = "$shc/$shm",
                        alignH   = "RIGHT",
                        alignV   = "MIDDLE",
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
                class   = TGUF3.PowerBar,
                key     = "PowerBar",
                height  = 14,
                anchors = {
                    {point = "TOPLEFT", relativeKey = "HealthBar",
                     relativePoint = "BOTTOMLEFT"},
                    {point = "RIGHT"},
                },

                elements = {
                    -- Raid icon.
                    {
                        class   = TGUF3.RaidIconTexture,
                        width   = 13,
                        height  = 13,
                        anchors = {
                            {point = "LEFT", dx = 7},
                        },
                    },

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

            -- Cast bar.
            {
                class   = TGUF3.CastBar,
                key     = "CastBar",
                height  = 14,
                anchors = {
                    {point = "TOPLEFT", relativeKey = "PowerBar",
                     relativePoint = "BOTTOMLEFT"},
                    {point = "RIGHT"},
                },

                elements = {
                    -- Spell string.
                    {
                        class    = TGUF3.String,
                        text     = "-$sp-",
                        alignH   = "CENTER",
                        alignV   = "MIDDLE",
                        font     = "DUF_Font1.ttf",
                    },
                }
            },

            -- Threat bar.
            {
                class   = TGUF3.ThreatTexture,
                key     = "Threat",
                anchors = {
                    {point = "TOPLEFT", relativeKey = "CastBar",
                     relativePoint = "BOTTOMLEFT"},
                    {point = "BOTTOMRIGHT"},
                },

                elements = {
                    -- Threat total string.
                    {
                        class    = TGUF3.String,
                        text     = "$thc",
                        alignH   = "CENTER",
                        alignV   = "MIDDLE",
                        font     = "DUF_Font1.ttf",
                        fontSize = 8,
                        anchors  = {
                            {point = "TOPLEFT"},
                            {point = "BOTTOMRIGHT"},
                        },
                    },

                    -- Threat window string.
                    {
                        class    = TGUF3.String,
                        text     = "$thw",
                        alignH   = "RIGHT",
                        alignV   = "MIDDLE",
                        font     = "DUF_Font1.ttf",
                        fontSize = 8,
                        anchors  = {
                            {point = "TOPLEFT"},
                            {point = "BOTTOMRIGHT", dx = -5},
                        },
                    },
                },
            },

            -- Buffs.
            {
                class         = TGUF3.BuffList,
                width         = 16,
                height        = 16,
                mineDimension = 20,
                valign        = "BOTTOM",
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
                valign        = "TOP",
                anchors = {
                    {point = "TOPLEFT", relativeKey = "Threat",
                     relativePoint = "BOTTOMLEFT", dy = -3},
                }
            },
        }
    },
}
