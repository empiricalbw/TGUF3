--[[
--  String to display, with optional dynamic substitutions.
--
--  Dynamic substitutions:
--
--      $nm  - unit name
--      $hc  - current health
--      $hm  - maximum health
--      $pc  - current power
--      $pm  - maximum power
--      $lv  - level
--      $cl  - class
--      $ccl - creature type if unit is NPC otherwise class
--
--  Required attributes:
--
--      text - the string to display
--
--  Optional attributes:
--
--      alignH   - horizontal alignment (one of ["LEFT", "CENTER", "RIGHT"],
--                 defaults to "LEFT")
--      alignV   - vertical alignment (one of ["TOP", "MIDDLE", "BOTTOM"],
--                 defaults to "MIDDLE")
--      font     - path to the font to use
--      fontSize - font size to use (defaults to 10)
--      color    - text color
--]]
TGUF3.String = {
    _name = "TGUF3.String",
    _xml  = "TG3StringTemplate",
}
TG3StringMixin = TGUF3.String

-- Substitution table.  Note that no substitution should be a substring of some
-- other substitution otherwise behaviour is nondeterministic.  That is, having
-- both "$cc" and "$ccl" in the table would be a bad idea.
local substitutionTable = {
    -- Name.
    ["$nm"] = {
        flag = TGU.FLAGS.NAME,
        func = function(unit)
            return unit.name
        end
    },

    -- Current health.
    ["$hc"] = {
        flag = TGU.FLAGS.HEALTH,
        func = function(unit)
            return unit.health.current
        end
    },

    -- Maximum health.
    ["$hm"] = {
        flag = TGU.FLAGS.HEALTH,
        func = function(unit)
            return unit.health.max
        end
    },

    -- Current power (mana/range/energy/etc.)
    ["$pc"] = {
        flag = TGU.FLAGS.POWER,
        func = function(unit)
            return unit.power.current
        end
    },

    -- Maximum power.
    ["$pm"] = {
        flag = TGU.FLAGS.POWER,
        func = function(unit)
            return unit.power.max
        end
    },

    -- Level.
    ["$lv"] = {
        flag = TGU.FLAGS.LEVEL,
        func = function(unit)
            if unit.level == -1 then
                return "??"
            end
            return unit.level
        end
    },

    -- Class.
    ["$cl"] = {
        flag = TGU.FLAGS.CLASS,
        func = function(unit)
            return unit.class.localized
        end
    },

    -- Creature type if NPC or class if PC.
    ["$ccl"] = {
        flag = bit.bor(TGU.FLAGS.CLASS,
                       TGU.FLAGS.CREATURETYPE,
                       TGU.FLAGS.NPC),
        func = function(unit)
            if unit.npc then
                return unit.creatureType
            end
            return unit.class.localized
        end
    },
}

function TGUF3.String:Init(elem)
    local alignH   = elem.alignH or "LEFT"
    local alignV   = elem.alignV or "MIDDLE"
    local font     = elem.font or "Fonts/FRIZQT__.TTF"
    local fontSize = elem.fontSize or 10
    local color    = elem.color or {1, 1, 1, 1}
    if not font:find("/") and not font:find("\\") then
        font = "Interface/AddOns/TGUF_2/Fonts/"..font
    end
    self.String:SetFont(font, fontSize)
    self.String:SetTextColor(unpack(color))
    self.String:SetJustifyH(alignH)
    self.String:SetJustifyV(alignV)

    self.text          = elem.text
    self.substitutions = {}
    self.tguMask       = 0
    for k, v in pairs(substitutionTable) do
        if self.text:find(k) then
            self.tguMask          = bit.bor(self.tguMask, v.flag)
            self.substitutions[k] = v
        end
    end
end

function TGUF3.String:UPDATE_BITMASK(unit, flags)
    if not unit.exists then
        return
    end

    local text = self.text
    for k, v in pairs(self.substitutions) do
        text = text:gsub(k, v.func(unit))
    end
    self.String:SetText(text)
end
