TGUF3 = {
    Frames = {},
}

function TGUF3.ADDON_LOADED(addOnName)
    if addOnName ~= "TGUF3" then
        return
    end

    for i, layout in ipairs(DUF_FRAMES.Layout) do
        TGUF3.UnitFrame:New(layout)
    end
end

function TGUF3.OnUpdate()
end

TGEventManager.Register(TGUF3)
