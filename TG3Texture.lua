TGUF3.Texture = {
    _name = "TGUF3.Texture",
    _xml  = "TG3TextureTemplate",
}
TG3TextureMixin = TGUF3.Texture

function TGUF3.Texture:Init(elem)
    if elem.id then
        self.Texture:SetTexture(elem.id)
        if elem.color then
            self.Texture:SetVertexColor(unpack(elem.color))
        end
    elseif elem.color then
        self.Texture:SetColorTexture(unpack(elem.color))
    end
end
