local ESX = exports["es_extended"]:getSharedObject()

-- Tabuľka na ukladanie štatistík hráča
local playerStats = {}

-- Funkcia na získanie Discord ID hráča
local function GetDiscordId(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    for _, identifier in ipairs(identifiers) do
        if string.find(identifier, "discord:") then
            return identifier
        end
    end
    return "Discord ID nenájdené"
end

-- Danie itemov hráčovi
RegisterServerEvent('trashsearch:reward', function(binNetId)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then
        if Config.Debug then
            print("Hráč " .. src .. " neexistuje!")
        end
        return
    end

    local foundItems = {}
    local shuffledItems = Config.ItemsToFind
    -- Zamiešaj zoznam itemov
    for i = #shuffledItems, 2, -1 do
        local j = math.random(i)
        shuffledItems[i], shuffledItems[j] = shuffledItems[j], shuffledItems[i]
    end

    -- Skús nájsť jeden item na základe šance
    for _, itemData in ipairs(shuffledItems) do
        if math.random(100) <= itemData.chance then
            local amount = math.random(itemData.amount.min, itemData.amount.max)
            if itemData.item == 'cash' then
                xPlayer.addMoney(amount)
                TriggerClientEvent('esx:showNotification', src, "Našiel si ~g~$" .. amount .. "~s~!", "success")
                table.insert(foundItems, "$" .. amount)
                if Config.Debug then
                    print("Hráč " .. src .. " našiel hotovosť: $" .. amount)
                end
            else
                if xPlayer.canCarryItem(itemData.item, amount) then
                    xPlayer.addInventoryItem(itemData.item, amount)
                    local itemLabel = ESX.GetItemLabel(itemData.item)
                    TriggerClientEvent('esx:showNotification', src, "Našiel si ~b~" .. itemLabel .. "~s~ (" .. amount .. "x)!", "success")
                    table.insert(foundItems, itemLabel .. " (" .. amount .. "x)")
                    if Config.Debug then
                        print("Hráč " .. src .. " našiel item: " .. itemData.item .. " (" .. amount .. "x)")
                    end
                else
                    TriggerClientEvent('esx:showNotification', src, "~r~Nemáš dosť miesta v inventári!~s~", "error")
                end
            end
            break -- Prerušíme po nájdení prvého itemu
        end
    end

    -- Posielaj notifikáciu "Nič si nenašiel!" iba ak hráč naozaj nič nezískal
    if #foundItems == 0 then
        TriggerClientEvent('esx:showNotification', src, "Nič si nenašiel.", "info")
        table.insert(foundItems, "Nič")
        if Config.Debug then
            print("Hráč " .. src .. " nič nenašiel")
        end
    end

    -- Zaznamenaj štatistiky a pošli webhook
    local playerId = xPlayer.source
    if not playerStats[playerId] then
        playerStats[playerId] = { discordId = GetDiscordId(playerId), count = 0 }
    end
    playerStats[playerId].count = playerStats[playerId].count + 1

    local playerName = GetPlayerName(playerId)
    local discordId = playerStats[playerId].discordId
    local trashCount = playerStats[playerId].count
    
    if type(SendWebhook) == "function" then
        SendWebhook(playerName, discordId, trashCount, foundItems)
    elseif Config.Debug then
        print("Chyba: Funkcia SendWebhook nie je definovaná! Skontroluj, či je webhooks.lua správne načítaný.")
    end
end)

-- Mechanika porezania
RegisterServerEvent('trashsearch:cut', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then
        if Config.Debug then
            print("Hráč " .. src .. " neexistuje pri porezaní!")
        end
        return
    end
    ------ zniži HP hráčovy
    TriggerClientEvent('trashsearch:applyCutDamage', src)
end)