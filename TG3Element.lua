TGUF3.Element = {}
TG3ElementMixin = TGUF3.Element

function TGUF3.Element.MakeElem(unitFrame, parent, elem)
    local f = CreateFrame(elem.class._ftype or "Frame", nil, parent,
                          elem.class._xml)
    f.unitFrame = unitFrame

    if elem.strata then
        f:SetFrameStrata(elem.strata)
    end
    TGUF3.Element.SetAnchors(f, elem.anchors)
    if elem.width then
        f:SetWidth(elem.width)
    end
    if elem.height then
        f:SetHeight(elem.height)
    end

    f:Init(elem)
    unitFrame.unit:AddListener(f)
    return f
end

function TGUF3.Element.MakeElems(unitFrame, parent, elements)
    parent.children = {}
    for _, e in ipairs(elements) do
        --print("Instantiating "..e.class._name)
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
