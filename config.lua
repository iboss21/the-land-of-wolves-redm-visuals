Config = {}

-- Visual Settings
Config.EnableVisuals = true -- Master toggle for all visual enhancements

-- Timecycle Modifiers
Config.Timecycle = {
    Enabled = true,
    Modifier = "MP_Firefly_Main", -- Default timecycle modifier
    Strength = 0.5, -- Strength of the effect (0.0 - 1.0)
}

-- Weather Settings
Config.Weather = {
    Enabled = true,
    Type = "SUNNY", -- Default weather type
    -- Available: SUNNY, CLOUDS, OVERCAST, RAIN, FOG, SNOW, THUNDER, BLIZZARD
    TransitionTime = 45000, -- Weather transition time in ms
}

-- Lighting Settings
Config.Lighting = {
    Enabled = true,
    ExtraLights = true, -- Enable additional environmental lights
    ShadowQuality = 2, -- 0 = Low, 1 = Medium, 2 = High
}

-- Environmental Effects
Config.Environment = {
    EnhancedReflections = true,
    ImprovedShadows = true,
    BetterWaterQuality = true,
    EnhancedFoliage = true,
}

-- Performance Settings
Config.Performance = {
    UpdateInterval = 1000, -- How often to check/update visuals (ms)
    EnableDebug = false, -- Enable debug messages
}
