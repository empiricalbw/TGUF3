TGUF3.Backdrop = {
    _name = "TGUF3.Backdrop",
    _xml  = "TG3BackdropTemplate",
}
TG3BackdropMixin = TGUF3.Backdrop

function TGUF3.Backdrop:Init(elem)
    local backdrop = {
        bgFile   = elem.bgFile,
        tile     = elem.til,
        tileSize = elem.tileSize,
        edgeFile = elem.edgeFile,
        edgeSize = elem.edgeSize,
        insets   = elem.insets,
    }
    self:SetBackdrop(backdrop)
    if elem.bgColor then
        if not elem.bgFile then
            self.Texture:SetColorTexture(unpack(elem.bgColor))
            self.Texture:ClearAllPoints()
            self.Texture:SetPoint("TOPLEFT", self, "TOPLEFT",
                                  elem.insets.left,  -elem.insets.top)
            self.Texture:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT",
                                  -elem.insets.right, elem.insets.bottom)
            self.Texture:Show()
        else
            self:SetBackdropColor(unpack(elem.bgColor))
        end
    end
    if elem.edgeColor then
        self:SetBackdropBorderColor(unpack(elem.edgeColor))
    end

    if elem.id then
        self.Texture:SetTexture(elem.id)
        self.Texture:Show()
    end
end
