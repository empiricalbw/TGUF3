TGUF3.Element = {}
TGUF3.Element.__index = TGUF3.Element

function TGUF3.Element.make_elems(unitFrame, parent, elements)
    parent.elements = {}
    for _, e in ipairs(elements) do
        print("Instantiating "..e.class.name)
        elem = e.class:new(unitFrame, parent, e)
        table.insert(parent.elements, elem)
    end
end

function TGUF3.Element.set_anchors(unitFrame, parent, elem, anchors)
    for _, anchor in ipairs(anchors) do
        if anchor.anchor_frame == nil then
            anchor_frame = unitFrame
        else
            anchor_frame = parent.elements[anchor.anchor_frame]
        end
        elem:SetPoint(anchor.my_anchor, anchor_frame, anchor.target_anchor,
                      anchor.dx, anchor.dy)
    end
end
