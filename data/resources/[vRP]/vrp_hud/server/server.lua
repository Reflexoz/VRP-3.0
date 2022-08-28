Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        TriggerClientEvent('Ultra-Hud:GetActivePlayers', -1, GetNumPlayerIndices())
    end
end)
