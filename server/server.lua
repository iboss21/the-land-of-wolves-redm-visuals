--[[
    ████████╗██╗     ██╗    ██╗    ██╗   ██╗██╗███████╗██╗   ██╗ █████╗ ██╗     ███████╗
    ╚══██╔══╝██║     ██║    ██║    ██║   ██║██║██╔════╝██║   ██║██╔══██╗██║     ██╔════╝
       ██║   ██║     ██║ █╗ ██║    ██║   ██║██║███████╗██║   ██║███████║██║     ███████╗
       ██║   ██║     ██║███╗██║    ╚██╗ ██╔╝██║╚════██║██║   ██║██╔══██║██║     ╚════██║
       ██║   ███████╗╚███╔███╔╝     ╚████╔╝ ██║███████║╚██████╔╝██║  ██║███████╗███████║
       ╚═╝   ╚══════╝ ╚══╝╚══╝       ╚═══╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝
                                                                                          
    🐺 The Land of Wolves - RedM Visual Effects System
    "Professional Server-Side Visual Enhancement & Management"
    
    Version: 2.0.0
    Author: iBoss
    Website: www.wolves.land
    Server: The Land of Wolves
    
    A comprehensive server-side visual management system featuring:
    - Advanced timecycle modifiers with 15+ pre-configured filters
    - Dynamic weather system with 12+ weather types and smooth transitions
    - Enhanced lighting and shadow quality controls
    - Sky & atmosphere customization (sun, moon, stars, fog)
    - Water visual effects with underwater rendering
    - Terrain tessellation for enhanced ground detail
    - Vegetation management with LOD controls (trees, bushes, grass)
    - 3 visual presets: Cinematic, Performance, Realistic
    - Per-player visual preferences and performance monitoring
    - Real-time admin commands for live visual adjustments
    - Based on professional visual mod analysis (visualsettings.dat, watertune.xml, etc.)
    - Supreme configuration system - everything tweakable from config.lua
    
    © 2026 iBoss | The Land of Wolves | www.wolves.land
    License: All Rights Reserved
]]

local activeVisuals = {}
local playerPreferences = {} -- Store per-player visual preferences

-- ═══════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

local function DebugLog(message)
    if Config.Performance.EnableDebug then
        print("^3[" .. Config.BrandName .. " Visuals]^7 " .. message)
    end
end

-- Check for conflicting weather resources
local function CheckWeatherConflicts()
    if not Config.Weather.DisableOnConflict then
        return false
    end
    
    -- Use the configurable list from Config
    local conflictingResources = Config.Weather.ConflictingResources or {}
    
    for _, resourceName in ipairs(conflictingResources) do
        if GetResourceState(resourceName) == "started" or GetResourceState(resourceName) == "starting" then
            print("^3[" .. Config.BrandName .. " Visuals]^7 ^1WARNING:^7 Detected running weather resource: ^3" .. resourceName .. "^7")
            print("^3[" .. Config.BrandName .. " Visuals]^7 Weather control has been automatically disabled to prevent conflicts")
            print("^3[" .. Config.BrandName .. " Visuals]^7 To use this resource's weather system, stop the conflicting resource and set Config.Weather.Enabled = true")
            return true
        end
    end
    
    return false
end

local function PrintBanner()
    print("^2╔════════════════════════════════════════════════╗^7")
    print("^2║   " .. Config.BrandName .. "   ║^7")
    print("^2║      RedM Visual Effects System v2.0.0       ║^7")
    print("^2╠════════════════════════════════════════════════╣^7")
    print("^2║  ^7⚡ Enhanced Visual Management                ^2║^7")
    print("^2║  ^7🌊 Water & Weather Effects                  ^2║^7")
    print("^2║  ^7🌲 Vegetation & Terrain Control             ^2║^7")
    print("^2║  ^7🎨 Timecycle & Atmosphere Systems           ^2║^7")
    print("^2╚════════════════════════════════════════════════╝^7")
    
    if Config.ActivePreset then
        print("^6[Visuals]^7 Active Preset: ^3" .. Config.ActivePreset .. "^7")
    end
    
    -- Check for weather conflicts
    if CheckWeatherConflicts() then
        Config.Weather.Enabled = false
    end
    
    if Config.Weather.Enabled then
        print("^6[Visuals]^7 Weather Control: ^2Enabled^7")
    else
        print("^6[Visuals]^7 Weather Control: ^1Disabled^7 (External weather script detected or manually disabled)")
    end
    
    DebugLog("Visual system initialized successfully")
