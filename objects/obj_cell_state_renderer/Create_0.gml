/// @description Insert description here
// You can write your code in this editor

//Init
#macro C_WATER_BLUE_LIGHT #5D8B99

#macro C_WATER_GREEN #48662A

//#macro DEFAULT_CELL_SIZE 16

//Setup surfaces
surfaceAlpha = 0.85;
gridColumns = room_width / DEFAULT_CELL_SIZE;
gridRows = room_height / DEFAULT_CELL_SIZE;
gridBuffer = buffer_create(gridColumns * gridRows * 4, buffer_fixed, 1);
gridSurfaceID = undefined;
drawSurfaceID = undefined;

//Shader uniforms
causticSampler = shader_get_sampler_index(shd_cell_state_render, "causticTexture");
uCausticRatio = shader_get_uniform(shd_cell_state_render, "causticScale");
uDistortionTime = shader_get_uniform(shd_cell_state_render, "distortionTime");
uDistortionSpd = shader_get_uniform(shd_cell_state_render, "distortionSpd");
uDistortionFreq = shader_get_uniform(shd_cell_state_render, "distortionFreq");
uDistortionSize = shader_get_uniform(shd_cell_state_render, "distortionSize");
uMainPuddleStartAlpha = shader_get_uniform(shd_cell_state_render, "mainPuddleStartAlpha");
uMainPuddleMix = shader_get_uniform(shd_cell_state_render, "mainPuddleMix");
uOuterPuddleStartAlpha = shader_get_uniform(shd_cell_state_render, "outerPuddleStartAlpha");
uOuterPuddleMix = shader_get_uniform(shd_cell_state_render, "outerPuddleMix");
uSplashStartAlpha = shader_get_uniform(shd_cell_state_render, "splashStartAlpha");
uSplashMix = shader_get_uniform(shd_cell_state_render, "splashMix");
uEdgeMix = shader_get_uniform(shd_cell_state_render, "edgeMix");

//Config water render settings here
renderSettings = 
{		
	texture : sprite_get_texture(spr_caustic, 0),
	texScale : [5, 5],
	color: C_WATER_BLUE_DARKER,
	alpha: 1,
	distortionSpd : 0.003,
	distortionFreq : 3,
	distortionSize : 0.00333,
	mainPuddleStart : 0.9,
	mainPuddleMix : .55,
	outerPuddleStart : 0.85,
	outerPuddleMix : 0.35,
	splashStart : 0.45,
	splashMix : 0.25,
	edgeMix : 0,
}
	
//Set buffer using tilemap data
var waterTM = layer_tilemap_get_id(layer_get_id("ts_water"));
for (var column = 0; column < gridColumns; column++){
	for (var row = 0; row < gridRows; row++){
		var cellAsInt = cellPosToInt(column, row, gridColumns) * 4;
		buffer_poke(gridBuffer, cellAsInt, buffer_u8, 255);	
		buffer_poke(gridBuffer, cellAsInt + 1, buffer_u8, 255);	
		buffer_poke(gridBuffer, cellAsInt + 2, buffer_u8, 255);	
		if(tilemap_get(waterTM, column, row)) buffer_poke(gridBuffer, cellAsInt + 3, buffer_u8, 255);
		}
	}
