RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    data.victim = source
    if not data.killerServerId then return end

    if data.killedByPlayer then
        TriggerClientEvent('shownotif', data.killerServerId, 'Kamu membunuh ~r~' ..GetPlayerName(data.victim) ..' ~g~[' ..data.victim.. ']')
    end
end)