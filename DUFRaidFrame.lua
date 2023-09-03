DUF_FRAMES.RaidLeft =
{
    {
        class   = TGUF3.StatusTexture,
        key     = "StatusTexture",
        color   = {0.2, 0.2, 0.2, 1},
        texture = "Interface/Addons/TGUF3/DUF_Images/bg",
        anchors =
        {
            {point = "TOPLEFT"},
            {point = "BOTTOMRIGHT", relativePoint = "BOTTOMLEFT", dx = 4},
        },
    },
    {
        class   = TGUF3.Texture,
        key     = "SeparatorTexture",
        color   = {0, 0, 0, 1},
        texture = "Interface/Addons/TGUF3/DUF_Images/bg",
        anchors =
        {
            {point = "TOPLEFT", relativeKey = "StatusTexture",
             relativePoint = "TOPRIGHT", dx = 1},
            {point = "BOTTOMRIGHT", relativeKey = "StatusTexture",
             relativePoint = "BOTTOMLEFT", dx = 2},
        },
    },
    {
        class = TGUF3.Texture,
        color = {0, 0, 0, 1},
        anchors  =
        {
            {point = "TOPLEFT", relativeKey = "SeparatorTexture",
             relativePoint = "TOPRIGHT"},
            {point = "BOTTOMRIGHT"},
        },
        elements =
        {
            -- Health bar.
            {
                class    = TGUF3.HealthBar,
                key      = "HealthBar",
                color    = {0.271, 0.655, 0.529, 1},
                elements =
                {
                    -- Name string.
                    {
                        class    = TGUF3.String,
                        key      = "Name",
                        text     = "$nc",
                        alignH   = "CENTER",
                        alignV   = "MIDDLE",
                        font     = "DUF_Font1.ttf",
                        anchors  =
                        {
                            {point = "TOPLEFT", dy = 1},
                            {point = "BOTTOMRIGHT", dy = 1},
                        },
                    },
                },
            },

            -- Debuffs.
            {
                class         = TGUF3.DebuffList,
                width         = 16,
                height        = 16,
                mineDimension = 16,
                valign        = "",
                direction     = "LEFT",
                anchors = {
                    {point = "RIGHT", relativeKey = "StatusTexture",
                     relativePoint = "LEFT", dx = -1},
                },
            },
        },
    },
}

DUF_FRAMES.RaidRight =
{
    {
        class   = TGUF3.StatusTexture,
        key     = "StatusTexture",
        color   = {0.2, 0.2, 0.2, 1},
        texture = "Interface/Addons/TGUF3/DUF_Images/bg",
        anchors =
        {
            {point = "TOPLEFT"},
            {point = "BOTTOMRIGHT", relativePoint = "BOTTOMLEFT", dx = 4},
        },
    },
    {
        class   = TGUF3.Texture,
        key     = "SeparatorTexture",
        color   = {0, 0, 0, 1},
        texture = "Interface/Addons/TGUF3/DUF_Images/bg",
        anchors =
        {
            {point = "TOPLEFT", relativeKey = "StatusTexture",
             relativePoint = "TOPRIGHT", dx = 1},
            {point = "BOTTOMRIGHT", relativeKey = "StatusTexture",
             relativePoint = "BOTTOMLEFT", dx = 2},
        },
    },
    {
        class = TGUF3.Texture,
        color = {0, 0, 0, 0},
        anchors  =
        {
            {point = "TOPLEFT", relativeKey = "SeparatorTexture",
             relativePoint = "TOPRIGHT"},
            {point = "BOTTOMRIGHT"},
        },
        elements = {
            -- Health bar.
            {
                class   = TGUF3.HealthBar,
                key     = "HealthBar",
                color   = {0.271, 0.655, 0.529, 1},
                elements =
                {
                    -- Name string.
                    {
                        class    = TGUF3.String,
                        key      = "Name",
                        text     = "$nc",
                        alignH   = "CENTER",
                        alignV   = "MIDDLE",
                        font     = "DUF_Font1.ttf",
                        anchors =
                        {
                            {point = "TOPLEFT", dy = 1},
                            {point = "BOTTOMRIGHT", dy = 1},
                        },
                    },
                },
            },

            -- Debuffs.
            {
                class         = TGUF3.DebuffList,
                width         = 16,
                height        = 16,
                mineDimension = 16,
                valign        = "",
                direction     = "RIGHT",
                anchors =
                {
                    {point = "LEFT", relativeKey = "HealthBar",
                     relativePoint = "RIGHT", dx = 1},
                },
            },
        },
    },
}
