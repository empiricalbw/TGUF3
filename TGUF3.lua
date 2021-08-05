-- TGUF 3 AddOn.
TGUF3 = {
    log_level       = 1,
    log             = TGLog:new(1, 1),

    Frames = {},
}

function TGUF3.dbg(...)
    local timestamp = GetTime()
    TGUF3.log:log(
        TGUF3.log_level,
        "[", timestamp, "] ",
        LIGHTYELLOW_FONT_COLOR_CODE.."TGUF3: "..FONT_COLOR_CODE_CLOSE,
        ...)
end

function TGUF3.ADDON_LOADED(addOnName)
    if addOnName ~= "TGUF3" then
        return
    end

    for i, layout in ipairs(DUF_FRAMES.Layout) do
        local f = TGUF3.UnitFrame:New(layout)
        TGUF3.Frames[f.unit.id] = f
    end

    TGUF3.dbg("Loaded")
end

function TGUF3.OnUpdate()
end

TGEventManager.Register(TGUF3)
