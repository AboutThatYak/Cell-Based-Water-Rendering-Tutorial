/// @description Insert description here
// You can write your code in this editor

//Add/remove water
if (mouse_check_button(mb_left))
	{
	var cellX = round(mouse_x / DEFAULT_CELL_SIZE);
	var cellY = round(mouse_y / DEFAULT_CELL_SIZE);
	var cellAsInt = cellPosToInt(cellX, cellY, gridColumns) * 4;
	buffer_poke(gridBuffer, cellAsInt + 3, buffer_u8, 255);		
	}
if (mouse_check_button(mb_right))
	{
	var cellX = round(mouse_x / DEFAULT_CELL_SIZE);
	var cellY = round(mouse_y / DEFAULT_CELL_SIZE);
	var cellAsInt = cellPosToInt(cellX, cellY, gridColumns) * 4;
	buffer_poke(gridBuffer, cellAsInt + 3, buffer_u8, 0);		
	}



