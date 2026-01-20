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
    
    CONFIGURATION FILE
    All visual settings are configurable here. Settings are parsed from professional
    visual mod files: visualsettings.dat, watertune.xml, terraintessellation.xml, treeinfo.xml
    
    Modify values below to customize The Land of Wolves visual experience.
    
    © 2026 iBoss | The Land of Wolves | www.wolves.land
    License: All Rights Reserved
]]

Config = {}

-- ═══════════════════════════════════════════════════════════════
-- MASTER SETTINGS
-- ═══════════════════════════════════════════════════════════════
Config.EnableVisuals = true -- Master toggle for all visual enhancements
Config.BrandName = "The Land of the Wolves" -- Resource branding

-- ═══════════════════════════════════════════════════════════════
-- TIMECYCLE MODIFIERS
-- ═══════════════════════════════════════════════════════════════
Config.Timecycle = {
    Enabled = true,
    Modifier = "MP_Firefly_Main", -- Default timecycle modifier
    Strength = 0.65, -- Strength of the effect (0.0 - 1.0)
    -- Popular RedM timecycle modifiers:
    -- "MP_Firefly_Main", "MP_Deathmatch_02", "MP_DeathFailOut",
    -- "MP_Character_Selection", "MP_Campfire_Warm", "MP_CoolWarm",
    -- "rdr_sunset_01", "rdr_dawn_01", "rdr_mp_deathmatch"
}

-- ═══════════════════════════════════════════════════════════════
-- WEATHER SYSTEM (Based on visualsettings.dat)
-- ═══════════════════════════════════════════════════════════════
Config.Weather = {
    Enabled = true,
    Type = "SUNNY", -- Default weather type
    -- Available: SUNNY, CLOUDS, OVERCAST, RAIN, FOG, SNOW, THUNDER, BLIZZARD,
    -- DRIZZLE, SLEET, WHITEOUT, HIGHPRESSURE, MISTY, OVERCASTDARK
    TransitionTime = 45000, -- Weather transition time in ms
    CycleDuration = 120, -- Weather cycle duration (from visualsettings.dat)
    
    -- Rain configuration (from visualsettings.dat)
    RainSettings = {
        NumberParticles = 98304,
        UseLitShader = true,
        FadeInScale = 2.0,
        Diffuse = 1.0,
        Ambient = 0.4,
    },
    
    -- Drying speed settings
    DryingSpeed = {
        AtMinTemp = 1.0,
        MinTemp = 10.0,
        AtMaxTemp = 1.0,
        MaxTemp = 50.0,
    },
}

-- ═══════════════════════════════════════════════════════════════
-- LIGHTING & SHADOWS
-- ═══════════════════════════════════════════════════════════════
Config.Lighting = {
    Enabled = true,
    ExtraLights = true, -- Enable additional environmental lights
    ShadowQuality = 2, -- 0 = Low, 1 = Medium, 2 = High
    
    -- Enhanced lighting settings
    AmbientLightMultiplier = 1.0,
    DirectionalLightMultiplier = 1.0,
    EmissiveMultiplier = 1.0,
}

-- ═══════════════════════════════════════════════════════════════
-- SKY & ATMOSPHERE (Based on visualsettings.dat)
-- ═══════════════════════════════════════════════════════════════
Config.Sky = {
    Enabled = true,
    SunIntensity = 100000.0,
    MoonIntensity = 1.0,
    AmbientMieG = 0.8,
    AtmosphereThickness = 8.0,
    AerialPerspectiveFarClip = 10000.0,
    
    -- Star configuration
    Stars = {
        Enabled = true,
        ConstellationSize = 0.32,
        ConstellationIntensity = 1.21,
        GalaxyIntensity = 1.45,
        Frequency = 2.0,
    },
}

-- ═══════════════════════════════════════════════════════════════
-- WATER EFFECTS (Based on watertune.xml)
-- ═══════════════════════════════════════════════════════════════
Config.Water = {
    Enabled = true,
    
    -- Visual water settings
    RippleSpeed = 4.5,
    FogPierceIntensity = 0.75,
    WaterCycleDepth = 8.0,
    WaterCycleFade = 625.0,
    
    -- Underwater settings
    Underwater = {
        ViewDistance = 10.0,
        FogBrightness = 2.0,
        CausticStrength = 1.0,
        CameraCausticStrength = 0.5,
    },
    
    -- Ocean foam
    OceanFoam = {
        DepthFadeRange = 1.0,
        DisturbFoamScale = 0.1,
    },
    
    -- Rain fade
    RainFade = {
        Min = 5.0,
        Max = 80.0,
    },
}

