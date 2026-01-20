# Weather System Compatibility Guide

## Overview

The Land of Wolves Visual Effects System includes an **optional** weather control system. However, to ensure maximum compatibility with existing weather scripts like `weathersync`, `vorp_weather`, or other weather management resources, the weather control is **disabled by default**.

## Default Configuration

```lua
Config.Weather = {
    Enabled = false, -- DISABLED BY DEFAULT
    DisableOnConflict = true, -- Auto-detects and disables if conflicts found
}
```

## Automatic Conflict Detection

The system automatically detects the following weather resources:
- `weathersync`
- `qb-weathersync`
- `vorp_weather`
- `rsg-weathersync`
- `weather`
- `redm-weather`
- `advanced-weather`

> **Note:** This list can be customized in `config.lua` by editing `Config.Weather.ConflictingResources`. If your weather script isn't detected automatically, you can add it to this list.

When any of these resources are running, the visual system will:
1. ✅ Automatically disable its weather control
2. 📢 Log a warning message explaining the conflict
3. ⚡ Continue to provide all other visual enhancements (timecycle, lighting, water, terrain, vegetation)

## Using With External Weather Scripts

### Recommended Setup (Default)
If you're using `weathersync` or another weather script:

1. **Keep weather disabled in config.lua:**
   ```lua
   Config.Weather = {
       Enabled = false,
       DisableOnConflict = true,
   }
   ```

2. Your external weather script will handle all weather changes
3. The Land of Wolves Visuals will provide:
   - ✅ Timecycle modifiers (color grading)
   - ✅ Enhanced lighting
   - ✅ Water effects
   - ✅ Terrain tessellation
   - ✅ Vegetation control
   - ✅ Sky and atmosphere enhancements

### Using Built-in Weather Control

If you want to use the built-in weather system:

1. **Stop or remove** any conflicting weather resources
2. **Enable weather in config.lua:**
   ```lua
   Config.Weather = {
       Enabled = true,
       Type = "SUNNY",
       TransitionTime = 45000,
   }
   ```

3. Use the `setweather` console command to change weather

## Weather Commands

### setweather Command
```bash
# Only works if Config.Weather.Enabled = true
setweather <type>

# Examples:
setweather SUNNY
setweather RAIN
setweather THUNDER
```

If weather is disabled, the command will show:
```
[TLW Visuals] Weather control is disabled!
[TLW Visuals] This is likely because another weather resource is running.
```

## Available Weather Types

- SUNNY
- CLOUDS
- OVERCAST
- RAIN
- FOG
- SNOW
- THUNDER
- BLIZZARD
- DRIZZLE
- SLEET
- WHITEOUT
- HIGHPRESSURE
- MISTY
- OVERCASTDARK

## Weather Configuration Options

```lua
Config.Weather = {
    -- Master toggle for weather control
    Enabled = false,
    
    -- Automatically disable if conflicts detected
    DisableOnConflict = true,
    
    -- Default weather when enabled
    Type = "SUNNY",
    
    -- Smooth transition time (milliseconds)
    TransitionTime = 45000,
    
    -- Weather cycle duration (from visualsettings.dat)
    CycleDuration = 120,
    
    -- Advanced rain particle settings (from visualsettings.dat)
    RainSettings = {
        NumberParticles = 98304,
        UseLitShader = true,
        FadeInScale = 2.0,
        Diffuse = 1.0,
        Ambient = 0.4,
    },
}
```

## Troubleshooting

### Weather not changing
**Solution:** Check if weather is enabled:
1. Look for the startup message: `Weather Control: Enabled` or `Disabled`
2. If disabled, ensure no conflicting weather resources are running
3. Set `Config.Weather.Enabled = true` in config.lua
4. Restart the resource

### Conflict with weathersync
**Solution:** This is expected and working correctly!
- Keep `Config.Weather.Enabled = false`
- The system will automatically yield control to weathersync
- All other visual features remain active

### Want to switch from weathersync to built-in
**Steps:**
1. Stop weathersync: `stop weathersync`
2. Remove or comment out from server.cfg: `# ensure weathersync`
3. Edit config.lua: `Config.Weather.Enabled = true`
4. Restart visuals: `restart the-land-of-wolves-redm-visuals`

## Best Practices

### ✅ Recommended
- Keep weather disabled if using weathersync or similar scripts
- Use `DisableOnConflict = true` for automatic detection
- Let external weather scripts handle weather changes
- Use this resource for visual enhancements (timecycle, lighting, water, etc.)

### ❌ Not Recommended
- Running multiple weather scripts simultaneously
- Disabling conflict detection (`DisableOnConflict = false`) when conflicts exist
- Manually enabling weather without checking for conflicts

## Integration with Popular Scripts

### weathersync
- ✅ **Fully Compatible** - Weather control auto-disabled
- Use weathersync for weather management
- Use this resource for visual enhancements

### vorp_weather
- ✅ **Fully Compatible** - Weather control auto-disabled
- Use vorp_weather for weather management
- Use this resource for visual enhancements

### qb-weathersync
- ✅ **Fully Compatible** - Weather control auto-disabled
- Use qb-weathersync for weather management
- Use this resource for visual enhancements

### Custom Weather Scripts
If your weather script isn't auto-detected:
1. Manually set `Config.Weather.Enabled = false`
2. Or add your resource name to the conflict detection list in `config.lua`:
   ```lua
   Config.Weather.ConflictingResources = {
       "weathersync",
       "qb-weathersync",
       "vorp_weather",
       "rsg-weathersync",
       "weather",
       "redm-weather",
       "advanced-weather",
       "your-weather-script-name" -- Add your custom weather resource here
   }
   ```

## Technical Details

### How Conflict Detection Works

The system uses `GetResourceState()` to check if known weather resources are running:

```lua
local conflictingResources = {
    "weathersync",
    "qb-weathersync",
    "vorp_weather",
    "rsg-weathersync",
    "weather",
    "redm-weather",
    "advanced-weather"
}
```

If any are detected as "started" or "starting", weather control is automatically disabled.

### What Gets Disabled

When weather control is disabled:
- ❌ Weather type changes (SetWeatherTypeOverTime)
- ❌ `setweather` command functionality

What remains active:
- ✅ Timecycle modifiers
- ✅ Lighting enhancements
- ✅ Water visual effects
- ✅ Terrain tessellation
- ✅ Vegetation settings
- ✅ Sky and atmosphere (non-weather aspects)

## Support

For weather compatibility issues:
1. Check server console on resource start for conflict warnings
2. Verify `Config.Weather.Enabled` setting
3. Confirm no duplicate weather resources are running
4. Enable debug mode: `Config.Performance.EnableDebug = true`

---

**The Land of Wolves** - Professional visual enhancements without the conflicts 🐺
