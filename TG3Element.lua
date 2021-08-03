TGUF3.Element = {}
TG3ElementMixin = TGUF3.Element

function TGUF3.Element.MakeElems(unitFrame, parent, elements)
    parent.children = {}
    for _, e in ipairs(elements) do
        print("Instantiating "..e.class.name)
        local elem = e.class:New(unitFrame, parent, e)
        table.insert(parent.children, elem)
    end
end

function TGUF3.Element:SetAnchor(anchor)
    local parent        = self:GetParent()
    local point         = anchor.point
    local relativeFrame = parent.children[anchor.relativeUnit] or parent
    local relativePoint = anchor.relativePoint or point
    local dx            = anchor.dx or 0
    local dy            = anchor.dy or 0
    self:SetPoint(point, relativeFrame, relativePoint, dx, dy)
end

function TGUF3.Element:SetAnchors(anchors)
    for _, anchor in ipairs(anchors) do
        self:SetAnchor(anchor)
    end
end
