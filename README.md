# The Land of the Wolves - RedM Visual Effects System

```
╔════════════════════════════════════════════════╗
║     THE LAND OF THE WOLVES                   ║
║  RedM Visual Effects System v2.0.0           ║
╠════════════════════════════════════════════════╣
║  ⚡ Enhanced Visual Management                ║
║  🌊 Water & Weather Effects                  ║
║  🌲 Vegetation & Terrain Control             ║
║  🎨 Timecycle & Atmosphere Systems           ║
╚════════════════════════════════════════════════╝
```

A comprehensive, professionally-branded server-side visual pack for RedM that transforms The Land of Wolves server graphics with advanced visual effects, all configurable through an intuitive config system.

## ✨ Features

### Core Visual Systems
- 🌅 **Advanced Timecycle Modifiers** - Apply custom visual filters with adjustable strength
- ☀️ **Dynamic Weather System** - 10+ weather types with smooth transitions
- 💡 **Enhanced Lighting & Shadows** - Improved environmental lighting with quality presets
- 🌌 **Sky & Atmosphere Control** - Customizable sun, moon, stars, and atmospheric effects
- 🌊 **Water Visual Effects** - Advanced water rendering with underwater effects
- 🏔️ **Terrain Tessellation** - Enhanced terrain detail and quality
- 🌲 **Vegetation Management** - Configurable tree, bush, and foliage render distances
- 🎨 **Environmental Presets** - Cinematic, Performance, and Realistic visual modes

### Management Features
- ⚙️ **Server-Side Management** - Centralized configuration and control
- 📊 **Performance Monitoring** - Optional FPS tracking and optimization
- 🎮 **Visual Presets** - Quick-switch between visual quality modes
- 🔧 **Per-Player Settings** - Individual visual preference support
- 🎯 **Smart Optimization** - Auto-adjust for low-end systems
- 📝 **Comprehensive Logging** - Debug mode for troubleshooting

## 📦 Installation

1. Download or clone this repository
2. Place the `the-land-of-wolves-redm-visuals` folder in the server `resources` directory
3. Add `ensure the-land-of-wolves-redm-visuals` to `server.cfg`
4. Configure settings in `config.lua` as needed
5. Restart the server or use `refresh` and `start the-land-of-wolves-redm-visuals`

### ⚠️ Weather Compatibility
**IMPORTANT:** Weather control is **disabled by default** to prevent conflicts with `weathersync` and other weather scripts.

- ✅ **Safe to use with weathersync** - No conflicts!
- ✅ **Safe to use with vorp_weather** - Automatically detected
- ✅ **Safe to use with qb-weathersync** - Fully compatible

The system automatically detects common weather resources and disables its weather control. See [docs/WEATHER_COMPATIBILITY.md](docs/WEATHER_COMPATIBILITY.md) for details.

## ⚙️ Configuration

The visual system is powered by configuration files that were analyzed and parsed from professional visual mods:

### Timecycle Settings
```lua
Config.Timecycle = {
    Enabled = true,
    Modifier = "MP_Firefly_Main",
    Strength = 0.65, -- 0.0 to 1.0
}
```

**Popular Timecycle Modifiers:**
- `MP_Firefly_Main` - Warm, cinematic look
- `MP_Deathmatch_02` - Dramatic contrast
- `rdr_sunset_01` - Beautiful sunset tones
- `rdr_dawn_01` - Dawn atmosphere
- `MP_Campfire_Warm` - Cozy, warm feeling

### Weather System
```lua
Config.Weather = {
    Enabled = false, -- DISABLED BY DEFAULT (for weathersync compatibility)
    DisableOnConflict = true, -- Auto-detect and disable on conflicts
    Type = "SUNNY",
    TransitionTime = 45000, -- milliseconds
    CycleDuration = 120, -- Based on visualsettings.dat
}
```

> **⚠️ Note:** Weather control is disabled by default to prevent conflicts with `weathersync`, `vorp_weather`, and similar scripts. See [Weather Compatibility Guide](docs/WEATHER_COMPATIBILITY.md) for details.

**Available Weather Types:**
SUNNY, CLOUDS, OVERCAST, RAIN, FOG, SNOW, THUNDER, BLIZZARD, DRIZZLE, SLEET, WHITEOUT, HIGHPRESSURE, MISTY, OVERCASTDARK

### Water Effects (from watertune.xml)
```lua
Config.Water = {
    Enabled = true,
    RippleSpeed = 4.5,
    FogPierceIntensity = 0.75,
    WaterCycleDepth = 8.0,
    Underwater = {
        ViewDistance = 10.0,
        FogBrightness = 2.0,
        CausticStrength = 1.0,
    },
}
```

### Terrain Tessellation (from terraintessellation.xml)
```lua
Config.Terrain = {
    Enabled = true,
    PixelsPerVertex = 1024, -- Higher = better quality
    WorldTexelUnit = 1.0,
    UseNearWEnd = 40.0,
}
```

### Vegetation Control (from treeinfo.xml)
```lua
Config.Vegetation = {
    Enabled = true,
    TreeDistance = 96.0,
    BushDistance = 66.0,
    GrassDistance = 46.0,
    QualityPreset = "ULTRA", -- LOW, MEDIUM, HIGH, ULTRA
}
```

### Visual Presets
```lua
-- Cinematic Mode - Best for screenshots
Config.Presets["cinematic"] = {
    Description = "Cinematic visuals",
    DrawDistance = 2.0,
    LodScale = 1.5,
}

-- Performance Mode - Optimized for lower-end PCs
Config.Presets["performance"] = {
    Description = "Optimized for performance",
    DrawDistance = 0.7,
    LodScale = 0.6,
}

-- Realistic Mode - Balanced visuals
Config.Presets["realistic"] = {
    Description = "Balanced realistic visuals",
    DrawDistance = 1.0,
    LodScale = 1.0,
}
```

