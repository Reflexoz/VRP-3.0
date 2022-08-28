RegisterNetEvent('vrp:client:status')
AddEventHandler('vrp:client:status', function(hunger, thirst)
    newHunger = 0
    newThirst = 0
    newStress = 0
end)

AddEventHandler('playerSpawned', function()
    CreateThread(function()
        while true do
            if not IsPauseMenuActive() then
                ped = PlayerPedId()
                health = GetEntityHealth(ped) / 2
                armor = GetPedArmour(ped)
                pid = GetPlayerServerId(PlayerId())
                SendNUIMessage({
                    action = 'updateStatus',
                    health = health,
                    armor = armor,
                    pid = pid,
                    voice = NetworkIsPlayerTalking(PlayerId()),
                    stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
                    oxigen = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10,
                    hunger = newHunger,
                    thirst = newThirst,
                    pall = playersCount,
                    stress = stress
                })

                if IsPedArmed(ped, 7) then
                    local weapon = GetSelectedPedWeapon(ped)
                    local ammoTotal = GetAmmoInPedWeapon(ped, weapon)
                    local bool, ammoClip = GetAmmoInClip(ped, weapon)
                    local ammoRemaining = math.floor(ammoTotal - ammoClip)
                    SendNUIMessage({
                        action = 'updateAmmo',
                        ammo = ammoClip,
                        ammohand = ammoRemaining
                    })
                else
                    SendNUIMessage({
                        action = 'hideAmmo'
                    })
                end
            else
                SendNUIMessage({
                    action = 'hideAllHud'
                })
            end
            Wait(500)
        end
    end)

    CreateThread(function()
        while true do
            Wait(4000)
            food = newHunger
            water = newThirst
            stress = newStress
        end
    end)
end)

RegisterNetEvent('Ultra-Hud:GetActivePlayers')
AddEventHandler('Ultra-Hud:GetActivePlayers', function(players)
    playersCount = players
end)

local cinturon = false
local bateria = true

function Cinturon()
    while true do
        if cinturon then
            DisableControlAction(0, 75, true)
            DisableControlAction(27, 75, true)
        else
            Wait(1000)
        end
        Wait(0)
    end
end

CreateThread(function()
    while true do
        ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            _sleep = 200
            local vehiculo = GetVehiclePedIsUsing(ped)
            local velo = (GetEntitySpeed(vehiculo) * 3.6)
            local gaso = GetVehicleFuelLevel(vehiculo)
            local position = GetEntityCoords(ped)
            local carhealth = GetVehicleBodyHealth(vehiculo) / 10
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
            if true then
                DisplayRadar(true)
            end
            SendNUIMessage({
                action = 'showCarhud',
                vel = velo,
                gasolina = gaso,
                street = streetName,
                cinturon = cinturon,
                bateria = bateria,
                vidav = carhealth,
                map = true
            })
        else
            if true then
                DisplayRadar(false)
                _sleep = 1000
                SendNUIMessage({
                    action = 'hideCarhud',
                    map = false
                })
            else
                _sleep = 1000
                SendNUIMessage({
                    action = 'hideCarhud'
                })
            end
        end
        Wait(_sleep)
    end
end)

function EngineControl()
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if veh ~= nil and veh ~= 0 and GetPedInVehicleSeat(veh, 0) then
        if GetIsVehicleEngineRunning(veh) then
            SetVehicleEngineOn(veh, false, false, true)
            bateria = false

        else
            SetVehicleEngineOn(veh, true, false, true)
            bateria = true
        end
    end
end

RegisterCommand('offmotor', function()
    EngineControl()
end)

RegisterCommand('belt', function()
    local jugador = PlayerPedId()
    if IsPedInAnyVehicle(jugador) then
        if cinturon then

            cinturon = false
            Cinturon(jugador)
        else

            cinturon = true
            Cinturon(jugador)
        end
    end
end)

RegisterKeyMapping('belt', 'Car Belt', 'keyboard', 'B')
RegisterKeyMapping('offmotor', 'Turn ON/OFF the car', 'keyboard', 'Y')

