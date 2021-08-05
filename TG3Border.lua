--[[
--  Frame that just provides a border texture.  Typically you may wish to place
--  this in a higher strata (i.e. "MEDIUM") so that it appears above all other
--  frames that are part of the unit frame.
--
--  Required attributes:
--
--      edgeFile - edge texture file (string)
--      edgeSize - size of the corners (int)
--
--  Optional attributes:
--
--      edgeColor - color to apply to the border {r, g, b, a}
--]]
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
