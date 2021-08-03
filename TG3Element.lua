TGUF3.Element = {}
TG3ElementMixin = TGUF3.Element

function TGUF3.Element.MakeElem(unitFrame, parent, elem)
    local f = CreateFrame("Frame", nil, parent, elem.class.xml)
    TGUF3.Element.SetAnchors(f, elem.anchors)
    if elem.width then
        f:SetWidth(elem.width)
    end
    if elem.height then
        f:SetHeight(elem.height)
    end

    f.unitFrame = unitFrame
    f:Init(elem)
    return f
end

function TGUF3.Element.MakeElems(unitFrame, parent, elements)
    parent.children = {}
    for _, e in ipairs(elements) do
        print("Instantiating "..e.class.name)
        local elem = TGUF3.Element.MakeElem(unitFrame, parent, e)
        table.insert(parent.children, elem)
    end
end

function TGUF3.Element.SetAnchor(f, anchor)
    local parent        = f:GetParent()
    local point         = anchor.point
    local relativeFrame = parent.children[anchor.relativeUnit] or parent
    local relativePoint = anchor.relativePoint or point
    local dx            = anchor.dx or 0
    local dy            = anchor.dy or 0
    f:SetPoint(point, relativeFrame, relativePoint, dx, dy)
end

function TGUF3.Element.SetAnchors(f, anchors)
    for _, anchor in ipairs(anchors) do
        TGUF3.Element.SetAnchor(f, anchor)
    end
end
