# The Land of the Wolves - Visual Effects System Usage Guide

```
╔════════════════════════════════════════════════╗
║     THE LAND OF THE WOLVES                   ║
║  Visual Effects System - Usage Guide         ║
╚════════════════════════════════════════════════╝
```

## Quick Start

### 1. Basic Setup
```bash
# In your server.cfg
ensure the-land-of-wolves-redm-visuals
```

### 2. First Configuration
Open `config.lua` and set:
```lua
Config.EnableVisuals = true
Config.BrandName = "Your Server Name" -- Optional: customize branding
```

### 3. Choose a Preset (Optional)
```lua
Config.ActivePreset = "realistic" -- Options: cinematic, performance, realistic, or nil
```

### 4. Start Your Server
The visual system will automatically:
- Load and parse all configuration
- Apply visual effects to connecting players
- Display a branded startup banner

## Understanding Visual Settings

### Configuration File Structure

The configuration is organized into logical sections based on the analyzed visual mod files:

```
config.lua
├── Master Settings (Enable/disable, branding)
├── Timecycle Modifiers (Color grading, filters)
├── Weather System (Weather types, rain settings)
├── Lighting & Shadows (Light quality, multipliers)
├── Sky & Atmosphere (Sun, moon, stars, fog)
├── Water Effects (Underwater, waves, foam)
├── Terrain Tessellation (Ground detail)
├── Vegetation Management (Trees, bushes, grass)
├── Environmental Effects (Draw distance, LOD)
├── Performance Settings (Optimization, debug)
└── Visual Presets (Quick configurations)
```

## Configuration Deep Dive

### Timecycle Modifiers

**What they do:** Control the overall color grading and atmospheric look of the game.

**Configuration:**
```lua
Config.Timecycle = {
    Enabled = true,
    Modifier = "MP_Firefly_Main",
    Strength = 0.65,
}
```

**Popular Modifiers:**
- `MP_Firefly_Main` - Warm, cinematic (recommended)
- `MP_Deathmatch_02` - High contrast, dramatic
- `rdr_sunset_01` - Beautiful sunset colors
- `rdr_dawn_01` - Morning atmosphere
- `MP_Campfire_Warm` - Cozy, warm tones
- `MP_CoolWarm` - Balanced cool/warm

**Strength Guide:**
- `0.0 - 0.3` - Subtle effect
- `0.4 - 0.6` - Moderate effect (recommended)
- `0.7 - 0.9` - Strong effect
- `1.0` - Maximum intensity

### Weather System

**Based on:** `visualsettings.dat` analysis

**Configuration:**
```lua
Config.Weather = {
    Enabled = true,
    Type = "SUNNY",
    TransitionTime = 45000, -- 45 seconds
    CycleDuration = 120, -- 2 minutes
}
```

**Available Weather Types:**
- `SUNNY` - Clear skies
- `CLOUDS` - Partly cloudy
- `OVERCAST` - Fully cloudy
- `RAIN` - Rain with particle effects
- `FOG` - Heavy fog
- `SNOW` - Snowfall
- `THUNDER` - Thunderstorm
- `BLIZZARD` - Heavy snow
- `DRIZZLE` - Light rain
- `MISTY` - Light fog
- `OVERCASTDARK` - Dark clouds

**Dynamic Commands:**
```bash
# Change weather instantly
setweather RAIN

# Set with custom transition
setweather THUNDER
```

### Sky & Atmosphere

**Based on:** `visualsettings.dat` star and sky configuration

**Configuration:**
```lua
Config.Sky = {
    Enabled = true,
    SunIntensity = 100000.0,
    MoonIntensity = 1.0,
    AtmosphereThickness = 8.0,
    
    Stars = {
        Enabled = true,
        ConstellationIntensity = 1.21,
        GalaxyIntensity = 1.45,
    },
}
```

**Tips:**
- Increase `SunIntensity` for brighter days
- Adjust `AtmosphereThickness` for haze effects
- Toggle `Stars.Enabled` for night sky quality