-- ═══════════════════════════════════════════════════════════════
-- TERRAIN TESSELLATION (Based on terraintessellation.xml)
-- ═══════════════════════════════════════════════════════════════
Config.Terrain = {
    Enabled = true,
    PixelsPerVertex = 1024, -- Higher = better quality, lower performance
    WorldTexelUnit = 1.0,
    
    -- Noise settings for terrain detail
    NearNoise = {
        X = 0.0,
        Y = 0.02,
    },
    FarNoise = {
        X = -0.05,
        Y = 0.05,
    },
    
    -- Tessellation envelope
    Envelope = {
        X = 4.0,
        Y = 5.0,
        Z = 100.0,
        W = 120.0,
    },
    
    UseNearWEnd = 40.0,
}

-- ═══════════════════════════════════════════════════════════════
-- VEGETATION & FOLIAGE (Based on treeinfo.xml)
-- ═══════════════════════════════════════════════════════════════
Config.Vegetation = {
    Enabled = true,
    
    -- Entity creation distances (affects render distance)
    TreeDistance = 96.0, -- Default tree entity creation distance
    BushDistance = 66.0, -- Bush render distance
    GrassDistance = 46.0, -- Grass/small plants distance
    DebrisDistance = 36.0, -- Debris and small objects
    
    -- Imposter settings
    ImposterResolution = "SIZE_1024x1024", -- SIZE_512x512, SIZE_1024x1024, SIZE_2048x2048
    ImposterMinDistance = 0.0,
    
    -- LOD settings
    SlodFadeIn = 0.0,
    SlodFadeOut = 0.0,
    
    -- Quality presets
    QualityPreset = "ULTRA", -- LOW, MEDIUM, HIGH, ULTRA
}

-- ═══════════════════════════════════════════════════════════════
-- ENVIRONMENTAL EFFECTS
-- ═══════════════════════════════════════════════════════════════
Config.Environment = {
    EnhancedReflections = true,
    ImprovedShadows = true,
    BetterWaterQuality = true,
    EnhancedFoliage = true,
    VolumetricLighting = true,
    GodRays = true,
    
    -- Distance fade settings
    DrawDistance = 1.0, -- Multiplier for draw distance (0.5 - 2.0)
    LodScale = 1.0, -- LOD quality scale (0.5 - 2.0)
}

-- ═══════════════════════════════════════════════════════════════
-- PERFORMANCE & OPTIMIZATION
-- ═══════════════════════════════════════════════════════════════
Config.Performance = {
    UpdateInterval = 10000, -- How often to check/update visuals (ms) - 10 seconds for 0.00ms performance
    EnableDebug = false, -- Enable debug messages
    
    -- Performance monitoring
    MonitorPerformance = false, -- Track FPS impact (adds minimal overhead when enabled)
    OptimizeForLowEnd = false, -- Auto-adjust settings for low-end PCs
}

-- ═══════════════════════════════════════════════════════════════
-- VISUAL PRESETS
-- ═══════════════════════════════════════════════════════════════
Config.Presets = {
    -- Available presets that can be loaded
    ["cinematic"] = {
        Description = "Cinematic visuals for screenshots and videos",
        Timecycle = { Enabled = true, Modifier = "MP_Firefly_Main", Strength = 0.8 },
        DrawDistance = 2.0,
        LodScale = 1.5,
    },
    ["performance"] = {
        Description = "Optimized for lower-end systems",
        Timecycle = { Enabled = true, Modifier = "MP_Firefly_Main", Strength = 0.3 },
        DrawDistance = 0.7,
        LodScale = 0.6,
    },
    ["realistic"] = {
        Description = "Balanced realistic visuals",
        Timecycle = { Enabled = true, Modifier = "rdr_sunset_01", Strength = 0.5 },
        DrawDistance = 1.0,
        LodScale = 1.0,
    },
}

Config.ActivePreset = nil -- Set to preset name to use, or nil for custom config
