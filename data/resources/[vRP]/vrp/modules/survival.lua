-- https://github.com/ImagicTheCat/vRP
-- MIT license (see LICENSE or vrp/vRPShared.lua)
if not vRP.modules.survival then
    return
end

local Survival = class("Survival", vRP.Extension)

local function getHunger(user_id)
    local data = self:getUData(user_id, "vRP:datatable")

    if data then
        return data.hunger
    end

    return 0
end

local function getThirst(user_id)
    local data = self:getUData(user_id, "vRP:datatable")

    if data then
        return data.thirst
    end

    return 0
end

local function getStress(user_id)
    local data = self:getUData(user_id, "vRP:datatable")

    if data then
        return data.stress
    end

    return 0
end

function Survival:__construct()
    vRP.Extension.__construct(self)

    getHunger(self)
    getThirst(self)
    getStress(self)
end
