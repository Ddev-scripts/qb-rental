local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-rental:attemptPurchase')
AddEventHandler('qb-rental:attemptPurchase', function(car, price, needLicense, garage)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local driverLicense = Player.PlayerData.metadata["licences"]["driver"]

    if not driverLicense and needLicense then
        TriggerClientEvent('qb-rental:noDriverLicense', source)
        return
    end

    local cash = Player.PlayerData.money.cash

    if cash >= price then
        TriggerClientEvent('qb-rental:vehiclespawn', source, car, price, garage)
    else
        TriggerClientEvent('qb-rental:attemptvehiclespawnfail', source)
    end
end)

RegisterServerEvent('qb-rental:purchase')
AddEventHandler('qb-rental:purchase', function(price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveMoney("cash", price, "rentals")
    TriggerClientEvent('QBCore:Notify', src, Config.translations[Config.locale].info_back, "success")
end)

RegisterServerEvent('qb-rental:giverentalpaperServer')
AddEventHandler('qb-rental:giverentalpaperServer', function(plateText)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(src)
    local info = {
        label = plateText
    }
    PlayerData.Functions.AddItem('rentalpapers', 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['rentalpapers'], "add")
end)

RegisterServerEvent('qb-rental:server:payreturn')
AddEventHandler('qb-rental:server:payreturn', function(model)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    for k, v in pairs(Config.vehicleList) do
        if string.lower(v.model) == model then
            local price = v.price / 2
            Player.Functions.AddMoney("cash", price, "rental-return")
            TriggerClientEvent('QBCore:Notify', src, Config.translations[Config.locale].success_back .. price, "success")
        end
    end
end)

QBCore.Functions.CreateCallback('qb-rental:server:hasrentalpapers', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local Item = Player.Functions.GetItemByName("rentalpapers")
    if Item ~= nil then
        cb(true)
    else
        cb(false)
    end
end)
