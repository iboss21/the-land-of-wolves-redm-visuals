-- Server-side visual management script
-- The Land of Wolves RedM Visuals

local activeVisuals = {}

-- Utility function for debug logging
local function DebugLog(message)
    if Config.Performance.EnableDebug then
        print("^3[RedM Visuals]^7 " .. message)
    end
end

-- Initialize visuals for all players
AddEventHandler('playerConnecting', function()
    local source = source
    DebugLog("Player " .. source .. " connecting, preparing visual settings")
end)

-- Send visual configuration to player when they join
RegisterServerEvent('redm-visuals:requestConfig')
AddEventHandler('redm-visuals:requestConfig', function()
    local source = source
    
    if Config.EnableVisuals then
        DebugLog("Sending visual config to player " .. source)
        
        -- Send configuration to client
        TriggerClientEvent('redm-visuals:receiveConfig', source, {
            timecycle = Config.Timecycle,
            weather = Config.Weather,
            lighting = Config.Lighting,
            environment = Config.Environment,
            performance = Config.Performance
        })
    else
        DebugLog("Visuals disabled, skipping config send to player " .. source)
    end
end)

-- Admin command to reload visuals for all players
RegisterCommand('reloadvisuals', function(source, args, rawCommand)
    if source == 0 then -- Console only
        print("^2[RedM Visuals]^7 Reloading visual settings for all players...")
        TriggerClientEvent('redm-visuals:reload', -1)
        print("^2[RedM Visuals]^7 Visual settings reloaded!")
    end
end, true)

-- Admin command to enable/disable visuals
RegisterCommand('togglevisuals', function(source, args, rawCommand)
    if source == 0 then -- Console only
        Config.EnableVisuals = not Config.EnableVisuals
        local status = Config.EnableVisuals and "enabled" or "disabled"
        print("^2[RedM Visuals]^7 Visuals " .. status)
        
        if Config.EnableVisuals then
            TriggerClientEvent('redm-visuals:enable', -1)
        else
            TriggerClientEvent('redm-visuals:disable', -1)
        end
    end
end, true)

-- Server started
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print("^2=================================^7")
        print("^2  The Land of Wolves RedM Visuals^7")
        print("^2  Server-side visuals loaded^7")
        print("^2  Version: 1.0.0^7")
        print("^2=================================^7")
        
        DebugLog("Visual system initialized")
    end
end)

-- Track active players with visuals
RegisterServerEvent('redm-visuals:playerLoaded')
AddEventHandler('redm-visuals:playerLoaded', function()
    local source = source
    activeVisuals[source] = true
    DebugLog("Player " .. source .. " loaded with visual enhancements")
end)

-- Cleanup on disconnect
AddEventHandler('playerDropped', function(reason)
    local source = source
    if activeVisuals[source] then
        activeVisuals[source] = nil
        DebugLog("Player " .. source .. " disconnected, cleaning up visual data")
    end
end)
