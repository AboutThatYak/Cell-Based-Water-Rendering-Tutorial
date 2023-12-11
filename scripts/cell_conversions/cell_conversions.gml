// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cellPosToInt(cell_x, cell_y, grid_width)
{
	return cell_x + (cell_y * grid_width);
}
	
//function worldPosToCellPos (world_x, world_y, cell_size)
//{
//	return [round(world_x/cell_size), round(world_y/cell_size)]
//}