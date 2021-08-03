TGUF3.String = {
    name = "TGUF3.String",
    xml  = "TG3StringTemplate",
}
TG3StringMixin = TGUF3.String

function TGUF3.String:Init(elem)
    local alignH   = elem.alignH or "LEFT"
    local alignV   = elem.alignV or "MIDDLE"
    local font     = elem.font or "Fonts/FRIZQT__.TTF"
    local fontSize = elem.fontSize or 10
    local color    = elem.color or {1, 1, 1, 1}
    if not string.find(font, "/") then
        font = "Interface/AddOns/TGUF_2/Fonts/"..font
    end
    self.String:SetFont(font, fontSize)
    self.String:SetTextColor(unpack(color))
    self.String:SetJustifyH(alignH)
    self.String:SetJustifyV(alignV)

    self.text = elem.text

    self.unitFrame.unit:AddListener(self)
end

function TGUF3.String:UPDATE_NAME(unit)
    if not unit.exists then
        return
    end

    local text = self.text
    text = string.gsub(text, "$nm", self.unitFrame.unit.name)
    self.String:SetText(text)
end
