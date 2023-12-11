	
//Init	
draw_set_alpha(1);
draw_set_color(c_white);
gpu_set_tex_filter(true);
gpu_set_tex_repeat(true); //<---Wait til doing texture section to code this

//Configure draw settings
var camX = 0;
var camY = 0;
var camW = room_width;
var camH = room_height;
var cropX = camX / DEFAULT_CELL_SIZE;
var cropY = camY / DEFAULT_CELL_SIZE;
var cropW = camW / DEFAULT_CELL_SIZE;
var cropH = camH / DEFAULT_CELL_SIZE;
var scale = DEFAULT_CELL_SIZE;

//Surface that culls out the cells that aren't a part of the surface
if (gridSurfaceID == undefined || !surface_exists(gridSurfaceID)) gridSurfaceID = surface_create(gridColumns, gridRows);	
	
//The main surface that will be drawn to the screen
if (drawSurfaceID == undefined || !surface_exists(drawSurfaceID)) drawSurfaceID = surface_create(camW, camH);
	
//Init surface
buffer_set_surface(gridBuffer, gridSurfaceID, 0);
surface_set_target(drawSurfaceID);
draw_clear_alpha(c_black, 0);
		
//Draw Reflections Here <---DONT GO OVER THIS IN MUCH DETAIL!
//var reflectColor = c_white;
//var reflectAlpha = 0.85;
//with (par_entity)
//	{
//	if (!toggleDrawReflections || !inScreenSpace) continue;
//	var heldZ = -((heldByID != noone) * z); //<---negate z since reflection is upside down
//	draw_sprite_ext(sprite_index, image_index, x - camX, (y - heldZ + reflectionOffsetY) - camY, -animScaleX, animScaleY, 180, reflectColor, reflectAlpha); 
//	}
	
//Setup shader
shader_set(shd_cell_state_render);
texture_set_stage(causticSampler, renderSettings.texture);
shader_set_uniform_f_array(uCausticRatio, renderSettings.texScale);
shader_set_uniform_f(uDistortionTime, current_time);
shader_set_uniform_f(uDistortionSpd, renderSettings.distortionSpd);
shader_set_uniform_f(uDistortionFreq, renderSettings.distortionFreq);
shader_set_uniform_f(uDistortionSize, renderSettings.distortionSize);
shader_set_uniform_f(uMainPuddleStartAlpha, renderSettings.mainPuddleStart);
shader_set_uniform_f(uMainPuddleMix, renderSettings.mainPuddleMix);
shader_set_uniform_f(uOuterPuddleStartAlpha, renderSettings.outerPuddleStart);
shader_set_uniform_f(uOuterPuddleMix, renderSettings.outerPuddleMix);
shader_set_uniform_f(uSplashStartAlpha, renderSettings.splashStart);
shader_set_uniform_f(uSplashMix, renderSettings.splashMix);
shader_set_uniform_f(uEdgeMix, renderSettings.edgeMix);
	
//Only "stretch out" the part of the cull surface that's needed
gpu_set_blendmode_ext(bm_src_alpha, bm_src_alpha);
draw_surface_part_ext(gridSurfaceID, cropX, cropY, cropW, cropH, 0, 0, scale, scale, renderSettings.color, renderSettings.alpha);
gpu_set_blendmode(bm_normal);
	
//Reset and draw final product
shader_reset()
surface_reset_target();
draw_surface_ext(drawSurfaceID, camX, camY, 1, 1, 0, c_white, surfaceAlpha);
	
//Reset
gpu_set_tex_filter(false);
gpu_set_tex_repeat(false);