# Basic TFC+ Shaders
This is a shaderpack specifically made for [TerraFirmaCraft+](https://www.curseforge.com/minecraft/mc-mods/terrafirmacraftplus) which is maintained by [Dunkleosteus](https://www.youtube.com/channel/UCq-j5IqnPTeBy4A4ezhY0SQ)

The goal of this shaderpack is simple: Provide a shader that fixes circumvents bugs produced when running TFC+ and Optifine together, the following  list provides more details on what is fixed.

- Grass, Leaf Litter, Undergrowth, Sulfur 'ore' and several other block entities that are very thin and close to the block they rest on will no longer flicker (Z-Fight)
- Minor tweak to fog

## Performance
During writing of the shader, it was tested on TFC+ 0.87 with Optifine HD Ultra E7, the following settings were also used:
- Render Distance: 12
- Graphics: Fancy
- Smooth Lighting: Minimum
- Advanced OpenGL: Fancy
- Mipmapping: Off
- Anisotropic Filtering: Off
- Chunk-Loading: Multi-Core (with NVIDIA Control Panel fix)
- Smooth FPS: On
- Smooth World: Off
- Fast Math: On

Testing was performed in a coastal region with numerous Limba trees visible in every direction inland, on a Ryzen 5 2600 and RTX 2070 Super, a stable 70+ FPS was achieved consistently when all the chunks had been generated and loaded.

## Shader Reference
Defined below are the various blocks, block-entities, entities and such that a specific shader will affect.
Please refer to [Optifine Shaders Doc](https://github.com/sp614x/optifine/blob/master/OptiFineDoc/doc/shaders.txt) for inheritance and further clarification on what is affected in vanilla.

### gbuffers_basic
- 'Selection' bounding box

### gbuffers_block
- Loose nuggets, rocks and sticks

### gbuffers_clouds
- Clouds

### gbuffers_skybasic
- Horizon, stars, sky

### gbuffers_skytextured
- Sun, moon

### gbuffers_textured
- Entities, terrain, water, particles
