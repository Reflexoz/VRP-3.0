-- https://github.com/ImagicTheCat/vRP
-- MIT license (see LICENSE or vrp/vRPShared.lua)
if not vRP.modules.misc then
    return
end

local Survival = class("Survival", vRP.Extension)

function Survival:__construct()
    vRP.Extension.__construct(self)

end

vRP:registerExtension(Survival)