end

-- Apply preset to config
local function ApplyPreset(presetName)
    if not Config.Presets[presetName] then
        return false
    end
    
    local preset = Config.Presets[presetName]
    
    -- Apply preset settings to config
    if preset.Timecycle then
        for k, v in pairs(preset.Timecycle) do
            Config.Timecycle[k] = v
        end
    end
    
    if preset.DrawDistance then
        Config.Environment.DrawDistance = preset.DrawDistance
    end
    
    if preset.LodScale then
        Config.Environment.LodScale = preset.LodScale
    end
    
    Config.ActivePreset = presetName
    return true
end

-- Build visual configuration package for clients
local function BuildVisualConfig(source)
    local config = {
        brandName = Config.BrandName,
        timecycle = Config.Timecycle,
        weather = Config.Weather,
        lighting = Config.Lighting,
        sky = Config.Sky,
        water = Config.Water,
        terrain = Config.Terrain,
        vegetation = Config.Vegetation,
        environment = Config.Environment,
        performance = Config.Performance,
        activePreset = Config.ActivePreset,
    }
    
    -- Apply player-specific preferences if they exist
    if playerPreferences[source] then
        for category, settings in pairs(playerPreferences[source]) do
            if config[category] then
                for key, value in pairs(settings) do
                    config[category][key] = value
                end
            end
        end
    end
    
    return config
end

-- ═══════════════════════════════════════════════════════════════
-- EVENT HANDLERS
-- ═══════════════════════════════════════════════════════════════

-- Player connecting
AddEventHandler('playerConnecting', function()
    local source = source
    DebugLog("Player " .. source .. " connecting, preparing visual settings")
    
    -- Initialize player data
    playerPreferences[source] = {}
end)

-- Send visual configuration to player when they join
RegisterServerEvent('redm-visuals:requestConfig')
AddEventHandler('redm-visuals:requestConfig', function()
    local source = source
    
    if Config.EnableVisuals then
        DebugLog("Sending visual config to player " .. source)
        
        -- Build and send configuration package
        local visualConfig = BuildVisualConfig(source)
        TriggerClientEvent('redm-visuals:receiveConfig', source, visualConfig)
    else
        DebugLog("Visuals disabled, skipping config send to player " .. source)
    end
end)

-- Track active players with visuals
RegisterServerEvent('redm-visuals:playerLoaded')
AddEventHandler('redm-visuals:playerLoaded', function()
    local source = source
    activeVisuals[source] = {
        loaded = true,
        loadTime = os.time(),
        version = "2.0.0"
    }
    DebugLog("Player " .. source .. " loaded with visual enhancements")
end)

-- Player visual status report
RegisterServerEvent('redm-visuals:statusReport')
AddEventHandler('redm-visuals:statusReport', function(data)
    local source = source
    
    if activeVisuals[source] then
        activeVisuals[source].lastReport = os.time()
        activeVisuals[source].status = data
        
        if Config.Performance.MonitorPerformance then
            DebugLog("Player " .. source .. " FPS: " .. (data.fps or "N/A"))
        end
    end
end)

-- Player preference update
RegisterServerEvent('redm-visuals:updatePreference')
AddEventHandler('redm-visuals:updatePreference', function(category, key, value)
    local source = source
    
    if not playerPreferences[source] then
        playerPreferences[source] = {}
    end
    
    if not playerPreferences[source][category] then
        playerPreferences[source][category] = {}
    end
    
    playerPreferences[source][category][key] = value
    DebugLog("Player " .. source .. " updated preference: " .. category .. "." .. key)
end)

