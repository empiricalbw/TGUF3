--[[
--  Frame that displays a 3D model of the unit.
--
--  Optional attributes:
--
--      camera - camera angle to use (one of ["HEAD", "BODY"], defaults to
--               "HEAD")
--]]
TGUF3.Model = {
    _name  = "TGUF3.Model",
    _xml   = "TG3ModelTemplate",
    _ftype = "PlayerModel",
}
TG3ModelMixin = TGUF3.Model

local CAMERA_MAP = {
    ["HEAD"] = 0,
    ["BODY"] = 1,
}

function TGUF3.Model:Init(elem)
    self.camera = CAMERA_MAP[elem.camera or "HEAD"]
end

function TGUF3.Model:QueueUpdate(unit)
    -- Update the model in a deferred call.  This is necessary because the
    -- camera update doesn't seem to "take" when we set it from an event
    -- handler (such as PLAYER_TARGET_CHANGED).
    self:SetScript("OnUpdate", TGUF3.Model.UpdateCamera)
end
TGUF3.Model.UPDATE_MODEL = TGUF3.Model.QueueUpdate -- For party units
TGUF3.Model.UPDATE_GUID  = TGUF3.Model.QueueUpdate -- For target unit

function TGUF3.Model:UpdateCamera()
    self:SetUnit(self.unitFrame.unit.id)
    self:SetCamera(self.camera)
    self:SetScript("OnUpdate", nil)
end
