package  
{
	import flash.display.GraphicsGradientFill;
	import flash.events.MouseEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Input;
		
	/**
	 * ...
	 * @author Vaevictus
	 */
	public class Maze extends Entity 
	{
		private var _tiles:Tilemap;
		private var _grid:Grid;
		
		
		public function Maze()
		{
			_tiles = new Tilemap(Assets.SPRITE_TILESET, 800, 640, 32, 32);
			graphic = _tiles;
			layer = 1;
			_grid = new Grid(800, 640, 32, 32, 0, 0);
			mask = _grid;
			setUpMouse();
			type = 'maze';
			
			doDemoMaze();
		}
		
		private function setUpMouse():void
		{
			if (Input.mouseReleased)
			{
				trace(Input.mouseX, ",", Input.mouseY);
			}
		}
		private function doDemoMaze():void 
		{
			AddTile('wall', 0, 0, 25, 20); // perimeter
			AddTile('floor', 1, 1, 23, 18); // default inside perimter
			
			// top rows
			
			AddTile('wall', 2, 2, 4, 2);
			AddTile('wall', 7, 1, 2, 3);
			AddTile('wall', 10, 2, 5, 2);
			AddTile('wall', 19, 2, 4, 2);
			AddTile('wall', 16, 1, 2, 3);
			
			AddTile('closeddoor', 2, 8, 1, 1);
			AddTile('closeddoor', 22, 8, 1, 1);
			AddTile('wall', 1, 5, 2, 3);
			AddTile('wall', 22, 5, 2, 3);
			AddTile('wall', 4, 5, 2, 6);
			AddTile('wall', 19, 5, 2, 6);
			AddTile('wall', 6, 9, 3, 2);
			AddTile('wall', 16, 9, 3, 2);
			AddTile('wall', 7, 5, 5, 3);
			AddTile('wall', 13, 5, 5, 3);
			AddTile('statue', 10, 9, 5, 5);
			
			AddTile('wall', 1, 9, 2, 2);
			AddTile('wall', 22, 9, 2, 2);
			
			AddTile('wall', 2, 12, 2, 6);
			AddTile('wall', 21, 12, 2, 6);
			
			AddTile('wall', 5, 12, 4, 2);
			AddTile('wall', 16, 12, 4, 2);
			AddTile('wall', 5, 15, 2, 4);
			AddTile('wall', 18, 15, 2, 4);
			
			AddTile('wall', 8, 15, 4, 3);
			AddTile('wall', 13, 15, 4, 3);
			//AddTile('closeddoor', 6, 3, 1, 1);
	//		_grid.setRect(1, 1, 23, 18, false);
	//		_grid.setRect(3, 3, 3, 5, true);
	//		_grid.setTile(12, 5, true);
		
		}
		
		public function AddTile(myTile:String,posX:int = 0, posY:int = 0, deltaX:int = 1, deltaY:int = 1):void
		{
			var _Idx:int;
			var _Impassable:Boolean;

			switch (myTile) 
			{
				case 'wall':
					_Idx = 12;
					_Impassable = true;
					break;
				case 'closeddoor':
					_Idx = 2;
					_Impassable = true;
					break;
				case 'opendoor':
					_Idx = 11;
					_Impassable = false;
					break;
				case 'statue':
					_Idx = 3;
					_Impassable = true;
					break;
				case 'floor':
					_Idx = 11;
					_Impassable = false;
					break;
				default: // default to wall
					_Idx = 12;
					_Impassable = true;
			}
			_tiles.setRect(posX, posY, deltaX, deltaY, _Idx);
			_grid.setRect(posX, posY, deltaX, deltaY, _Impassable);
/*
			startX = posX;
			startY = posY;
			if (delX == null) { 
				endX = startX;
			} else if (delX < startX) {
				startX = delX;
				endX = posX;
			} else { endX = delX; }
			
			if (delY == null) { 
				endY = startY;
			} else if (delY < startY) {
				startY = delY;
				endY = posY;
			} else { endY = delY; }
			for (var myX:int = startX; myX <= endX; myX++)
			{
				for (var myY:int = startY; myY <= endY; myY++)
				{
					_tiles.setRect(
				}
			}
			*/
			//_walls.push(new Wall(0, 0, 24, 0));
			//_tiles.loadFromString("12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12~12,11,11,11,11,11,11,11",",","~");			
/*			_tiles.setRect(0, 0, 25, 20, 12);
			_tiles.setRect(1, 1, 23, 18, 11);
			
			_tiles.setRect(3, 3, 3, 5, 12);
			_tiles.setTile(12, 5, 12);

			
			
		//	_grid.setRect(0, 0, 25, 20, true);
	//		_grid.setRect(1, 1, 23, 18, false);
			_grid.setRect(3, 3, 3, 5, true);
			_grid.setTile(12, 5, true);
			
			type = 'maze';*/
		}
		
	}

}