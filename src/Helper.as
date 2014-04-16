package  
{
	/**
	 * ...
	 * @author Vaevictus
	 */
	public class Helper 
	{
		
		public function Helper() 
		{
			
		}
		
		public function directionToX(dir:int):int
		{
			if (dir == 1) { return 1; }
			else if (dir == 3) { return -1; }
			else { return 0; }
		}
		
		public function directionToY(dir:int):int
		{
			if (dir == 3) { return 0; }
			else { return dir - 1; }
		}
		
		public function xyToDirection(x:int, y:int, facing:int=0):int
		{
			if (x == 0) { return y + 1; }
			else if (y == 0) { return (x + 4) % 4; }
			else { 
				// diagonal
				if (directionToX(facing) == 0 ) { // if facing is vertical
					return (x + 4) % 4; // favor horizontal
				} else {
					return y + 1; // favor vertical
				}
			}
		}
	}

}