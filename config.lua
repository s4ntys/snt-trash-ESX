Config = {}

--- Debug Settings
Config.Debug = false -- Nastav na true pre debugovanie, false pre produkciu

-- Modely košov, ktoré môžu byť prehľadávané
Config.Trashcans = {
    'prop_bin_01a',
    'prop_bin_02a',
    'prop_dumpster_01a',
    'prop_dumpster_02a',
    'prop_dumpster_02b',
    'prop_dumpster_4a',
    'prop_dumpster_3a',
    'prop_cs_bin_02'
}

-- Možné itemy na nájdenie
Config.ItemsToFind = {
    { item = "water_bottle", amount = { min = 1, max = 3 }, chance = 50 },
    { item = "cash", amount = { min = 10, max = 155 }, chance = 90 },
}

-- Nastavenia minihry
Config.GridSize = { rows = 4, cols = 4 } -- 4x4 mriežka
Config.MaxAttempts = 5 -- Maximálny počet pokusov
Config.ItemSlots = 1 -- Počet slotov, ktoré obsahujú itemy
Config.CutSlots = 2 -- Počet slotov, ktoré spôsobia porezanie
Config.CutChance = 100 -- Šanca na porezanie pri kliknutí na "cut" slot (100% ak je slot označený ako cut)

-- Ostatné nastavenia
Config.MaxItemsPerSearch = 155 -- Maximálny počet itemov za jedno prehľadanie (pridané)
Config.CooldownTime = 10 --  sekundách
Config.SearchTime = 5 -- Čas progress baru v sekundách

-- Discord Webhook URL
Config.WebhookURL = "https://discord.com/api/webhooks/1386817790198943915/O4lkc8OfHW_pZDljpTHcZDFEI7XUpWbAt_Z1OTZ-v5BGTHgtdepsaDcW6K8wN2vIOPef" -- Nahraď za tvoj Discord webhook URL
Config.WebhookAvatar = "https://i.imgur.com/YourAvatar.png" -- Voliteľné: URL avatara pre webhook
Config.ServerName = "Central RP " -- Názov servera pre embed