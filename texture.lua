TGUF3.Texture = {
    name = "TGUF3.Texture",
}
TGUF3.Texture.__index = TGUF3.Texture

function TGUF3.Texture:new(unitFrame, parent, elem)
    -- Create the element.
    local textureElem = {}
    setmetatable(textureElem, self)

    -- Add the texture to the unit frame.
    local t = parent:CreateTexture()
    TGUF3.Element.set_anchors(unitFrame, parent, t, elem.anchors)
    t:SetTexture(elem.id)
    --t:SetTexture("interface/icons/inv_mushroom_11")
end
