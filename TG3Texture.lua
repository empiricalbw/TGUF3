TGUF3.Texture = {
    name = "TGUF3.Texture",
    xml  = "TG3TextureTemplate",
}
TG3TextureMixin = TGUF3.Texture

function TGUF3.Texture:Init(elem)
    self.Texture:SetTexture(elem.id)
end
