-- // notif kill \\ -- 
local QBCore = exports['qb-core']:GetCoreObject()

local function notifkill(message)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(0,1)
end
exports('notifkill', notifkill)

local function ShowAdvancedNotification(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
    if saveToBrief == nil then
        saveToBrief = true
    end
    AddTextEntry("esxAdvancedNotification", msg)
    BeginTextCommandThefeedPost("esxAdvancedNotification")
    if hudColorIndex then
        ThefeedSetNextPostBackgroundColor(hudColorIndex)
    end
    EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
    EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end
exports('ShowAdvancedNotification', ShowAdvancedNotification)

local function GetPedMugshot(ped, transparent)
    if not DoesEntityExist(ped) then
        return
    end
    local mugshot = transparent and RegisterPedheadshotTransparent(ped) or RegisterPedheadshot(ped)

    while not IsPedheadshotReady(mugshot) do
        Wait(0)
    end

    return mugshot, GetPedheadshotTxdString(mugshot)
end

RegisterNetEvent('shownotif', function(message)
    if PBData.InPB or LocalPlayer.state.inZonaRevolver then
        notifkill(message)
    end
end)

AddEventHandler('esx:onPlayerDeath',function(data)
    if data.killedByPlayer then
        if PBData.InPB or LocalPlayer.state.inZonaRevolver then
            local mugshot, mugshotStr = GetPedMugshot(GetPlayerPed(data.killerClientId))
            local namakiller = GetPlayerName(data.killerClientId)
            local idkiller = data.killerServerId
            local darahkiller = GetEntityHealth(GetPlayerPed(data.killerClientId))
            local armorkiller = GetPedArmour(GetPlayerPed(data.killerClientId)) 
            local senjatakiller = QBCore.Shared.Weapons[GetSelectedPedWeapon(GetPlayerPed(data.killerClientId))]
            local jarak = data.distance

            ShowAdvancedNotification('Sixnine Notifkill', '', 'Kamu Dibunuh Oleh ~r~' .. namakiller.. ' ~g~['..idkiller..']', mugshotStr, 0)
            notifkill('~r~Darah: ~w~'..darahkiller..' ~w~| ~b~Armor ~w~: '..armorkiller..' | Jarak: ' .. jarak.. ' Meter~w~ | ~r~Weapon: ~y~' .. senjatakiller.label)
            UnregisterPedheadshot(mugshot)
        end
    end
end)