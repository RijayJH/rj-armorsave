local QBCore = exports['qb-core']:GetCoreObject()
local cid

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(2000)
    cid = QBCore.Functions.GetPlayerData().citizenid
    local armorcheck = lib.callback.await('rj-armorsave:server:GetArmor', false, cid)
    if armorcheck then
        SetPedArmour(PlayerPedId(), armorcheck)
    end
end)

AddEventHandler('onResourceStart', function(resource)
	if GetCurrentResourceName() == resource then
        cid = QBCore.Functions.GetPlayerData().citizenid
    end
end)

SetInterval(function()
    TriggerServerEvent('rj-armorsave:server:SetArmor', GetPedArmour(PlayerPedId()), cid)
end, 60000)

