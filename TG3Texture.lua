TGUF3.Texture = {
    name = "TGUF3.Texture",
}
TG3TextureMixin = TGUF3.Texture

function TGUF3.Texture:New(unitFrame, parent, elem)
    -- Create the element.
    local f = CreateFrame("Frame", nil, parent, "TG3TextureTemplate")
    f:SetAnchors(elem.anchors)
    f.Texture:SetTexture(elem.id)
end
