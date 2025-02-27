CreateThread(function()
    for k, v in pairs(Config.Crafting) do 
        -- Ped opsætning
        local modelHash = GetHashKey(v.ped.model)
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Wait(10)
        end

        local ped = CreatePed(4, modelHash, v.ped.location.x, v.ped.location.y, v.ped.location.z - 1.0, v.ped.location.w, false, true)
        SetEntityAsMissionEntity(ped, true, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedDiesWhenInjured(ped, false)
        SetPedCanPlayAmbientAnims(ped, true)
        SetPedCanRagdollFromPlayerImpact(ped, false)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)

        -- hvis emote er defineret
        if v.ped.emote ~= "" then
            TaskStartScenarioInPlace(ped, v.ped.emote, 0, true)
        end

        -- Target opsætning
        exports.ox_target:addLocalEntity(ped, {
            {
                label = "Åbn Crafting Menu",
                icon = "fa-solid fa-hammer",
                distance = 2.5,
                onSelect = function()
                    OpenCraftingMenu(v.items)
                end,
                canInteract = function(entity, distance, coords, name, bone)
                    return distance < 2.5
                end
            }
        })
    end
end)

function OpenCraftingMenu(items)
    local options = {}

    for _, item in ipairs(items) do
        local metadata = {}
        for _, req in ipairs(item.requiredItems) do
            table.insert(metadata, { label = req.label, value = req.amount })
        end

        table.insert(options, {
            title = item.title,
            description = item.description or nil,
            icon = item.icon or nil,
            image = item.image or nil,
            metadata = metadata,
            onSelect = function()
                local Crafted = lib.callback.await('pk-crafting:craftItem', false, item)
                
                if Crafted then
                    lib.notify({
                        description = "Du crafted " .. item.title,
                        type = "success"
                    })
                else
                    lib.notify({
                        description = "Du har ikke de nødvendige materialer!",
                        type = "error"
                    })
                end
            end
        })
    end

    lib.registerContext({
        id = "crafting_menu",
        title = "Crafting Menu",
        options = options
    })

    lib.showContext("crafting_menu")
end

RegisterNetEvent('pk-crafting:progressBar', function(data)
    lib.progressBar({
        duration = 5000,
        label = 'Crafter ' ..data.title,
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            dict = 'amb@prop_human_bbq@male@idle_a',
            clip = 'idle_b'
        },
    })
end)