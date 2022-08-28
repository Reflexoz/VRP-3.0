Config = {}

Config.BeltKey = 'B'
Config.ONandOFFMotorKey = 'Y'
Config.StatusUpdateInterval = 4000
Config.MinimapJustInCar = true

function GetStatus(cb)
    TriggerEvent("esx_status:getStatus", "hunger", function(h)
        TriggerEvent("esx_status:getStatus", "thirst", function(t)
            local hunger = h.getPercent()
            local thirst = t.getPercent()
            local stress = 10
            cb({hunger, thirst, stress})
        end)
    end)
end
