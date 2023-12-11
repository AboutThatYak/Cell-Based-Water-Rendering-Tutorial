// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum CELL_SURFACE {WATER, OIL, ICE, SWIM, NUM_SURFACES};
function getCellSurfaceRenderSettings()
	{
	if (live_call()) return live_result;
	renderSettings = 
		[
			//---WATER---
			{
			id : CELL_SURFACE.WATER,
			texture : sprite_get_texture(spr_perlin, 0),
			texRatio : [35, 35],
			color: C_WATER_BLUE_LIGHT,
			distortionSpd : 0.0001,
			distortionFreq : 3,
			distortionSize : 0.00333,
			mainPuddleMix : .55,
			mainPuddleStart : 0.9,
			outerPuddleMix : 0.35,
			outerPuddleStart : 0.85,
			splashMix : 0.25,
			splashStart : 0.45,
			edgeMix : 0.55,
			},
			
			//---OIL---
			{
			id : CELL_SURFACE.OIL,
			texture : sprite_get_texture(spr_perlin, 0),
			texRatio : [40, 40],
			color: c_black,
			distortionSpd : 0.0001,
			distortionFreq : 10,
			distortionSize : 0.00333,
			mainPuddleMix : .12,
			mainPuddleStart : 0.9,
			outerPuddleMix : 0.25,
			outerPuddleStart : 0.85,
			splashMix : 0.95,
			splashStart : 0.15,
			edgeMix : 0.15,
			},
			
			//---ICE---
			{
			id : CELL_SURFACE.ICE,
			texture : sprite_get_texture(spr_perlin, 0),
			texRatio : [40, 40],
			color: c_white,
			distortionSpd : 0,
			distortionFreq : 0,
			distortionSize : 0.01,
			mainPuddleMix : .25,
			mainPuddleStart : 0.9,
			outerPuddleMix : 0.15,
			outerPuddleStart : 0.85,
			splashMix : 0.25,
			splashStart : 0.55,
			edgeMix : 0.55,
			},
			
			//---SWIM (deep water)---
			{
			id : CELL_SURFACE.SWIM,
			texture : sprite_get_texture(spr_perlin, 0),
			texRatio : [35, 35],
			color: C_WATER_BLUE_DARKER,
			distortionSpd : 0.00333,
			distortionFreq : 4,
			distortionSize : 0.001,
			mainPuddleMix : .55,
			mainPuddleStart : 0.9,
			outerPuddleMix : 0.35,
			outerPuddleStart : 0.85,
			splashMix : 0.25,
			splashStart : 0.45,
			edgeMix : 0.35,
			},
		]
	array_sort(renderSettings, function(elm1, elm2){return elm1.id - elm2.id;});
	}