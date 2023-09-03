TGUF3.Element = {}
TG3ElementMixin = TGUF3.Element

local _, PLAYER_CLASS = UnitClass("player")

function TGUF3.Element.MakeElem(unitFrame, parent, elem)
    local f = CreateFrame(elem.class._ftype or "Frame", nil, parent,
                          elem.class._xml)
    f.unitFrame = unitFrame

    if elem.strata then
        f:SetFrameStrata(elem.strata)
    end
    if elem.frameLevel then
        f:SetFrameLevel(elem.frameLevel)
    end
    TGUF3.Element.SetAnchors(f, elem.anchors)
    if elem.width then
        f:SetWidth(elem.width)
    elseif elem.pwidth then
        f:SetWidth(elem.pwidth * parent:GetWidth())
    end
    if elem.height then
        f:SetHeight(elem.height)
    elseif elem.pheight then
        f:SetHeight(elem.pheight * parent:GetHeight())
    end

    f:Init(elem)
    unitFrame.unit:AddListener(f)
    return f
end

function TGUF3.Element.MakeElems(unitFrame, parent, elements)
    parent.children = {}
    for _, e in ipairs(elements) do
        --print("Instantiating "..e.class._name)
        if not e.playerClass or e.playerClass == PLAYER_CLASS then
            local elem = TGUF3.Element.MakeElem(unitFrame, parent, e)
            table.insert(parent.children, elem)

            if e.key then
                unitFrame.keyFrames[e.key] = elem
            end

            if e.elements then
                TGUF3.Element.MakeElems(unitFrame, elem, e.elements)
            end
        end
    end
end

function TGUF3.Element.Reassign(f, old_unit, new_unit)
    if f.children then
        for _, c in ipairs(f.children) do
            old_unit:RemoveListener(c)
            TGUF3.Element.Reassign(c, old_unit, new_unit)
            new_unit:AddListener(c)
        end
    end
end

function TGUF3.Element.SetAnchor(f, anchor)
    local parent        = f:GetParent()
    local point         = anchor.point
    if anchor.relativeKey then
        assert(f.unitFrame.keyFrames[anchor.relativeKey] ~= nil)
    end
    local relativeFrame = f.unitFrame.keyFrames[anchor.relativeKey] or
                          parent
    local relativePoint = anchor.relativePoint or point
    local dx            = anchor.dx or 0
    local dy            = anchor.dy or 0
    f:SetPoint(point, relativeFrame, relativePoint, dx, dy)
end

function TGUF3.Element.SetAnchors(f, anchors)
    if anchors and #anchors > 0 then
        for _, anchor in ipairs(anchors) do
            TGUF3.Element.SetAnchor(f, anchor)
        end
    else
        f:SetAllPoints(f:GetParent())
    end
end
