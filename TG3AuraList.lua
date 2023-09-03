TGUF3.AuraList = {
    _name = "TGUF3.AuraList",
    _xml  = "TG3AuraListTemplate",
}
TG3AuraListMixin = TGUF3.AuraList

function TGUF3.AuraList:Init(elem, xml)
    local count     = elem.count or 32
    local dx        = elem.dx or 2
    local dy        = elem.dy or 0
    local dimension = self:GetHeight()

    self.children = {}
    for i=1, count do
        local f = CreateFrame("Frame", nil, self, xml)
        f:SetWidth(dimension)
        f:SetHeight(dimension)
        if i == 1 then
            f:SetPoint(elem.align.."LEFT", self, elem.align.."LEFT", 0, 0)
        else
            f:SetPoint(elem.align.."LEFT", self.children[i-1],
                       elem.align.."RIGHT", dx, dy)
        end
        f.unitFrame = self.unitFrame
        f:Init({index = i, dimension = dimension,
                mineDimension = elem.mineDimension})
        self.unitFrame.unit:AddListener(f)
        self.children[i] = f
    end
end

TGUF3.BuffList = {
    _name = "TGUF3.BuffList",
    _xml  = "TG3BuffListTemplate",
}
TG3BuffListMixin = TGUF3.BuffList

function TGUF3.BuffList:Init(elem)
    TGUF3.AuraList.Init(self, elem, "TG3BuffTemplate")
end

TGUF3.DebuffList = {
    _name = "TGUF3.DebuffList",
    _xml  = "TG3DebuffListTemplate",
}
TG3DebuffListMixin = TGUF3.DebuffList

function TGUF3.DebuffList:Init(elem)
    TGUF3.AuraList.Init(self, elem, "TG3DebuffTemplate")
end