## 🎮 Server Commands

All commands are **console-only** for server administrators:

### Core Commands
```bash
# Reload visual settings for all players
reloadvisuals

# Toggle visuals on/off globally
togglevisuals

# Show visual system status
visualstatus
```

### Configuration Commands
```bash
# Change weather for all players
setweather <type>
# Example: setweather RAIN

# Change timecycle modifier
settimecycle <modifier> [strength]
# Example: settimecycle MP_Firefly_Main 0.8

# Apply a visual preset
visualpreset <preset_name>
# Example: visualpreset cinematic
# List available presets: visualpreset
```

## 📖 How It Works

### Architecture
1. **Configuration Parsing** - Visual settings are extracted from professional mod files:
   - `visualsettings.dat` → Weather, sky, atmosphere settings
   - `watertune.xml` → Water visual effects
   - `terraintessellation.xml` → Terrain detail settings
   - `treeinfo.xml` → Vegetation render distances

2. **Server-Side Management** - The server:
   - Manages global visual configuration
   - Distributes settings to clients
   - Handles dynamic updates
   - Monitors player performance (optional)

3. **Client-Side Application** - Each client:
   - Receives visual configuration
   - Applies effects using RedM natives
   - Maintains visual consistency
   - Reports performance metrics (optional)

### Technical Details
- **Timecycle modifiers** control color grading and atmospheric effects
- **Weather system** uses native RedM weather transitions
- **Lighting** enhanced through artificial light states and multipliers
- **Terrain & Vegetation** settings optimize render distances
- **Performance monitoring** tracks FPS for optimization

## 🐛 Troubleshooting

### Visuals Not Applying?
1. Ensure the resource is started: check server console for the banner
2. Verify `Config.EnableVisuals = true` in `config.lua`
3. Check for script errors in server console or client F8 console
4. Try `reloadvisuals` command in server console

### Performance Issues?
1. Increase `Config.Performance.UpdateInterval` to reduce update frequency
2. Switch to performance preset: `visualpreset performance`
3. Disable specific features you don't need
4. Lower vegetation distances in config
5. Enable `Config.Performance.OptimizeForLowEnd`

### Weather Not Changing?
- Use the `setweather` command to force a weather change
- Check if weather is enabled in config
- Verify weather type is spelled correctly (case-sensitive)

### Debug Mode
Enable detailed logging in `config.lua`:
```lua
Config.Performance = {
    EnableDebug = true,
    MonitorPerformance = true,
}
```

Check F8 console (client) and server console for debug messages.

## 🎨 Customization Tips

### Creating Custom Presets
Add your own preset to `Config.Presets`:
```lua
Config.Presets["mypreset"] = {
    Description = "My custom visual setup",
    Timecycle = { 
        Enabled = true, 
        Modifier = "MP_Deathmatch_02", 
        Strength = 0.7 
    },
    DrawDistance = 1.2,
    LodScale = 1.1,
}
```

### Fine-Tuning Visuals
Experiment with these settings for the best look:
- **Timecycle Strength** (0.3-0.8) - Controls intensity
- **Draw Distance** (0.7-2.0) - Affects how far you can see
- **Vegetation Distances** - Balance between quality and performance
- **Water Effects** - Adjust for realistic or stylized water

## 🔧 Advanced Configuration

### Per-Player Settings
Players can have individual preferences stored server-side. The system automatically applies player-specific overrides when available.

### Performance Auto-Optimization
Enable automatic performance adjustment:
```lua
Config.Performance = {
    MonitorPerformance = true,
    OptimizeForLowEnd = true,
}
```

The system will automatically reduce settings if FPS drops below optimal levels.

## 📋 Requirements

- **RedM** server (latest build recommended)
- **Server** running Windows or Linux
- **No client-side mods required** - all effects applied server-side

## ⚖️ Compatibility

### Weather Scripts
- ✅ **weathersync** - Fully compatible (auto-detection enabled)
- ✅ **vorp_weather** - Fully compatible (auto-detection enabled)
- ✅ **qb-weathersync** - Fully compatible (auto-detection enabled)
- ✅ **rsg-weathersync** - Fully compatible (auto-detection enabled)
- ℹ️ Weather control disabled by default to prevent conflicts
- 📖 See [Weather Compatibility Guide](docs/WEATHER_COMPATIBILITY.md) for full details

### General Compatibility
- ✅ Compatible with most RedM resources
- ✅ Safe for production servers
- ✅ No game file modifications required
- ✅ Works alongside other visual enhancement resources
- ⚠️ May conflict with other timecycle modifier scripts (can coexist, but one should be disabled)

## 📜 Based On

This system analyzes and implements settings from:
- Visual Settings Configuration Files (visualsettings.dat)
- Water Tuning Parameters (watertune.xml)
- Terrain Tessellation Settings (terraintessellation.xml)
- Tree/Vegetation Information (treeinfo.xml)

All settings have been optimized for server-side deployment and RedM compatibility.

## 🤝 Credits

**Created by The Land of Wolves Team**

Inspired by professional visual enhancement mods and optimized for RedM multiplayer servers.

## 📄 License

See LICENSE file for details.

## 💬 Support

For issues, questions, or feature requests:
- Open an issue on the GitHub repository
- Check the troubleshooting section above
- Enable debug mode for detailed logs

---

**The Land of the Wolves** - Transforming your RedM server's visual experience 🐺
