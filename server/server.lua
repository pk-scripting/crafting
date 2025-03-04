lib.callback.register('pk-crafting:craftItem', function(source, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventory = exports.ox_inventory:GetInventory(source, false)
    local hasAllItems = true
    local confirmed = false

    for _, requiredItem in ipairs(item.requiredItems) do
        local playerItemCount = 0

        for _, playerItem in pairs(inventory.items) do
            if playerItem.name == requiredItem.item then
                playerItemCount = playerItemCount + playerItem.count
            end
        end

        if playerItemCount < requiredItem.amount then
            hasAllItems = false
            break
        end
    end

    if hasAllItems then
        TriggerClientEvent('pk-crafting:progressBar', source, item)
        Wait(5000)
        
        for _, requiredItem in ipairs(item.requiredItems) do
            exports.ox_inventory:RemoveItem(source, requiredItem.item, requiredItem.amount)
        end

        for _, rewardItem in ipairs(item.reward) do
            exports.ox_inventory:AddItem(source, rewardItem.item, rewardItem.amount)
        end
        
        return true
    else
        return false
    end
end)
