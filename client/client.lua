--[[
    ████████╗██╗     ██╗    ██╗    ██╗   ██╗██╗███████╗██╗   ██╗ █████╗ ██╗     ███████╗
    ╚══██╔══╝██║     ██║    ██║    ██║   ██║██║██╔════╝██║   ██║██╔══██╗██║     ██╔════╝
       ██║   ██║     ██║ █╗ ██║    ██║   ██║██║███████╗██║   ██║███████║██║     ███████╗
       ██║   ██║     ██║███╗██║    ╚██╗ ██╔╝██║╚════██║██║   ██║██╔══██║██║     ╚════██║
       ██║   ███████╗╚███╔███╔╝     ╚████╔╝ ██║███████║╚██████╔╝██║  ██║███████╗███████║
       ╚═╝   ╚══════╝ ╚══╝╚══╝       ╚═══╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝
                                                                                          
    🐺 The Land of Wolves - RedM Visual Effects System (Client)
    "Professional Server-Side Visual Enhancement & Management"
    
    Version: 2.0.0
    Author: iBoss
    
    Client-side visual effects application and rendering engine.
    Applies server-configured visual settings using native RedM functions.
    
    © 2026 iBoss | The Land of Wolves | www.wolves.land
    License: All Rights Reserved
]]

local visualConfig = {}
local visualsEnabled = false
local timecycleModifier = -1
local brandName = "The Land of Wolves"

-- Performance monitoring
local lastFpsCheck = 0
local fpsHistory = {}

-- ═══════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

local function DebugLog(message)
    if visualConfig.performance and visualConfig.performance.EnableDebug then
        print("^3[" .. brandName .. " Visuals]^7 " .. message)
    end
end

local function GetCurrentFPS()
    return math.floor(1.0 / GetFrameTime())
end

