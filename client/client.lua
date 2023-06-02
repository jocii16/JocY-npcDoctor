function pedspawn()
    for k, v in ipairs(Config.main) do
        lib.RequestModel(v.model)
        ped = CreatePed(0, v.model, v.coords, false, false)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end

function zone()
    for k, v in ipairs(Config.main) do
        local zone = lib.zones.sphere({
            coords = v.coords,
            radius = 2.5,
            debug = false,
            inside = function()
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
