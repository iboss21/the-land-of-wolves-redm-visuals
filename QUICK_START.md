# Quick Start Guide

## Installation

1. Download/clone this repository
2. Place in your server's `resources` folder
3. Add to `server.cfg`:
   ```
   ensure the-land-of-wolves-redm-visuals
   ```
4. Restart server

## Important: Weather Compatibility

⚠️ **Weather control is DISABLED by default** to prevent conflicts with weathersync and similar scripts.

### If you use weathersync or other weather scripts:
✅ **You're all set!** Just install and use. No configuration needed.
- Weather control is automatically disabled
- All other visual features work perfectly
- No conflicts

### If you want to use built-in weather control:
1. Stop/remove your existing weather script
2. Edit `config.lua`:
   ```lua
   Config.Weather.Enabled = true
   ```
3. Restart the resource

## Configuration

Edit `config.lua` to customize:

### Timecycle (Color Grading)
```lua
Config.Timecycle = {
    Enabled = true,
    Modifier = "MP_Firefly_Main",  -- Change for different looks
    Strength = 0.65,                -- 0.0 to 1.0
}
```

### Visual Presets
Apply a preset via console:
```
visualpreset cinematic    # Best visuals
visualpreset performance  # Optimized
visualpreset realistic    # Balanced
```

## Console Commands (Admin Only)

```bash
# View status
visualstatus

# Reload visuals for all players
reloadvisuals

# Toggle on/off
togglevisuals

# Change preset
visualpreset <preset_name>

# Change weather (only if weather enabled)
setweather RAIN

# Change timecycle
settimecycle MP_Firefly_Main 0.8
```

## Troubleshooting

### Visuals not applying?
1. Check server console for errors
2. Verify resource is started (look for the banner)
3. Try: `reloadvisuals` in console

### Performance issues?
1. Use performance preset: `visualpreset performance`
2. Increase update interval in config.lua:
   ```lua
   Config.Performance.UpdateInterval = 15000  -- 15 seconds
   ```

### Weather conflicts?
**This shouldn't happen!** Weather is disabled by default.
- Check the startup message shows "Weather Control: Disabled"
- Ensure `Config.Weather.Enabled = false` in config.lua

### Debug Mode
Enable in config.lua:
```lua
Config.Performance.EnableDebug = true
```

Then check:
- Server console for server-side logs
- Client F8 console for client-side logs

## Documentation

- 📖 **Full guide:** [README.md](README.md)
- 🌦️ **Weather info:** [docs/WEATHER_COMPATIBILITY.md](docs/WEATHER_COMPATIBILITY.md)
- ⚡ **Performance:** [docs/PERFORMANCE.md](docs/PERFORMANCE.md)
- 📚 **All docs:** [docs/](docs/)

## Support

1. Check documentation
2. Enable debug mode
3. Check console for errors
4. Review compatibility guides

## Key Points

✅ Safe to use with weathersync
✅ Safe to use with vorp_weather
✅ Safe to use with qb-weathersync
✅ Works with all RedM resources
✅ No game file modifications required
✅ All effects server-side controlled

---

**The Land of Wolves** - Professional RedM Visuals 🐺