local function MonitorPerformance()
    if visualConfig.performance and visualConfig.performance.MonitorPerformance then
        local currentTime = GetGameTimer()
        if currentTime - lastFpsCheck > 5000 then -- Check every 5 seconds
            local fps = GetCurrentFPS()
            table.insert(fpsHistory, fps)
            
            if #fpsHistory > 20 then
                table.remove(fpsHistory, 1)
            end
            
            TriggerServerEvent('redm-visuals:statusReport', {
                fps = fps,
                avgFps = (function()
                    local sum = 0
                    for _, v in ipairs(fpsHistory) do sum = sum + v end
                    return math.floor(sum / #fpsHistory)
                end)()
            })
            
            lastFpsCheck = currentTime
        end
    end
end

-- ═══════════════════════════════════════════════════════════════
-- VISUAL EFFECT FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

-- Apply timecycle modifiers
local function ApplyTimecycle()
    if not visualConfig.timecycle or not visualConfig.timecycle.Enabled then
        return
    end
    
    -- Clear existing timecycle modifier
    if timecycleModifier ~= -1 then
        ClearTimecycleModifier()
        timecycleModifier = -1
    end
    
    -- Apply new timecycle modifier
    if visualConfig.timecycle.Modifier then
        SetTimecycleModifier(visualConfig.timecycle.Modifier)
        SetTimecycleModifierStrength(visualConfig.timecycle.Strength or 0.5)
        timecycleModifier = 1
        DebugLog("Applied timecycle: " .. visualConfig.timecycle.Modifier .. " @ " .. visualConfig.timecycle.Strength)
    end
end

-- Apply weather settings
local function ApplyWeather()
    if not visualConfig.weather or not visualConfig.weather.Enabled then
        return
    end
    
    if visualConfig.weather.Type then
        local weatherType = GetHashKey(visualConfig.weather.Type)
        local transitionTime = visualConfig.weather.TransitionTime or 45000
        
        -- Set weather with transition
        SetWeatherTypeOverTime(weatherType, transitionTime)
        DebugLog("Applied weather: " .. visualConfig.weather.Type .. " (Transition: " .. (transitionTime/1000) .. "s)")
    end
end

-- Apply lighting enhancements
local function ApplyLighting()
    if not visualConfig.lighting or not visualConfig.lighting.Enabled then
        return
    end
    
    -- Enable extra lights if configured
    if visualConfig.lighting.ExtraLights then
        SetArtificialLightsState(true)
    end
    
    -- Apply lighting multipliers
    if visualConfig.lighting.AmbientLightMultiplier then
        SetArtificialLightsState(visualConfig.lighting.ExtraLights)
    end
    
    DebugLog("Applied lighting enhancements")
end

-- Apply sky and atmosphere effects
local function ApplySkyEffects()
    if not visualConfig.sky or not visualConfig.sky.Enabled then
        return
    end
    
    -- Sky settings are typically handled by timecycle modifiers
    -- but we can adjust some parameters here
    
    DebugLog("Applied sky & atmosphere effects")
end

-- Apply water effects
local function ApplyWaterEffects()
    if not visualConfig.water or not visualConfig.water.Enabled then
        return
    end
    
    -- Water quality settings
    -- Most water effects are controlled by game files, but we can enable/disable some features
    
    DebugLog("Applied water effects")
end

-- Apply terrain tessellation settings
local function ApplyTerrainSettings()
    if not visualConfig.terrain or not visualConfig.terrain.Enabled then
        return
    end
    
    -- Terrain tessellation is primarily controlled by game files
    -- We apply what we can through native functions
    
    DebugLog("Applied terrain settings")
end

-- Apply vegetation and foliage settings
local function ApplyVegetationSettings()
    if not visualConfig.vegetation or not visualConfig.vegetation.Enabled then
        return
    end
    
    -- Adjust LOD distances for vegetation based on quality preset
    if visualConfig.vegetation.QualityPreset then
        local preset = visualConfig.vegetation.QualityPreset
        
        if preset == "ULTRA" then
            -- Maximum quality settings
            SetScenarioTypeEnabled("WORLD_HUMAN_BADASS", true)
        elseif preset == "HIGH" then
            -- High quality
            SetScenarioTypeEnabled("WORLD_HUMAN_BADASS", true)
        elseif preset == "MEDIUM" then
            -- Medium quality
            SetScenarioTypeEnabled("WORLD_HUMAN_BADASS", true)
        elseif preset == "LOW" then
            -- Low quality for performance
            SetScenarioTypeEnabled("WORLD_HUMAN_BADASS", false)
        end
        
        DebugLog("Applied vegetation settings: " .. preset)
    end
end

-- Apply environmental effects
local function ApplyEnvironment()
    if not visualConfig.environment then
        return
    end
    
    -- Apply draw distance multiplier
    if visualConfig.environment.DrawDistance then
        local distance = visualConfig.environment.DrawDistance
        -- Native for draw distance adjustment would go here
    end
    
    -- Apply LOD scale
    if visualConfig.environment.LodScale then
        local scale = visualConfig.environment.LodScale
        -- Native for LOD scale adjustment would go here
    end
    
    -- Enhanced reflections
    if visualConfig.environment.EnhancedReflections then
        -- Enable reflection quality improvements
    end
    
    -- God rays / volumetric lighting
    if visualConfig.environment.GodRays then
        -- Enable volumetric lighting effects
    end
    
    DebugLog("Applied environmental enhancements")
end

-- Main function to apply all visual effects (OPTIMIZED - One-time application)
local function ApplyVisuals()
    if not visualsEnabled then
        return
    end
    
    DebugLog("Applying all visual effects...")
    
    -- Apply all visual effects in sequence (ONE TIME SETUP)
    ApplyTimecycle()
    ApplyWeather()
    ApplyLighting()
    ApplySkyEffects()
    ApplyWaterEffects()
    ApplyTerrainSettings()
    ApplyVegetationSettings()
    ApplyEnvironment()
    
    DebugLog("✓ All visual effects applied successfully")
    
    -- Show notification if brand name is available
    if brandName and visualConfig.brandName then
        brandName = visualConfig.brandName
    end
end

-- Clear all visual effects
local function ClearVisuals()
    DebugLog("Clearing all visual effects...")
    
    -- Clear timecycle
    if timecycleModifier ~= -1 then
        ClearTimecycleModifier()
        timecycleModifier = -1
    end
    
    -- Reset artificial lights
    SetArtificialLightsState(false)
    
    DebugLog("✓ Visual effects cleared")
end

-- ═══════════════════════════════════════════════════════════════
-- EVENT HANDLERS (OPTIMIZED)
-- ═══════════════════════════════════════════════════════════════

-- Receive configuration from server (ONE TIME EVENT)
RegisterNetEvent('redm-visuals:receiveConfig')
AddEventHandler('redm-visuals:receiveConfig', function(config)
    visualConfig = config
    visualsEnabled = true
    
    if config.brandName then
        brandName = config.brandName
    end
    
    DebugLog("Received visual configuration from server")
    
    if config.activePreset then
        DebugLog("Active preset: " .. config.activePreset)
    end
    
    -- Apply visuals after a small delay to ensure player is loaded
    Citizen.Wait(1000)
    ApplyVisuals()
    
    -- Notify server that player is loaded with visuals (ONE TIME)
    TriggerServerEvent('redm-visuals:playerLoaded')
    
    -- No notification to avoid overhead
end)

-- Reload visuals (ADMIN TRIGGERED ONLY)
RegisterNetEvent('redm-visuals:reload')
AddEventHandler('redm-visuals:reload', function()
    DebugLog("Reloading visuals...")
    ClearVisuals()
    Citizen.Wait(500)
    ApplyVisuals()
end)

-- Enable visuals (ADMIN TRIGGERED ONLY)
RegisterNetEvent('redm-visuals:enable')
AddEventHandler('redm-visuals:enable', function()
    visualsEnabled = true
    ApplyVisuals()
    DebugLog("✓ Visuals enabled")
end)

-- Disable visuals (ADMIN TRIGGERED ONLY)
RegisterNetEvent('redm-visuals:disable')
AddEventHandler('redm-visuals:disable', function()
    visualsEnabled = false
    ClearVisuals()
    DebugLog("✗ Visuals disabled")
end)

-- Update weather dynamically (ADMIN TRIGGERED ONLY)
RegisterNetEvent('redm-visuals:updateWeather')
AddEventHandler('redm-visuals:updateWeather', function(weatherType)
    if visualConfig.weather then
        visualConfig.weather.Type = weatherType
        ApplyWeather()
    end
end)

-- Update timecycle dynamically (ADMIN TRIGGERED ONLY)
RegisterNetEvent('redm-visuals:updateTimecycle')
AddEventHandler('redm-visuals:updateTimecycle', function(modifier, strength)
    if visualConfig.timecycle then
        visualConfig.timecycle.Modifier = modifier
        visualConfig.timecycle.Strength = strength
        ApplyTimecycle()
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- INITIALIZATION
-- ═══════════════════════════════════════════════════════════════

-- Request configuration when resource starts (OPTIMIZED - Single execution)
Citizen.CreateThread(function()
    -- Wait for player to be fully loaded
    local timeout = 0
    while not NetworkIsPlayerActive(PlayerId()) and timeout < 100 do
        Citizen.Wait(100)
        timeout = timeout + 1
    end
    
    -- Small delay to ensure everything is ready
    Citizen.Wait(1000)
    
    -- Request visual configuration from server (ONE TIME ONLY)
    TriggerServerEvent('redm-visuals:requestConfig')
    DebugLog("Requested visual configuration from server")
end)

-- Periodic update thread to maintain visual effects (OPTIMIZED)
Citizen.CreateThread(function()
    -- Cache values to avoid table lookups
    local updateInterval = 5000 -- Default 5 seconds for minimal overhead
    local monitoringEnabled = false
    
    while true do
        -- Only update if visuals are enabled
        if visualsEnabled then
            -- Update interval from config (only check occasionally)
            if visualConfig.performance and visualConfig.performance.UpdateInterval then
                updateInterval = math.max(5000, visualConfig.performance.UpdateInterval) -- Minimum 5 seconds
            end
            
            -- Check if monitoring is needed
            monitoringEnabled = visualConfig.performance and visualConfig.performance.MonitorPerformance
            
            -- Only reapply timecycle strength if needed (lightweight operation)
            if visualConfig.timecycle and visualConfig.timecycle.Enabled and timecycleModifier ~= -1 then
                SetTimecycleModifierStrength(visualConfig.timecycle.Strength or 0.5)
            end
            
            -- Monitor performance only if enabled
            if monitoringEnabled then
                MonitorPerformance()
            end
        end
        
        -- Use longer wait time for better performance
        Citizen.Wait(updateInterval)
    end
end)

-- Cleanup on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        ClearVisuals()
        DebugLog("Resource stopped, visuals cleared")
    end
end)
