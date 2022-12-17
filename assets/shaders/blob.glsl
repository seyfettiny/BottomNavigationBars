
uniform float scale;

uniform vec2 u_resolution;

uniform vec2 metaball1;
uniform vec2 metaball2;
uniform vec2 metaball3;
uniform vec2 metaball4;
uniform vec2 metaball5;

float smoothen(float d1, float d2,float d3,float d4,float d5) {
    float k = 7.0;
    return -log(exp(-k * d1) + exp(-k * d2)+ exp(-k * d3) + exp(-k * d4)+ exp(-k * d5)) / k;
}

vec4 fragment(in vec2 uv, in vec2 fragCoord) {
	vec2 st = fragCoord.xy/vec2(u_resolution.x, u_resolution.x);
    float d = smoothen(distance(st, metaball1) * scale, distance(st, metaball2) * scale,distance(st, metaball3) * scale,distance(st, metaball4) * scale, distance(st, metaball5) * scale);
	float ae = 12.0 / u_resolution.y;
    vec3 color= vec3(smoothstep(0.8, 0.8+ae, d));
    if(d >= 0.8) return vec4(0.1, 0.1, 0.1, 0.867);
    
    return vec4(color, 0.0);
    
}