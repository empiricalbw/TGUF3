--[[
--  String to display, with optional dynamic substitutions.
--
--  Dynamic substitutions:
--
--      $nm  - unit name
--      $nc  - unit name colored according to class
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

local RAID_COLOR_CODES = {
    ["HUNTER"]      = "|cffabd473",
    ["WARLOCK"]     = "|cff9482c9",
    ["PRIEST"]      = "|cffffffff",
    ["PALADIN"]     = "|cfff58cba",
    ["MAGE"]        = "|cff69ccf0",
    ["ROGUE"]       = "|cfffff569",
    ["DRUID"]       = "|cffff7d0a",
    ["SHAMAN"]      = "|cff2459ff",
    ["WARRIOR"]     = "|cffc79c6e",
    ["DEATHKNIGHT"] = "|cffc41f3b",
    ["MONK"]        = "|cff00ff96",
}

-- Convert a long number into one with K or M appended.
local function SINumber(v)
    if not v then
        return nil
    elseif v < 100000 then
        return v
    elseif v < 1000000 then
        return string.format("%.1fK", v / 1000)
    else
        return string.format("%.1fM", v / 1000000)
    end
end

-- Substitution table.  Note that no substitution should be a substring of some
-- other substitution otherwise behaviour is nondeterministic.  That is, having
-- both "$cc" and "$ccl" in the table would be a bad idea.
local substitutionTable = {
    -- Name.
    ["$nm"] = {
        flag = TGU.FLAGS.NAME,
        func = function(unit)
            return unit.name or ""
        end
    },

    -- Name colored by class.
    ["$nc"] = {
        flag = bit.bor(TGU.FLAGS.NAME,
                       TGU.FLAGS.CLASS),
        func = function(unit)
			if unit.name and unit.class.localized then
                return (RAID_COLOR_CODES[unit.class.name]..unit.name..
                        FONT_COLOR_CODE_CLOSE)
			end
            return ""
        end
    },

    -- Current health.
    ["$hc"] = {
        flag = TGU.FLAGS.HEALTH,
        func = function(unit)
            return unit.health.current or ""
        end
    },

    -- SI current health.
    ["$shc"] = {
        flag = TGU.FLAGS.HEALTH,
        func = function(unit)
            return SINumber(unit.health.current) or ""
        end
    },

    -- Maximum health.
    ["$hm"] = {
        flag = TGU.FLAGS.HEALTH,
        func = function(unit)
            return unit.health.max or ""
        end
    },

    -- SI maximum health.
    ["$shm"] = {
        flag = TGU.FLAGS.HEALTH,
        func = function(unit)
            return SINumber(unit.health.max) or ""
        end
    },

    -- Current power (mana/range/energy/etc.)
    ["$pc"] = {
        flag = TGU.FLAGS.POWER,
        func = function(unit)
            return unit.power.current or ""
        end
    },

    -- Maximum power.
    ["$pm"] = {
        flag = TGU.FLAGS.POWER,
        func = function(unit)
            return unit.power.max or ""
        end
    },

    -- Level.
    ["$lv"] = {
        flag = TGU.FLAGS.LEVEL,
        func = function(unit)
            if unit.level == -1 then
                return "??"
            end
            return unit.level or ""
        end
    },

    -- Class.
    ["$cl"] = {
        flag = TGU.FLAGS.CLASS,
        func = function(unit)
            return unit.class.localized or ""
        end
    },

    -- Creature type if NPC or class if PC.
    ["$ccl"] = {
        flag = bit.bor(TGU.FLAGS.CLASS,
                       TGU.FLAGS.CREATURETYPE,
                       TGU.FLAGS.NPC),
        func = function(unit)
            if unit.npc then
                return unit.creatureType or ""
            end
            return unit.class.localized or ""
        end
    },

    -- Threat ceiling - total amount of threat required to pull aggro.
    ["$thc"] = {
        flag = TGU.FLAGS.THREAT,
        func = function(unit)
            return unit.threat.ceiling or ""
        end
    },

    -- Threat window - remaining amount of threat needed to pull aggro.
    ["$thw"] = {
        flag = TGU.FLAGS.THREAT,
        func = function(unit)
            return unit.threat.window or ""
        end
    },

    -- Spell name.
    ["$sp"] = {
        flag = TGU.FLAGS.SPELL,
        func = function(unit)
            return unit.castInfo.spell or ""
        end
    },
}

function TGUF3.String:Init(elem)
    local alignH   = elem.alignH or "LEFT"
    local alignV   = elem.alignV or "MIDDLE"
    local font     = elem.font or "Fonts/FRIZQT__.TTF"
    local fontSize = elem.fontSize or 10
    local color    = elem.color or {1, 1, 1, 1}
    local wrap     = elem.wrap or false
    if not font:find("/") and not font:find("\\") then
        font = "Interface/AddOns/TGUF3/Fonts/"..font
    end
    self.String:SetFont(font, fontSize)
    self.String:SetTextColor(unpack(color))
    self.String:SetJustifyH(alignH)
    self.String:SetJustifyV(alignV)
    self.String:SetWordWrap(wrap)
    self.String:SetNonSpaceWrap(wrap)

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
    local text = self.text
    for k, v in pairs(self.substitutions) do
        text = text:gsub(k, v.func(unit))
    end
    self.String:SetText(text)
end
