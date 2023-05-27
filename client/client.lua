function pedspawn()
    lib.RequestModel(Config.ped.model)
    ped = CreatePed(0, Config.ped.model, Config.ped.coords, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true) 
end

function zone()
    local zone = lib.zones.sphere({
        coords = Config.ped.zone,
        radius = 2.5,
        debug = Config.debug,
        inside = function ()
            if GetEntityHealth(cache.ped) <= 0 then
               lib.showTextUI("Nyomd meg az [E] gombot az újraéledéshez") 
               if IsControlJustPressed(0, 38) then
                local money = exports.ox_inventory:Search("count", "money")
                if money >= Config.amount then
                    TriggerEvent('esx_ambulancejob:revive')
                    TriggerServerEvent("money")
                    lib.notify({
                        title = 'Sikeres interakció',
                        description = 'Újraéledtél  \nA pénz levonásra került!',
                        type = 'inform',
                        position = "top",
                        duration = 2000
                    })
                else
                    lib.notify({
                        title = 'Sikertelen interakció',
                        description = 'Nincs elég pénzed!',
                        type = 'error',
                        position = "top",
                        duration = 2000
                    })
                end
               end
            else
                lib.hideTextUI()
            end
        end,
    })
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    zone()
    pedspawn()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    zone()
    pedspawn()
end)