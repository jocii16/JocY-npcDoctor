-- https://github.com/jocY16/ -- jocy5m.tebex.io -- https://discord.gg/3esH84B767

ESX.RegisterServerCallback('jocy-npcDoctor:server:checkmoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if Config.EnableBank == true then
        local bankamount = xPlayer.getAccount('bank').money
        if bankamount >= Config.amount then
            xPlayer.removeAccountMoney('bank', Config.amount)
            cb(true)
        else
            cb(false)
        end
    else
        local cashamount = exports.ox_inventory:Search(source, 'count', 'money')
        if cashamount >= Config.amount then
            exports.ox_inventory:RemoveItem(source, 'money', Config.amount)
            cb(true)
            
        else
            cb(false)
        end
    end
end)