### Water Effects

**Based on:** `watertune.xml` configuration

**Configuration:**
```lua
Config.Water = {
    Enabled = true,
    RippleSpeed = 4.5,
    FogPierceIntensity = 0.75,
    
    Underwater = {
        ViewDistance = 10.0,
        FogBrightness = 2.0,
        CausticStrength = 1.0, -- Underwater light rays
    },
}
```

**What each setting does:**
- `RippleSpeed` - How fast water ripples move
- `FogPierceIntensity` - How fog interacts with water
- `Underwater.ViewDistance` - How far you can see underwater
- `CausticStrength` - Intensity of underwater light patterns

### Terrain Tessellation

**Based on:** `terraintessellation.xml` parameters

**Configuration:**
```lua
Config.Terrain = {
    Enabled = true,
    PixelsPerVertex = 1024,
    WorldTexelUnit = 1.0,
    UseNearWEnd = 40.0,
}
```

**Performance Impact:**
- `PixelsPerVertex = 512` - Low quality, best performance
- `PixelsPerVertex = 1024` - Medium quality (default)
- `PixelsPerVertex = 2048` - High quality, performance cost

### Vegetation Control

**Based on:** `treeinfo.xml` entity distances

**Configuration:**
```lua
Config.Vegetation = {
    Enabled = true,
    TreeDistance = 96.0,
    BushDistance = 66.0,
    GrassDistance = 46.0,
    QualityPreset = "ULTRA",
}
```

**Quality Presets:**
- `LOW` - Reduced distances for low-end PCs
- `MEDIUM` - Balanced performance
- `HIGH` - Enhanced visuals
- `ULTRA` - Maximum quality (default)

**Distance Guide:**
- Higher values = See vegetation from farther away
- Lower values = Better performance
- Grass has the biggest performance impact

## Visual Presets

### What are Presets?

Presets are pre-configured visual settings for specific use cases.

### Available Presets

#### 1. Cinematic
**Use for:** Screenshots, videos, roleplay sessions
```lua
Config.ActivePreset = "cinematic"
```
- Maximum visual quality
- Increased draw distance (2.0x)
- Enhanced LOD quality (1.5x)
- Strong timecycle effects

#### 2. Performance
**Use for:** Low-end systems, large player counts
```lua
Config.ActivePreset = "performance"
```
- Optimized for FPS
- Reduced draw distance (0.7x)
- Reduced LOD quality (0.6x)
- Subtle visual effects

#### 3. Realistic
**Use for:** Balanced gameplay
```lua
Config.ActivePreset = "realistic"
```
- Balanced settings
- Normal draw distance (1.0x)
- Normal LOD quality (1.0x)
- Moderate visual effects

### Creating Custom Presets

Add to `config.lua`:
```lua
Config.Presets["myserver"] = {
    Description = "My Server's Custom Look",
    Timecycle = { 
        Enabled = true, 
        Modifier = "rdr_sunset_01", 
        Strength = 0.7 
    },
    DrawDistance = 1.3,
    LodScale = 1.2,
}

-- Activate it
Config.ActivePreset = "myserver"
```

### Switching Presets In-Game

```bash
# Server console
visualpreset cinematic
visualpreset performance
visualpreset realistic
visualpreset myserver

# List all presets
visualpreset
```

## Admin Commands Reference

### Core Management

```bash
# Show current status
visualstatus

# Reload all visual settings
reloadvisuals

# Enable/disable visuals globally
togglevisuals
```

### Dynamic Configuration

```bash
# Change weather
setweather <TYPE>
# Examples:
setweather RAIN
setweather FOG
setweather SUNNY

# Change timecycle
settimecycle <MODIFIER> [strength]
# Examples:
settimecycle MP_Firefly_Main 0.8
settimecycle rdr_sunset_01 0.6

# Apply preset
visualpreset <name>
# Examples:
visualpreset cinematic
visualpreset performance
```

## Performance Optimization

