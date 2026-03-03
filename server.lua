local ESX, QBCore

if Config.Framework == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == "qbcore" or Config.Framework == "qbox" then
    QBCore = exports['qb-core']:GetCoreObject()
end

local function GetCharacterId(source)
    if Config.Framework == "creative" then
        return vRP.Passport(source) or "N/A"
    end

    if Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer and xPlayer.identifier or "N/A"
    end

    if Config.Framework == "qbcore" or Config.Framework == "qbox" then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player and Player.PlayerData.citizenid or "N/A"
    end

    return "N/A"
end

local function GetIdentifiers(source)
    local ids = GetPlayerIdentifiers(source)
    local steam, license, discord

    for _, id in pairs(ids) do
        if id:find("steam:") then steam = id end
        if id:find("license:") then license = id end
        if id:find("discord:") then
            discord = "<@" .. id:gsub("discord:", "") .. ">"
        end
    end

    return steam or "N/A", license or "N/A", discord or "N/A"
end

local function SendDiscordLog(victimSource, attackerSource)
    if Config.DiscordWebhook == "" then return end

    local victimName = GetPlayerName(victimSource)
    local attackerName = GetPlayerName(attackerSource)

    local victimCharId = GetCharacterId(victimSource)
    local attackerCharId = GetCharacterId(attackerSource)

    local vSteam, vLicense, vDiscord = GetIdentifiers(victimSource)
    local aSteam, aLicense, aDiscord = GetIdentifiers(attackerSource)

    local embed = {
        {
            ["title"] = Config.LogTitle,
            ["color"] = Config.LogColor,
            ["fields"] = {
                {
                    ["name"] = "💀 VÍTIMA",
                    ["value"] =
                        "**Nome:** "..victimName..
                        "\n**ID Personagem:** "..victimCharId..
                        "\n**Steam:** "..vSteam..
                        "\n**License:** "..vLicense..
                        "\n**Discord:** "..vDiscord,
                    ["inline"] = false
                },
                {
                    ["name"] = "🔫 ASSASSINO",
                    ["value"] =
                        "**Nome:** "..attackerName..
                        "\n**ID Personagem:** "..attackerCharId..
                        "\n**Steam:** "..aSteam..
                        "\n**License:** "..aLicense..
                        "\n**Discord:** "..aDiscord,
                    ["inline"] = false
                }
            },
            ["footer"] = {
                ["text"] = os.date("%d/%m/%Y %H:%M:%S")
            }
        }
    }

    PerformHttpRequest(
        Config.DiscordWebhook,
        function() end,
        'POST',
        json.encode({
            username = "Sistema Morte Permanente",
            embeds = embed
        }),
        { ['Content-Type'] = 'application/json' }
    )
end

AddEventHandler('gameEventTriggered', function(name, args)
    if name ~= "CEventNetworkEntityDamage" then return end

    local victim = args[1]
    local attacker = args[2]
    local weaponHash = args[7]

    if not victim or not attacker then return end
    if not IsEntityAPed(victim) then return end

    local victimIndex = NetworkGetPlayerIndexFromPed(victim)
    local attackerIndex = NetworkGetPlayerIndexFromPed(attacker)

    if victimIndex == -1 or attackerIndex == -1 then return end

    local victimSource = GetPlayerServerId(victimIndex)
    local attackerSource = GetPlayerServerId(attackerIndex)

    if weaponHash == GetHashKey(Config.Weapon) then
        if GetEntityHealth(victim) <= 0 then
            SendDiscordLog(victimSource, attackerSource)
            Wait(Config.DelayBeforeKick)
            DropPlayer(victimSource, Config.KickMessage)
        end
    end
end)
