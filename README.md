# EN- ESX Container Search Script (Trash Search)

![Framework](https://img.shields.io/badge/Framework-ESX-blue.svg)
![Status](https://img.shields.io/badge/Status-Functional-brightgreen.svg)

An advanced script for the ESX framework that allows players to search through trash cans and dumpsters. It includes a unique minigame for randomly finding items, a chance of getting injured, and detailed logging via Discord webhooks.

This script is a conversion from a QBCore version, fully adapted for ESX, `ox_target`, and `ox_inventory`.

## 🎥 Preview

- https://www.tiktok.com/@prostesanty/video/7519269867745348866


## ✨ Features

-   **Targeting via `ox_target`**: A modern and optimized targeting system for containers.
-   **Interactive Minigame**: Upon starting a search, a NUI minigame (4x4 grid) is displayed where the player searches for items.
-   **Randomized Rewards**: A fully configurable loot table with individual chances for each item.
-   **Risk System**: Players can get cut while searching and lose a portion of their health.
-   **Cooldown System**: Each container has its own cooldown to prevent farming.
-   **Inventory Lock**: During the search, the player's access to `ox_inventory` is blocked to prevent glitches.
-   **Discord Logs**: Detailed logs about which player searched a container and what they found are sent via webhook.
-   **Easy Configuration**: Most settings can be easily adjusted in `config.lua`.

## (Dependencies)

Before running this script, ensure you have the following resources installed and running:

-   [**ESX Framework (es_extended)**](https://github.com/esx-framework/es_extended)
-   [**ox_inventory**](https://github.com/overextended/ox_inventory)
-   [**ox_target**](https://github.com/overextended/ox_target)

## 🔧 Installation

1.  Download the script files.
2.  Place the script folder (e.g., `snt-trash`) into your `resources` directory.
3.  **IMPORTANT:** Open `config.lua` and verify that the item names in `Config.ItemsToFind` match the item names in your database.
4.  In `config.lua`, set your Discord webhook URL in the `Config.WebhookURL` field.
5.  Add `ensure snt-trash` (or your folder name) to your `server.cfg` file.
6.  Restart your server or load the script.

## ⚙️ Configuration

All major settings can be found in the `config.lua` file.

| Setting               | Description                                                                    |
| --------------------- | ------------------------------------------------------------------------------ |
| `Config.Trashcans`    | A list of container models that will be targetable.                            |
| `Config.ItemsToFind`  | The loot table. For each item, you can define its name, amount, and find chance. |
| `Config.GridSize`     | The size of the minigame grid (e.g., `{ rows = 4, cols = 4 }`).                  |
| `Config.MaxAttempts`  | The maximum number of clicks allowed in the minigame.                          |
| `Config.ItemSlots`    | The number of slots in the grid that will contain a reward.                    |
| `Config.CutSlots`     | The number of slots that will cause injury.                                    |
| `Config.CooldownTime` | The time in seconds before the same container can be searched again.           |
| `Config.SearchTime`   | The duration of the search in milliseconds before the minigame appears.        |
| `Config.WebhookURL`   | The URL for the Discord webhook to log findings.                               |

## 📄 License

This project is released under the MIT License. See the LICENSE file for more details.

## 🙏 Credits

-   **SanTy** - Original author of the QBCore script.


# CZ/SK ESX Skript na Prehľadávanie Kontajnerov (Trash Search)

![Framework](https://img.shields.io/badge/Rámec-ESX-blue.svg)
![Stav](https://img.shields.io/badge/Stav-Funkčný-brightgreen.svg)

Pokročilý skript pre ESX framework, ktorý hráčom umožňuje prehľadávať smetné koše a kontajnery. Obsahuje unikátnu minihru pre náhodné hľadanie predmetov, možnosť porezania a detailné logovanie cez Discord webhook.

Skript je konverziou z QBCore s kompletným prispôsobením pre ESX, `ox_target` a `ox_inventory`.

## 🎥 Ukážka

*Na tomto tiktoku - https://www.tiktok.com/@prostesanty/video/7519269867745348866*


## ✨ Vlastnosti

-   **Cielenie cez `ox_target`**: Moderný a optimalizovaný systém cielenia na kontajnery.
-   **Interaktívna Minihra**: Po spustení hľadania sa zobrazí NUI minihra (mriežka 4x4), kde hráč hľadá predmety.
-   **Náhodné Odmeny**: Plne konfigurovateľný zoznam predmetov s individuálnou šancou na nájdenie.
-   **Systém Rizika**: Hráč sa môže pri hľadaní porezať a stratiť časť zdravia.
-   **Cooldown Systém**: Každý kontajner má vlastný cooldown, aby sa zabránilo farmeniu.
-   **Blokovanie Inventára**: Počas prehľadávania je hráčovi zablokovaný prístup do `ox_inventory`, aby sa predišlo chybám.
-   **Discord Logy**: Detailné záznamy o tom, ktorý hráč prehľadal kôš a čo našiel, odosielané cez webhook.
-   **Jednoduchá Konfigurácia**: Väčšina nastavení sa dá ľahko upraviť v `config.lua`.

## Čo na to potrebuješ?

Pred spustením tohto skriptu sa uistite, že máte nainštalované a funkčné nasledujúce zdroje:

-   [**ESX Framework (es_extended)**](https://github.com/esx-framework/es_extended)
-   [**ox_inventory**](https://github.com/overextended/ox_inventory)
-   [**ox_target**](https://github.com/overextended/ox_target)

## 🔧 Inštalácia

1.  Stiahnite si súbory skriptu.
2.  Vložte priečinok `snt-trash` (alebo iný názov) do vašej zložky `resources`.
3.  **DÔLEŽITÉ:** Otvorte `config.lua` a skontrolujte, či sa názvy predmetov v `Config.ItemsToFind` zhodujú s názvami predmetov vo vašej databáze.
4.  V `config.lua` nastavte URL vášho Discord webhooku v `Config.WebhookURL`.
5.  Pridajte `ensure snt-trash` do vášho súboru `server.cfg`.
6.  Reštartujte server alebo načítajte skript.

## ⚙️ Konfigurácia

Všetky hlavné nastavenia nájdete v súbore `config.lua`.

| Nastavenie            | Popis                                                                          |
| --------------------- | ------------------------------------------------------------------------------ |
| `Config.Trashcans`    | Zoznam modelov kontajnerov, ktoré budú cieľiteľné.                              |
| `Config.ItemsToFind`  | Tabuľka s predmetmi. Pre každý predmet môžete nastaviť názov, množstvo a šancu.   |
| `Config.GridSize`     | Veľkosť mriežky v minihre (napr. `{ rows = 4, cols = 4 }`).                     |
| `Config.MaxAttempts`  | Maximálny počet kliknutí v minihre.                                            |
| `Config.ItemSlots`    | Počet políčok v mriežke, ktoré budú obsahovať odmenu.                          |
| `Config.CutSlots`     | Počet políčok, ktoré spôsobia zranenie.                                        |
| `Config.CooldownTime` | Čas v sekundách, po ktorom je možné opäť prehľadať ten istý kontajner.           |
| `Config.SearchTime`   | Dĺžka prehľadávania v milisekundách pred zobrazením minihry.                    |
| `Config.WebhookURL`   | URL adresa pre Discord webhook na logovanie nálezov.                           |

## 📄 Licencia

Tento projekt je vydaný pod licenciou MIT. Viac informácií nájdete v súbore LICENSE.

## 🙏 Poďakovanie

-   **SanTy** - Pôvodný autor skriptu pre QBCore.
