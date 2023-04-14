local QBCore = exports['qb-core']:GetCoreObject()
local AllArmours = {}
local cids = {}


AddEventHandler('onResourceStart', function(resource)
	if GetCurrentResourceName() == resource then
        AllArmours = json.decode(LoadResourceFile(GetCurrentResourceName(), 'armors.json'))
    end
end)

lib.callback.register('rj-armorsave:server:GetArmor', function(source, citizenid)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for i, v in pairs(AllArmours) do
        if v.cid == citizenid then
            return v.armour
        end
    end
    return false
end)

RegisterNetEvent('rj-armorsave:server:SetArmor', function(Armor, citizenid)
    local isthere = false
    for i, v in pairs(AllArmours) do
        if v.cid == citizenid then
            isthere = true
            v.armour = Armor
        end
    end
    if not isthere then
        AllArmours[#AllArmours + 1] = {cid = citizenid, armour = Armor}
    end
end)

RegisterCommand('testarmorcommand', function()
    print(json.encode(AllArmours))
end)

function StoreArmorsTable()
    SaveResourceFile(GetCurrentResourceName(), "armors.json", json.encode(AllArmours), -1)
end

AddEventHandler('txAdmin:events:serverShuttingDown', function()
    StoreArmorsTable()
end)

AddEventHandler('onResourceStop', function(resource)
	if GetCurrentResourceName() == resource then
        StoreArmorsTable()
    end
end)

SetInterval(function()
    StoreArmorsTable()
end, 3600000)
