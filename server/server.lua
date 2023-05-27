RegisterNetEvent("money", function ()
    exports.ox_inventory:RemoveItem(source, 'money', Config.amount)
end)