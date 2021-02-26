# Changelog
History of changes in descending order to oldest changes.

## Version 1.0.1
- Added entity lighting, entities are now shaded by the sun/moon, not just by the lightmap
- Improved clouds, they are affected by fog further away now to give the illusion that they are very far away when you are at ground level.
- Entities are now handled by their own shader, `gbuffers_entities`
- Player hand and held item now handled by `gbuffers_hand` and also utilise the same lighting as `gbuffers_entities`
- Fog uses the distance to the vertex rather than the depth of the vertex, this improves the quality of fog shading so it is not frustum linear.
- Added shader option for UnderwaterFogStrength, this defaults to 1.0 for TFC vanilla setting, lowering the value increases the strength

## Version 1.0.0
Initial release