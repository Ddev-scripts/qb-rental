local QBCore = exports['qb-core']:GetCoreObject()
local function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
    local nearbyEntities = {}
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end
    for k, entity in pairs(entities) do
        local distance = #(coords - GetEntityCoords(entity))
        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = isPlayerEntities and k or entity
        end
    end
    return nearbyEntities
end

local function GetVehiclesInArea(coords, maxDistance)
    -- Vehicle inspection in designated area
    return EnumerateEntitiesWithinDistance(GetGamePool('CVehicle'), false, coords, maxDistance)
end

local function IsSpawnPointClear(coords, maxDistance)
    -- Check the spawn point to see if it's empty or not:
    return #GetVehiclesInArea(coords, maxDistance) == 0
end

local function getVehicleSpawnPoint()
    local near = nil
    local distance = 10000
    for k, v in pairs(Config.spawns) do
        if IsSpawnPointClear(vector3(v.x, v.y, v.z), 2.5) then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local cur_distance = #(pos - vector3(v.x, v.y, v.z))
            if cur_distance < distance then
                distance = cur_distance
                near = k
            end
        end
    end
    return near
end

CreateThread(function()
    local rentBlip = AddBlipForCoord(-1017.93, -2703.8, 13.76, 156.15)
    SetBlipSprite(rentBlip, 227)
    SetBlipScale(rentBlip, 0.7)
    SetBlipDisplay(rentBlip, 4)
    SetBlipColour(rentBlip, 2)
    SetBlipAsShortRange(rentBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Location de véhicules')
    EndTextCommandSetBlipName(rentBlip)
end)

RegisterNetEvent("qb-rental:vehiclelist")
AddEventHandler("qb-rental:vehiclelist", function()
    local vehicles = {}
    for i = 1, #Config.vehicleList do
        table.insert(vehicles, {
            id = Config.vehicleList[i].model,
            header = Config.vehicleList[i].name,
            txt = "$" .. Config.vehicleList[i].price .. ".00",
            params = {
                event = "qb-rental:attemptvehiclespawn",
                args = {
                    id = Config.vehicleList[i].model,
                    price = Config.vehicleList[i].price,
                }
            }
        })
    end
    exports['qb-menu']:openMenu(vehicles)
end)

CreateThread(function()
    exports['qb-target']:SpawnPed({
        model = 'a_m_m_indian_01',
        coords = vector4(-1017.93, -2703.8, 13.76, 156.15),
        minusOne = true,
        freeze = true,
        invincible = true,
        blockevents = true,
        animDict = 'abigail_mcs_1_concat-0',
        anim = 'csb_abigail_dual-0',
        flag = 1,
        scenario = 'WORLD_HUMAN_AA_COFFEE',
        target = {
            options = {
                {
                    event = "qb-rental:vehiclelist",
                    icon = "fas fa-circle",
                    label = "Louer un véhicule",
                },
                {
                    event = "qb-rental:returnvehicle",
                    icon = "fas fa-circle",
                    label = "Rendre le véhicule (Récupérer 50% du prix de la location)",
                },
            },
            distance = 3.5
        },
        spawnNow = true,
        currentpednumber = 0,
    })

end)

RegisterNetEvent("qb-rental:attemptvehiclespawn")
AddEventHandler("qb-rental:attemptvehiclespawn", function(vehicle)
    TriggerServerEvent("qb-rental:attemptPurchase", vehicle.id, vehicle.price)
end)

RegisterNetEvent("qb-rental:attemptvehiclespawnfail")
AddEventHandler("qb-rental:attemptvehiclespawnfail", function()
    QBCore.Functions.Notify("Pas assez d'argent.", "error")
end)

RegisterNetEvent("qb-rental:noDriverLicense")
AddEventHandler("qb-rental:noDriverLicense", function()
    QBCore.Functions.Notify("Vous n'avez pas la license nécéssaire pour pouvoir louer ce véhicule.", "error")
end)

RegisterNetEvent("qb-rental:giverentalpaperClient")
AddEventHandler("qb-rental:giverentalpaperClient", function(model, plate, name)

    local info = {
        data = "Model : " .. tostring(model) .. " | Plate : " .. tostring(plate) .. ""
    }
    TriggerServerEvent('QBCore:Server:AddItem', "rentalpapers", 1, info)
end)

RegisterNetEvent("qb-rental:returnvehicle")
AddEventHandler("qb-rental:returnvehicle", function()
    local car = GetVehiclePedIsIn(PlayerPedId(), true)
    if car ~= 0 then
        local plate = GetVehicleNumberPlateText(car)
        local vehname = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(car)))
        if string.find(tostring(plate), "NC") then
            QBCore.Functions.TriggerCallback('qb-rental:server:hasrentalpapers', function(HasItem)
                if HasItem then
                    TriggerServerEvent("QBCore:Server:RemoveItem", "rentalpapers", 1)
                    TriggerServerEvent('qb-rental:server:payreturn', vehname)
                    DeleteVehicle(car)
                    DeleteEntity(car)
                else
                    QBCore.Functions.Notify("Je ne peux pas prendre un véhicule sans ses papiers.", "error")
                end
            end)
        else
            QBCore.Functions.Notify("Ce n'est pas un véhicule loué.", "error")
        end
    else
        QBCore.Functions.Notify("Je ne vois aucun véhicule loué, assurez-vous qu'il se trouve à proximité.", "error")
    end
end)

RegisterNetEvent("qb-rental:vehiclespawn")
AddEventHandler("qb-rental:vehiclespawn", function(car, price, cb)
    local SpawnPoint = getVehicleSpawnPoint()
    if SpawnPoint then
        local coords = vector3(Config.spawns[SpawnPoint].x, Config.spawns[SpawnPoint].y, Config.spawns[SpawnPoint].z)
        local CanSpawn = IsSpawnPointClear(coords, 2.0)
        if CanSpawn then
            QBCore.Functions.SpawnVehicle(car, function(veh)
                SetVehicleNumberPlateText(veh, "NC" .. tostring(math.random(1000, 9999)))
                exports['LegacyFuel']:SetFuel(veh, 100.0)
                SetEntityHeading(veh, Config.spawns[SpawnPoint].w)
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                SetVehicleEngineOn(veh, true, true)
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                TriggerServerEvent("qb-rental:purchase", car, price)
            end, coords, true)
        else
            QBCore.Functions.Notify('Tous les emplacements de spawn sont en cours d\'utilisation', "error")
        end
    else
        QBCore.Functions.Notify('Tous les emplacements de spawn sont en cours d\'utilisation', 'error')
        return
    end
end)
