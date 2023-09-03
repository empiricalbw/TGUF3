DUF_FRAMES.ComboPoints = {
    --[[
    {
        class     = TGUF3.Border,
        strata    = "MEDIUM",
        edgeFile  = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize  = 20,
        edgeColor = {1, 1, 1, 1},
        colorize  = true,
    },
    ]]
    -- Power bar.
    {
        class   = TGUF3.PowerBar,
        key     = "PowerBar",
        height  = 14,
        anchors = {
            {point = "TOPLEFT", dx = 16},
            {point = "RIGHT"},
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
                    {point = "BOTTOMRIGHT", dx = -5, dy = 2},
                },
            },
        }
    },

    -- Combo points.
    {
        class           = TGUF3.Texture,
        id              = "Interface/Addons/TGUF3/DUF_Images/CircleIcon",
        width           = 32,
        height          = 32,
        frameLevel      = 200,
        anchors = {
            {point = "TOPLEFT", dx = 0, dy = 8},
        },

        elements = {
            {
                class   = TGUF3.String,
                key     = "ComboCount",
                text    = "$cp",
                alignH  = "CENTER",
                alignV  = "MIDDLE",
                font    = "DUF_Font1.ttf",
                width   = 32,
                height  = 32,
                anchors = {
                    {point = "CENTER", dx = -5.5, dy = 2},
                },
            }
        },
    },
}
