local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('money:update')
AddEventHandler('money:update', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local money = Player.PlayerData.money

        TriggerClientEvent('money:update', src, money)
    else
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        local players = QBCore.Functions.GetPlayers()
        for _, playerId in ipairs(players) do
            local Player = QBCore.Functions.GetPlayer(playerId)
            if Player then
                local money = Player.PlayerData.money

                TriggerClientEvent('money:update', playerId, money)
            end
        end
    end
end)
