/// @description Insert description here
// You can write your code in this editor

//MACROS
#macro SURFACE_CELL_SIZE 16
#macro C_WATER_BLUE_DARKER #407686
#macro C_WATER_RED #F3484C

//Init
surfaceAlpha = 0.85;
gridColumns = room_width / SURFACE_CELL_SIZE;
gridRows = room_height / SURFACE_CELL_SIZE;
currentSurface = 0;

//Get shader uniforms
uCausticSampler = shader_get_sampler_index(shd_cell_surface, "causticTexture");
uCausticScale = shader_get_uniform(shd_cell_surface, "causticScale");
uMainPuddleStartAlpha = shader_get_uniform(shd_cell_surface, "mainPuddleStartAlpha");
uMainPuddleMix = shader_get_uniform(shd_cell_surface, "mainPuddleMix");
uOuterPuddleStartAlpha = shader_get_uniform(shd_cell_surface, "outerPuddleStartAlpha");
uOuterPuddleMix = shader_get_uniform(shd_cell_surface, "outerPuddleMix");
uSplashStartAlpha = shader_get_uniform(shd_cell_surface, "splashStartAlpha");
uSplashMix = shader_get_uniform(shd_cell_surface, "splashPuddleMix");
uEdgeMix = shader_get_uniform(shd_cell_surface, "edgePuddleMix");
uDistortionTime = shader_get_uniform(shd_cell_surface, "distortionTime");
uDistortionSpd = shader_get_uniform(shd_cell_surface, "distortionSpd");
uDistortionFreq = shader_get_uniform(shd_cell_surface, "distortionFreq");
uDistortionSize = shader_get_uniform(shd_cell_surface, "distortionSize");

//Config surface settings
renderSettings = 
	[
		//Water
		{
		texture : sprite_get_texture(spr_caustic, 0),
		texScale : [5, 5],
		color : C_WATER_BLUE_DARKER,
		alpha : 1,
		mainPuddleStart : 0.9,
		mainPuddleMix : 0.55,
		outerPuddleStart : 0.85,
		outerPuddleMix : 0.35,
		splashStart : 0.45,
		splashMix : 0.25,
		edgeMix : 0,
		distortionSpd : 0.003,
		distortionFreq : 3,
		distortionSize : 0.00333,
		},
		
		//Lava
		{
		texture : sprite_get_texture(spr_caustic, 0),
		texScale : [5, 5],
		color : C_WATER_RED,
		alpha : 1,
		mainPuddleStart : 0.9,
		mainPuddleMix : 0.55,
		outerPuddleStart : 0.85,
		outerPuddleMix : 0.35,
		splashStart : 0.45,
		splashMix : 0.25,
		edgeMix : 0,
		distortionSpd : 0.003,
		distortionFreq : 3,
		distortionSize : 0.00333,
		}
	]
	
//Setup buffers and surfaces
gridBuffer = [];
gridSurfaceID = [];
var len = array_length(renderSettings);
for (var i = 0; i < len; i++)
	{
	gridBuffer[i] = buffer_create(gridColumns * gridRows * 4, buffer_fixed, 1);
	gridSurfaceID[i] = surface_create(gridColumns, gridRows);
	}
drawSurfaceID = undefined;

//Set buffer using tilemap data
var waterTM = layer_tilemap_get_id(layer_get_id("ts_water"));
for (var column = 0; column < gridColumns; column++){
	for (var row = 0; row < gridRows; row++){
		var cellAsInt = cellPosToInt(column, row, gridColumns) * 4;
		var tileData = tilemap_get(waterTM, column, row);
		if(tileData != 0) 
			{
			buffer_poke(gridBuffer[tileData - 1], cellAsInt + 3, buffer_u8, 255); //<---A
			buffer_poke(gridBuffer[tileData - 1], cellAsInt, buffer_u8, 255); //<---R
			buffer_poke(gridBuffer[tileData - 1], cellAsInt + 1, buffer_u8, 255); //<---G
			buffer_poke(gridBuffer[tileData - 1], cellAsInt + 2, buffer_u8, 255); //<---B
			}
	}
}

