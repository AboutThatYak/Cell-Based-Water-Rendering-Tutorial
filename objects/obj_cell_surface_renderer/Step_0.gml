/// @description Insert description here
// You can write your code in this editor

if (keyboard_check_pressed(ord("1"))) currentSurface = 0;
if (keyboard_check_pressed(ord("2"))) currentSurface = 1;

//Add/remove water
if (mouse_check_button(mb_left))
	{
	var cellX = round(mouse_x / SURFACE_CELL_SIZE);
	var cellY = round(mouse_y / SURFACE_CELL_SIZE);
	var cellAsInt = cellPosToInt(cellX, cellY, gridColumns) * 4;
	buffer_poke(gridBuffer[currentSurface], cellAsInt, buffer_u8, 255); //<---R
	buffer_poke(gridBuffer[currentSurface], cellAsInt + 1, buffer_u8, 255); //<---G
	buffer_poke(gridBuffer[currentSurface], cellAsInt + 2, buffer_u8, 255); //<---B
	buffer_poke(gridBuffer[currentSurface], cellAsInt + 3, buffer_u8, 255);	//<---A
	}
if (mouse_check_button(mb_right))
	{
	var cellX = round(mouse_x / SURFACE_CELL_SIZE);
	var cellY = round(mouse_y / SURFACE_CELL_SIZE);
	var cellAsInt = cellPosToInt(cellX, cellY, gridColumns) * 4;	
	buffer_poke(gridBuffer[currentSurface], cellAsInt, buffer_u8, 0); //<---R
	buffer_poke(gridBuffer[currentSurface], cellAsInt + 1, buffer_u8, 0); //<---G
	buffer_poke(gridBuffer[currentSurface], cellAsInt + 2, buffer_u8, 0); //<---B
	buffer_poke(gridBuffer[currentSurface], cellAsInt + 3, buffer_u8, 0); //<---A
	}


