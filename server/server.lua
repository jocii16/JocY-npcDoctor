-- print("Köszi, hogy használod a scriptem")

-- RegisterNetEvent("jocy-npcDoctor:server:money", function ()
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if Config.bank == true then
--         xPlayer.removeAccountMoney('bank', Config.amount)
--     else
--         exports.ox_inventory:RemoveItem(source, 'money', Config.amount)
--     end
-- end)

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


