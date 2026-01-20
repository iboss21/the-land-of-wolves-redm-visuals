-- Client-side visual effects script
-- The Land of Wolves RedM Visuals

local visualConfig = {}
local visualsEnabled = false
local timecycleModifier = -1

-- Utility function for debug logging
local function DebugLog(message)
    if visualConfig.performance and visualConfig.performance.EnableDebug then
        print("^3[RedM Visuals Client]^7 " .. message)
    end
end

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
        DebugLog("Applied timecycle: " .. visualConfig.timecycle.Modifier)
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
        DebugLog("Applied weather: " .. visualConfig.weather.Type)
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
    
    DebugLog("Applied lighting enhancements")
end

-- Apply environmental effects
local function ApplyEnvironment()
    if not visualConfig.environment then
        return
    end
    
    -- These are visual quality settings
    if visualConfig.environment.EnhancedReflections then
        -- Enable better reflection quality
        SetTimecycleModifier("MP_Firefly_Main")
    end
    
    DebugLog("Applied environmental enhancements")
end

-- Main function to apply all visual effects
local function ApplyVisuals()
    if not visualsEnabled then
        return
    end
    
    DebugLog("Applying all visual effects...")
    
    ApplyTimecycle()
    ApplyWeather()
    ApplyLighting()
    ApplyEnvironment()
    
    DebugLog("All visual effects applied")
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
    
    DebugLog("Visual effects cleared")
end

-- Receive configuration from server
RegisterNetEvent('redm-visuals:receiveConfig')
AddEventHandler('redm-visuals:receiveConfig', function(config)
    visualConfig = config
    visualsEnabled = true
    
    DebugLog("Received visual configuration from server")
    
    -- Apply visuals after a small delay to ensure player is loaded
    Citizen.Wait(1000)
    ApplyVisuals()
    
    -- Notify server that player is loaded with visuals
    TriggerServerEvent('redm-visuals:playerLoaded')
end)

-- Reload visuals
RegisterNetEvent('redm-visuals:reload')
AddEventHandler('redm-visuals:reload', function()
    DebugLog("Reloading visuals...")
    ClearVisuals()
    Citizen.Wait(500)
    ApplyVisuals()
end)

-- Enable visuals
RegisterNetEvent('redm-visuals:enable')
AddEventHandler('redm-visuals:enable', function()
    visualsEnabled = true
    ApplyVisuals()
    DebugLog("Visuals enabled")
end)

-- Disable visuals
RegisterNetEvent('redm-visuals:disable')
AddEventHandler('redm-visuals:disable', function()
    visualsEnabled = false
    ClearVisuals()
    DebugLog("Visuals disabled")
end)

-- Request configuration when resource starts
Citizen.CreateThread(function()
    -- Wait for player to be fully loaded
    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(100)
    end
    
    -- Small delay to ensure everything is ready
    Citizen.Wait(1000)
    
    -- Request visual configuration from server
    TriggerServerEvent('redm-visuals:requestConfig')
    DebugLog("Requested visual configuration from server")
end)

-- Periodic update thread to maintain visual effects
Citizen.CreateThread(function()
    while true do
        local updateInterval = 1000
        
        if visualConfig.performance and visualConfig.performance.UpdateInterval then
            updateInterval = visualConfig.performance.UpdateInterval
        end
        
        Citizen.Wait(updateInterval)
        
        -- Reapply visuals if enabled (helps maintain consistency)
        if visualsEnabled then
            -- Only reapply timecycle strength, don't reset everything
            if visualConfig.timecycle and visualConfig.timecycle.Enabled and timecycleModifier ~= -1 then
                SetTimecycleModifierStrength(visualConfig.timecycle.Strength or 0.5)
            end
        end
    end
end)

-- Cleanup on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        ClearVisuals()
        DebugLog("Resource stopped, visuals cleared")
    end
end)