### Step 1: Enable Monitoring
```lua
Config.Performance = {
    MonitorPerformance = true,
    OptimizeForLowEnd = false,
    EnableDebug = true, -- For troubleshooting
}
```

### Step 2: Check Server Console
Look for FPS reports and performance warnings.

### Step 3: Optimize Settings

**If players report low FPS:**

1. **Switch to performance preset:**
   ```bash
   visualpreset performance
   ```

2. **Or manually adjust:**
   ```lua
   Config.Vegetation.QualityPreset = "MEDIUM" -- or "LOW"
   Config.Environment.DrawDistance = 0.8
   Config.Environment.LodScale = 0.7
   Config.Timecycle.Strength = 0.3 -- Lower intensity
   ```

3. **Disable heavy features:**
   ```lua
   Config.Sky.Stars.Enabled = false
   Config.Water.Enabled = false -- If water isn't important
   Config.Terrain.Enabled = false
   ```

### Step 4: Enable Auto-Optimization
```lua
Config.Performance.OptimizeForLowEnd = true
```

The system will automatically reduce settings for players with low FPS.

## Troubleshooting

### Problem: Visuals not showing

**Check:**
1. Is the resource started? Look for the banner in console
2. Is `Config.EnableVisuals = true`?
3. Are there errors in F8 console (client)?
4. Try `reloadvisuals` command

**Solution:**
```bash
# Server console
refresh
ensure the-land-of-wolves-redm-visuals
reloadvisuals
```

### Problem: Weather not changing

**Check:**
1. Is `Config.Weather.Enabled = true`?
2. Did you spell the weather type correctly?

**Solution:**
```bash
setweather SUNNY
# Wait for transition time (default 45 seconds)
```

### Problem: Poor performance

**Check:**
1. Current FPS (F8 console: type `cl_drawfps 1`)
2. Player count and server specs

**Solution:**
```bash
visualpreset performance
```

Or disable specific features in config.

### Problem: Colors look wrong

**Check:**
1. Timecycle modifier and strength
2. Active preset

**Solution:**
```bash
# Try different modifiers
settimecycle MP_Firefly_Main 0.5
settimecycle rdr_sunset_01 0.6

# Or disable timecycle
```
Set `Config.Timecycle.Enabled = false` in config

### Problem: Debug messages flooding console

**Solution:**
```lua
Config.Performance.EnableDebug = false
```

## Advanced Tips

### Seasonal Configurations

Create seasonal visual setups:

```lua
-- Winter
Config.Weather.Type = "SNOW"
Config.Timecycle.Modifier = "MP_CoolWarm"
Config.Timecycle.Strength = 0.5

-- Summer
Config.Weather.Type = "SUNNY"
Config.Timecycle.Modifier = "MP_Firefly_Main"
Config.Timecycle.Strength = 0.7

-- Autumn
Config.Weather.Type = "OVERCAST"
Config.Timecycle.Modifier = "rdr_sunset_01"
Config.Timecycle.Strength = 0.6
```

### Time-of-Day Adjustments

The timecycle system automatically adapts to time of day. Adjust strength for different effects at different times.

### Event-Specific Visuals

For special events, create temporary presets:

```lua
Config.Presets["halloween"] = {
    Description = "Spooky atmosphere for Halloween",
    Timecycle = { 
        Modifier = "MP_DeathFailOut", 
        Strength = 0.8 
    },
    Weather = { Type = "FOG" },
}
```

Activate with: `visualpreset halloween`

## Best Practices

1. **Test settings on a development server first**
2. **Start with a preset, then customize**
3. **Enable debug mode when configuring**
4. **Monitor player feedback on visual quality**
5. **Use performance preset during peak hours**
6. **Document your custom presets**
7. **Back up config.lua before major changes**

## Support & Resources

- **GitHub Issues:** Report bugs and request features
- **Debug Mode:** Enable in config for detailed logs
- **Server Console:** Use `visualstatus` for diagnostics
- **Documentation:** This file and README.md

---

**The Land of the Wolves** - Professional visual management for RedM 🐺
