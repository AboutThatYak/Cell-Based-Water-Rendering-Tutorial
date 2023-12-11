//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 pos;

//Uniforms
uniform vec2 causticScale; 
uniform sampler2D causticTexture;
uniform float mainPuddleStartAlpha;
uniform float mainPuddleMix;
uniform float outerPuddleStartAlpha;
uniform float outerPuddleMix;
uniform float splashStartAlpha;
uniform float splashMix;
uniform float edgeMix;
uniform float distortionTime;
uniform float distortionSpd;
uniform float distortionFreq;
uniform float distortionSize;

void main()
{
	
	//Get texture of surface grid
	vec2 texCoord = v_vTexcoord;
	vec4 color = v_vColour * texture2D(gm_BaseTexture, texCoord);
	
	//Get caustic/caustic/dope looking texture and distort it
	vec2 texScale = texCoord * causticScale;
	float distortionAmnt = sin(distortionTime * distortionSpd + texScale.y * distortionFreq) * (distortionSize * texScale.x);
	vec4 causticColor = texture2D(causticTexture, vec2(texScale.x + distortionAmnt, texScale.y));
	float replaceAlpha = causticColor.a;
	float alpha = color.a;
	
	//Test current pixel alpha and mix with texture alpha depending on it's "tier"
	if (alpha >= mainPuddleStartAlpha)
		{
		color.a = mix(color.a, replaceAlpha, mainPuddleMix);
		}
	if (alpha >= outerPuddleStartAlpha)
		{
		color.a = mix(color.a, replaceAlpha, outerPuddleMix);
		}
	else if (alpha > 0.0)
		{
		if (alpha > splashStartAlpha) color.a = mix(color.a, replaceAlpha, splashMix);
		else color.a = mix(color.a, replaceAlpha, edgeMix);
		}
	
	//Render
    gl_FragColor = color;
}

