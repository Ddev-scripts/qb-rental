local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-rental:attemptPurchase')
AddEventHandler('qb-rental:attemptPurchase', function(car, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cash = Player.PlayerData.money.cash
    if cash >= price then
        TriggerClientEvent('qb-rental:vehiclespawn', source, car, price)
    else
        TriggerClientEvent('qb-rental:attemptvehiclespawnfail', source)
    end
end)

RegisterServerEvent('qb-rental:purchase')
AddEventHandler('qb-rental:purchase', function(car, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveMoney("cash", price, "rentals")
    TriggerClientEvent('QBCore:Notify', src, "Vous avez loué un(e) " .. car .. " pour $" .. price .. ", Pensez à rendre ce véhicule pour récupérer 50% du prix du véhicule.", "success")
end)

RegisterServerEvent('qb-rental:giverentalpaperServer')
AddEventHandler('qb-rental:giverentalpaperServer', function(model, plateText)
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
            local payment = v.price / 2
            Player.Functions.AddMoney("cash", payment, "rental-return")
            TriggerClientEvent('QBCore:Notify', src, "Vous avez rendu le véhicule, et vous avez récupéré $" .. payment, "success")
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
