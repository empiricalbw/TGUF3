TGUF3.Border = {
    _name = "TGUF3.Border",
    _xml  = "TG3BorderTemplate",
}
TG3BorderMixin = TGUF3.Border

function TGUF3.Border:Init(elem)
    local backdrop = {
        edgeFile = elem.edgeFile,
        edgeSize = elem.edgeSize,
    }
    self:SetBackdrop(backdrop)
    if elem.edgeColor then
        self:SetBackdropBorderColor(unpack(elem.edgeColor))
    end
end
