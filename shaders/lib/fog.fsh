#define UnderwaterFogStrength 1.0 // [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]

uniform int fogMode;

// Define some OpenGL constants for fog
const int GL_LINEAR = 9729;
const int GL_EXP = 2048;
const int GL_EXP2 = 2049;


vec3 FogFragment(in vec3 color, in int water)
{
    if (water == 1)
    {
        float strength = 1.0 - clamp(exp((-gl_Fog.density / UnderwaterFogStrength) * gl_FogFragCoord), 0.0, 1.0);
        return mix(color, gl_Fog.color.rgb, strength);
    }
    else if (fogMode == GL_EXP)
    {
        float strength = 1.0 - clamp(exp((-gl_Fog.density) * gl_FogFragCoord), 0.0, 1.0);
        return mix(color, gl_Fog.color.rgb, strength);
    }
    // Otherwise check if it's linear fog
    else if (fogMode == GL_LINEAR)
    {
        float strength = clamp(((gl_FogFragCoord - gl_Fog.start) * gl_Fog.scale), 0.0, 1.0);
        return mix(color, gl_Fog.color.rgb, strength);
    }
    // Debug: If EXP2 fog is used set the entire fragment to fullbright blue
    else if (fogMode == GL_EXP2)
    {
        // TODO: If this has happened it's probably an error in TFC or a mod, EXP2 isn't used in Minecraft
        return vec3(0.0, 0.0, 1.0);
    }
    else
    {
        return color;
    }
}