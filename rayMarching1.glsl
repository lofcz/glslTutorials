// By LoF, end of 2k16

float rand(vec2 co)
{
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float map(vec3 point)
{
  vec3 q = fract(point) * 2.0 - 1.0;
    
  return (length(q) - abs(sin(iGlobalTime) / 8.0));   
}

float trace(vec3 origin, vec3 ray)
{
 float intersection = 0.0;
    
 for (int i = 0; i < 32; i++)
 {
     vec3 point    = origin + (ray * intersection);
     float d       = map(point);  
     intersection += d * 0.5;
 }
    
 return intersection;   
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / iResolution.xy; // {0; 1}
    uv      = uv * 2.0 - 1.0; //{-1; 1}
    uv.x   *= iResolution.x / iResolution.y;
    
    vec3 ray = normalize(vec3(uv, 1.0));
    vec3 origin = vec3(cos(iGlobalTime) / 2.0, sin(iGlobalTime) / 2.0, iGlobalTime * 0.5);
     
    float fc = trace(origin, ray);
    float fog = 10.0 / (1.0 + fc * fc * 0.9);
    
    vec3 f = vec3(fog);
    
	fragColor = vec4(vec3(fog * sin(iGlobalTime), fog * cos(iGlobalTime), fog * rand(fragCoord)),1.0);
}