-- https://github.com/ImagicTheCat/vRP
-- MIT license (see LICENSE or vrp/vRPShared.lua)
if not vRP.modules.survival then
    return
end

local Survival = class("Survival", vRP.Extension)

local function getHunger(self)
    local sdata = self:getUData(user_id, "vRP:datatable")

    if sdata then
        return sdata.hunger
    end

    return 0
end

local function getThirst(self)
    local sdata = self:getUData(user_id, "vRP:datatable")

    if sdata then
        return sdata.thirst
    end

    return 0
end

local function getStress(self)
    local sdata = self:getUData(user_id, "vRP:datatable")

    if sdata then
        return sdata.stress
    end

    return 0
end

local function setHunger(self)
end

local function setThirst(self)
end

local function setStress(self)
end

function Survival:__construct()
    vRP.Extension.__construct(self)

    getHunger(self)
    getThirst(self)
    getStress(self)
    setHunger(self)
    setThirst(self)
    setStress(self)
end
