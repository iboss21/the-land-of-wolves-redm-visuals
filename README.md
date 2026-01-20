# The Land of Wolves - RedM Visuals

A comprehensive server-side visual pack for RedM that enhances graphics and visual effects for a more immersive Red Dead Redemption 2 multiplayer experience.

## Features

- 🌅 **Timecycle Modifiers** - Apply custom visual filters and color grading
- ☀️ **Weather Control** - Enhanced weather system with smooth transitions
- 💡 **Lighting Enhancements** - Improved environmental lighting and shadows
- 🌲 **Environmental Effects** - Better reflections, shadows, water quality, and foliage
- ⚙️ **Server-Side Management** - Centralized configuration and control
- 🎮 **Performance Optimized** - Configurable update intervals and efficient resource usage

## Installation

1. Download or clone this repository
2. Place the `the-land-of-wolves-redm-visuals` folder in your server's `resources` directory
3. Add `ensure the-land-of-wolves-redm-visuals` to your `server.cfg`
4. Restart your server or use `refresh` and `start the-land-of-wolves-redm-visuals`

## Configuration

Edit the `config.lua` file to customize visual settings:

### Timecycle Settings
```lua
Config.Timecycle = {
    Enabled = true,
    Modifier = "MP_Firefly_Main", -- Visual filter name
    Strength = 0.5, -- Effect strength (0.0 - 1.0)
}
```

### Weather Settings
```lua
Config.Weather = {
    Enabled = true,
    Type = "SUNNY", -- SUNNY, CLOUDS, OVERCAST, RAIN, FOG, SNOW, THUNDER, BLIZZARD
    TransitionTime = 45000, -- Transition time in milliseconds
}
```

### Lighting Settings
```lua
Config.Lighting = {
    Enabled = true,
    ExtraLights = true,
    ShadowQuality = 2, -- 0 = Low, 1 = Medium, 2 = High
}
```

### Environmental Effects
```lua
Config.Environment = {
    EnhancedReflections = true,
    ImprovedShadows = true,
    BetterWaterQuality = true,
    EnhancedFoliage = true,
}
```

## Server Commands

### Console Commands (Server Console Only)

- `reloadvisuals` - Reload visual settings for all connected players
- `togglevisuals` - Enable or disable visual enhancements globally

Example:
```
reloadvisuals
```

## How It Works

1. **Server-Side**: Manages visual configurations and distributes them to clients
2. **Client-Side**: Receives configuration and applies visual effects to the player's game
3. **Synchronization**: Ensures all players have consistent visual experience
4. **Performance**: Periodic updates maintain visual consistency without performance impact

## Troubleshooting

### Visuals not applying?
- Ensure the resource is started: check server console for initialization message
- Verify `Config.EnableVisuals = true` in `config.lua`
- Check if there are any script errors in server console or client F8 console

### Performance issues?
- Increase `Config.Performance.UpdateInterval` to reduce update frequency
- Disable specific features you don't need (timecycle, weather, etc.)
- Lower `Config.Lighting.ShadowQuality` setting

### Debug Mode
Enable debug logging in `config.lua`:
```lua
Config.Performance = {
    EnableDebug = true,
}
```

## Compatibility

- **RedM**: Compatible with current RedM builds
- **Server**: Works with both Windows and Linux servers
- **Client**: No additional client-side mods required

## Credits

Created by **The Land of Wolves** team for the RedM community.

## License

See LICENSE file for details.

## Support

For issues, questions, or suggestions, please open an issue on the GitHub repository.
