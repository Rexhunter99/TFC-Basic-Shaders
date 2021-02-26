uniform vec3 moonPosition;
uniform vec3 sunPosition;
uniform vec3 upPosition;

float LightGradient(in vec3 normal)
{
    // Hacky fix because shadowLightPosition wasn't working for me
    // TODO: use shadowLightPosition, figure out why it isn't working
    float NtoS = dot(normal, normalize(sunPosition));
    float NtoM = dot(normal, normalize(moonPosition));
    float NtoSM = (NtoS * dot(normalize(sunPosition), normalize(upPosition))) + (NtoM * dot(normalize(moonPosition), normalize(upPosition)));
    return clamp(NtoSM, 0.0, 1.0);
}