-- Cleanup on disconnect
AddEventHandler('playerDropped', function(reason)
    local source = source
    if activeVisuals[source] then
        activeVisuals[source] = nil
        DebugLog("Player " .. source .. " disconnected, cleaning up visual data")
    end
    
    if playerPreferences[source] then
        playerPreferences[source] = nil
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- ADMIN COMMANDS
-- ═══════════════════════════════════════════════════════════════

-- Reload visuals for all players
RegisterCommand('reloadvisuals', function(source, args, rawCommand)
    if source == 0 then -- Console only
        print("^2[" .. Config.BrandName .. " Visuals]^7 Reloading visual settings for all players...")
        TriggerClientEvent('redm-visuals:reload', -1)
        print("^2[" .. Config.BrandName .. " Visuals]^7 Visual settings reloaded!")
    end
end, true)

-- Toggle visuals on/off
RegisterCommand('togglevisuals', function(source, args, rawCommand)
    if source == 0 then -- Console only
        Config.EnableVisuals = not Config.EnableVisuals
        local status = Config.EnableVisuals and "^2enabled^7" or "^1disabled^7"
        print("^2[" .. Config.BrandName .. " Visuals]^7 Visuals " .. status)
        
        if Config.EnableVisuals then
            TriggerClientEvent('redm-visuals:enable', -1)
        else
            TriggerClientEvent('redm-visuals:disable', -1)
        end
    end
end, true)

-- Change visual preset
RegisterCommand('visualpreset', function(source, args, rawCommand)
    if source == 0 then -- Console only
        local presetName = args[1]
        
        if not presetName then
            print("^3[Visuals]^7 Available presets:")
            for name, preset in pairs(Config.Presets) do
                print("  ^6" .. name .. "^7 - " .. preset.Description)
            end
            return
        end
        
        if ApplyPreset(presetName) then
            print("^2[" .. Config.BrandName .. " Visuals]^7 Applied preset: ^3" .. presetName .. "^7")
            TriggerClientEvent('redm-visuals:reload', -1)
        else
            print("^1[" .. Config.BrandName .. " Visuals]^7 Preset not found: " .. presetName)
        end
    end
end, true)

-- Show visual status
RegisterCommand('visualstatus', function(source, args, rawCommand)
    if source == 0 then -- Console only
        print("^2[" .. Config.BrandName .. " Visuals]^7 Status Report:")
        print("  Visuals Enabled: " .. (Config.EnableVisuals and "^2Yes^7" or "^1No^7"))
        print("  Active Players: ^3" .. #GetPlayers() .. "^7")
        print("  Players with Visuals: ^3" .. (function()
            local count = 0
            for _ in pairs(activeVisuals) do count = count + 1 end
            return count
        end)() .. "^7")
        print("  Active Preset: ^6" .. (Config.ActivePreset or "Custom") .. "^7")
        print("  Timecycle: ^3" .. Config.Timecycle.Modifier .. "^7 (Strength: " .. Config.Timecycle.Strength .. ")")
        print("  Weather: ^3" .. Config.Weather.Type .. "^7")
    end
end, true)

-- Apply weather change to all players
RegisterCommand('setweather', function(source, args, rawCommand)
    if source == 0 then -- Console only
        if not Config.Weather.Enabled then
            print("^1[" .. Config.BrandName .. " Visuals]^7 Weather control is disabled!")
            print("^3[" .. Config.BrandName .. " Visuals]^7 This is likely because another weather resource is running.")
            print("^3[" .. Config.BrandName .. " Visuals]^7 To enable: Stop conflicting weather resources and set Config.Weather.Enabled = true")
            return
        end
        
        local weatherType = args[1]
        
        if not weatherType then
            print("^3[Visuals]^7 Usage: setweather <type>")
            print("^3[Visuals]^7 Available: SUNNY, CLOUDS, OVERCAST, RAIN, FOG, SNOW, THUNDER, BLIZZARD")
            return
        end
        
        Config.Weather.Type = weatherType:upper()
        print("^2[" .. Config.BrandName .. " Visuals]^7 Weather changed to: ^3" .. Config.Weather.Type .. "^7")
        TriggerClientEvent('redm-visuals:updateWeather', -1, Config.Weather.Type)
    end
end, true)

-- Change timecycle for all players
RegisterCommand('settimecycle', function(source, args, rawCommand)
    if source == 0 then -- Console only
        local modifier = args[1]
        local strength = tonumber(args[2]) or 0.5
        
        if not modifier then
            print("^3[Visuals]^7 Usage: settimecycle <modifier> [strength]")
            print("^3[Visuals]^7 Example: settimecycle MP_Firefly_Main 0.8")
            return
        end
        
        Config.Timecycle.Modifier = modifier
        Config.Timecycle.Strength = math.max(0.0, math.min(1.0, strength))
        
        print("^2[" .. Config.BrandName .. " Visuals]^7 Timecycle changed to: ^3" .. modifier .. "^7 (Strength: " .. Config.Timecycle.Strength .. ")")
        TriggerClientEvent('redm-visuals:updateTimecycle', -1, Config.Timecycle.Modifier, Config.Timecycle.Strength)
    end
end, true)

-- ═══════════════════════════════════════════════════════════════
-- INITIALIZATION
-- ═══════════════════════════════════════════════════════════════

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PrintBanner()
        
        -- Apply active preset if configured
        if Config.ActivePreset then
            ApplyPreset(Config.ActivePreset)
        end
    end
end)
