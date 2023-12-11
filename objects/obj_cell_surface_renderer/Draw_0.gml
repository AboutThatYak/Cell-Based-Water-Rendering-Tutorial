/// @description Insert description here
// You can write your code in this editor

//Setup GPU
gpu_set_tex_filter(true);
gpu_set_tex_repeat(true);

//Configure draw settings
var camX = 0;
var camY = 0;
var camW = room_width;
var camH = room_height;
var cropX = camX / SURFACE_CELL_SIZE;
var cropY = camY / SURFACE_CELL_SIZE;
var cropW = camW / SURFACE_CELL_SIZE;
var cropH = camH / SURFACE_CELL_SIZE;
var scale = SURFACE_CELL_SIZE;

//Create draw surface
if (drawSurfaceID == undefined || !surface_exists(drawSurfaceID)) drawSurfaceID = surface_create(camW, camH);

//Init draw
surface_set_target(drawSurfaceID);
draw_clear_alpha(c_black, 0);

//Draw *tiny* surfaces
shader_set(shd_cell_surface);
gpu_set_blendmode(bm_max);
var len = array_length(renderSettings)
for (var i = 0; i < len; i++)
	{
	//Setup surface
	if (!surface_exists(gridSurfaceID[i])) gridSurfaceID[i] = surface_create(gridColumns, gridRows);
	buffer_set_surface(gridBuffer[i], gridSurfaceID[i], 0);
		
	//Texture
	texture_set_stage(uCausticSampler, renderSettings[i].texture);
	shader_set_uniform_f_array(uCausticScale, renderSettings[i].texScale);
	
	//Mix
	shader_set_uniform_f(uMainPuddleStartAlpha, renderSettings[i].mainPuddleStart);
	shader_set_uniform_f(uMainPuddleMix, renderSettings[i].mainPuddleMix);
	shader_set_uniform_f(uOuterPuddleStartAlpha, renderSettings[i].outerPuddleStart);
	shader_set_uniform_f(uOuterPuddleMix, renderSettings[i].outerPuddleMix);
	shader_set_uniform_f(uSplashStartAlpha, renderSettings[i].splashStart);
	shader_set_uniform_f(uSplashMix, renderSettings[i].splashMix);
	shader_set_uniform_f(uEdgeMix, renderSettings[i].edgeMix);
	
	//Distortion
	shader_set_uniform_f(uDistortionTime, current_time);
	shader_set_uniform_f(uDistortionSpd, renderSettings[i].distortionSpd);
	shader_set_uniform_f(uDistortionFreq, renderSettings[i].distortionFreq);
	shader_set_uniform_f(uDistortionSize, renderSettings[i].distortionSize);

	//"Stretch out" the *tiny* surface across the screen
	draw_surface_part_ext(gridSurfaceID[i], cropX, cropY, cropW, cropH, 0, 0, scale, scale, renderSettings[i].color, renderSettings[i].alpha);
	}

//Reset and draw final product
shader_reset();
surface_reset_target();
gpu_set_blendmode(bm_normal);
gpu_set_tex_filter(false);
gpu_set_tex_repeat(false);
draw_surface_ext(drawSurfaceID, camX, camY, 1, 1, 0, c_white, surfaceAlpha);