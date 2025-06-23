local ESX = exports["es_extended"]:getSharedObject()
local isSearching = false
local currentBin = nil
local cooldowns = {}

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end)

-- Inicializácia - zabezpečíme, že UI je na štarte skryté
CreateThread(function()
    Wait(2000) -- Počkáme, kým sa načíta NUI
    for i = 1, 3 do
        SendNUIMessage({ action = "close" })
        SetNuiFocus(false, false)
        Wait(500)
    end
end)

-- Inicializácia ox_target pre koše
CreateThread(function()
    while not ESX do Wait(100) end

    exports.ox_target:addModel(Config.Trashcans, {
        {
            name = 'trash_search',
            icon = 'fas fa-trash',
            label = 'Prehľadať kôš',
            onSelect = function(data)
                TriggerEvent('trashsearch:start', data.entity)
            end
        }
    })
end)

-- Spustenie prehľadávania
RegisterNetEvent('trashsearch:start', function(entity)
    if isSearching then return end

    local netId = NetworkGetNetworkIdFromEntity(entity)
    if cooldowns[netId] and cooldowns[netId] > GetGameTimer() then
        ESX.ShowNotification("Tento kôš si nedávno prehľadal!", "error")
        return
    end

    currentBin = entity
    isSearching = true

    -- Uzamknutie inventára (ox_inventory)
    ---exports.ox_inventory:setStashOpen(true)

    -- Skryjeme UI pred začatím prehľadávania
    SendNUIMessage({ action = "close" })
    SetNuiFocus(false, false)

    -- Spustenie animácie a progress baru
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)

    -- Jednoduchý progress bar
    Wait(Config.SearchTime)
    ESX.ShowHelpNotification("", true) -- Skrytie notifikácie

    -- Inicializuj minihru
    local slots = {}
    local totalSlots = Config.GridSize.rows * Config.GridSize.cols
    local positions = {}

    for i = 1, totalSlots do
        table.insert(positions, i)
    end

    -- Zamiešaj pozície
    for i = #positions, 2, -1 do
        local j = math.random(i)
        positions[i], positions[j] = positions[j], positions[i]
    end

    -- Priraď itemy a zranenia
    local itemCount = 0
    local cutCount = 0
    for i = 1, totalSlots do
        if itemCount < Config.ItemSlots and i <= Config.ItemSlots then
            slots[positions[i]] = "item"
            itemCount = itemCount + 1
        elseif cutCount < Config.CutSlots and i <= (Config.ItemSlots + Config.CutSlots) then
            slots[positions[i]] = "cut"
            cutCount = cutCount + 1
        else
            slots[positions[i]] = "empty"
        end
    end

    -- Zobraz UI s minihrou
    SendNUIMessage({
        action = "open",
        slots = slots,
        maxAttempts = Config.MaxAttempts,
        rows = Config.GridSize.rows,
        cols = Config.GridSize.cols
    })
    SetNuiFocus(true, true)
end)

-- NUI Callback pre kliknutia na slot
RegisterNUICallback('clickSlot', function(data, cb)
    if not isSearching then
        cb('ok')
        return
    end

    local playerPed = PlayerPedId()
    local slotType = data.slotType

    if slotType == "item" then
        TriggerServerEvent('trashsearch:reward', NetworkGetNetworkIdFromEntity(currentBin))
    elseif slotType == "cut" then
        TriggerServerEvent('trashsearch:cut')
        ESX.ShowNotification("Porezal si sa, dávaj si pozor kam siahaš!", "error")
        StartScreenEffect("MP_DrugDrunk", 5000, false)
        Wait(5000)
        StopScreenEffect("MP_DrugDrunk")
    else
        ESX.ShowNotification("Nič si nenašiel!", "info")
    end

    cb('ok')
end)

-- Callback pre ukončenie minihry
RegisterNUICallback('endGame', function(data, cb)
    if isSearching then
        local netId = NetworkGetNetworkIdFromEntity(currentBin)
        cooldowns[netId] = GetGameTimer() + (Config.CooldownTime * 1000)
    end

    isSearching = false
    currentBin = nil
    ClearPedTasks(PlayerPedId())
    SendNUIMessage({ action = "close" })
    SetNuiFocus(false, false)
    exports.ox_inventory:setStashOpen(false) -- Odomknutie inventára
    cb('ok')
end)

-- Callback pre zatvorenie UI
RegisterNUICallback('close', function(data, cb)
    isSearching = false
    currentBin = nil
    ClearPedTasks(PlayerPedId())
    SetNuiFocus(false, false)
    exports.ox_inventory:setStashOpen(false) -- Odomknutie inventára
    cb('ok')
end)

-- Správa cooldownov
CreateThread(function()
    while true do
        Wait(1000)
        local currentTime = GetGameTimer()
        for netId, time in pairs(cooldowns) do
            if currentTime >= time then
                cooldowns[netId] = nil
            end
        end
    end
end)