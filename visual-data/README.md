# Visual Data Files

This folder contains the visual configuration reference files that were analyzed to create the server-side visual effects system.

## Files Overview

### visualsettings.dat
**Purpose:** Core visual settings and configurations
- Weather system parameters (rain particles, drying speeds)
- Sky and atmosphere settings (sun/moon intensity, aerial perspective)
- Star configuration (constellations, galaxy intensity)
- Height-based reflection maps
- Rain collision settings

**Key Settings Used:**
- Weather cycle duration: 120 seconds
- Rain particles: 98,304
- Sun intensity: 100,000
- Moon intensity: 1.0
- Atmosphere thickness: 8.0

### watertune.xml
**Purpose:** Water visual effects and underwater rendering
- Water color and ripple speed
- Fog piercing intensity
- Water cycle depth and fade
- Underwater viewing parameters
- Ocean foam settings
- Rain fade ranges

**Key Settings Used:**
- Ripple speed: 4.5
- Fog pierce intensity: 0.75
- Water cycle depth: 8.0
- Underwater view distance: 10.0
- Caustic strength: 1.0

### terraintessellation.xml
**Purpose:** Terrain detail and tessellation parameters
- Pixels per vertex quality setting
- Noise patterns for terrain detail
- Tessellation envelope ranges
- Near/far detail settings

**Key Settings Used:**
- Pixels per vertex: 1024 (high quality)
- World texel unit: 1.0
- Tessellation envelope: 4.0 to 120.0 range
- Near W end: 40.0

### treeinfo.xml
**Purpose:** Vegetation and foliage rendering distances
- Tree entity creation distances
- Bush and plant render distances
- Imposter resolution settings
- LOD (Level of Detail) configurations
- Category-specific settings (trees, bushes, grass, debris, saplings)

**Key Settings Used:**
- Tree distance: 96.0
- Bush distance: 66.0
- Small vegetation: 36-46.0
- Imposter resolution: SIZE_1024x1024
- LOD fade settings: 0.0 (disabled for max quality)

### install.xml
**Purpose:** Installation manifest for game file replacements
- Documents which game files these visual settings would replace
- Shows the intended game paths for each configuration file
- Reference for understanding the original mod structure

**Game Paths Referenced:**
- `update:/common/data/visualsettings.dat`
- `update:/common/data/watertune.xml`
- `platform:/data/terraintessellation.xml`
- `common:/data/treeinfo.xml`

## How These Files Are Used

These files serve as **reference documentation** for the visual effects system. The actual implementation is done through:

1. **config.lua** - Contains parsed values from these files as configurable options
2. **server/server.lua** - Manages visual configuration distribution
3. **client/client.lua** - Applies visual effects using RedM natives

## Important Notes

⚠️ **These files are NOT directly loaded by the game** - RedM/FiveM doesn't support direct game file modification in server resources.

✅ **Instead:** The values from these files have been analyzed and implemented as Lua configuration options that use native RedM functions to achieve similar visual results.

🎨 **Purpose:** These files document the source of visual settings and serve as reference for future tuning and optimization.

## Modifying Visual Settings

To change visual effects, edit the corresponding section in `config.lua`:

- **Weather settings** → `Config.Weather`
- **Water effects** → `Config.Water`
- **Terrain settings** → `Config.Terrain`
- **Vegetation** → `Config.Vegetation`

## File Sources

These files were analyzed from professional Red Dead Redemption 2 visual enhancement mods to extract optimal visual parameters for RedM multiplayer servers.

**Author of original visual mod:** Rus_Game_Tactics (Best TAA and Visual Effects v1.6.0)

**Adapted for RedM by:** The Land of Wolves Team

---

For more information, see the main README.md and docs/USAGE_GUIDE.md
