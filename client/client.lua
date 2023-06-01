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
        debug = false,
        inside = function ()
            if GetEntityHealth(cache.ped) <= 0 then
               lib.showTextUI("Press [E] to interact") 
               if IsControlJustPressed(0, 38) then
                ESX.TriggerServerCallback('jocy-npcDoctor:server:checkmoney', function(have)
                    if have then
                    TriggerEvent('esx_ambulancejob:revive')
                    TriggerServerEvent("jocy-npcDoctor:server:money")
                    lib.notify({
                        title = 'Successful interaction',
                        description = 'You are revived!',
                        type = 'success',
                        position = 'top',
                        duration = 2000
                    })

                else
                    lib.notify({
                        title = 'Failed interaction',
                        description = 'You dont have enough money!',
                        type = 'error',
                        position = 'top',
                        duration = 2000
                    })

                    end
                end)
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
