package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;

	
	/**
	 * ...
	 * @author Vaevictus
	 */
	public class Player extends Entity 
	{
		// 1500 fast
		// 1200 good without maze
		// 800
		private var speed:int = 300;
		private var _pacX:int = 0;
		private var _pacY:int = 0;

		//[Embed(source = "assets/player_left.png")] private const PLAYERGFX:Class;
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			//graphic = new Image(PLAYERGFX);
			graphic = new Image(Assets.SPRITE_TILESET,new Rectangle(320,64,32,32));
			name = "player";
			super(x, y, graphic, mask);
			graphic.x = -16;
			graphic.y = -16;
			setHitbox(32, 32, 16, 16);
			//setHitbox(30, 30, -1, -1);
			Input.define("MOVELEFT", Key.A, Key.LEFT);
			Input.define("MOVERIGHT", Key.D, Key.RIGHT);
			Input.define("MOVEUP", Key.W, Key.UP);
			Input.define("MOVEDOWN", Key.S, Key.DOWN);
			Input.define("SHOOT", Key.SPACE);
			
		}
		
		private function move(dx:Number,dy:Number):void
		{
			
			var slide:Number = speed * FP.elapsed;
			var movement:Number = slide;
			//var factor:Number = slide / 100;
			var factor:Number = 1;
			var tilesize:int = 16;
			var step:Number = 1;
			var collideX:Boolean = false;
			var collideY:Boolean = false;
			
			//if (_pacX == 0 && _pacY == 0) { trace("zeroed: " + dx + "," + dy); }
			
			if (_pacX != 0) {
				// horizontal inertia
				if (dx != 0) { _pacX = dx; }
				
				if(dy !=0) {
					while(movement >= 1){
						if (collide("maze", x, y + dy * movement))
						{
							moveTowards(x + _pacX * movement, y, step, "maze", false);
							movement -= step;
							collideY = true;
						} else {
							//
							moveTo(x, y + dy * movement);
							_pacX = 0;
							_pacY = dy;
							movement = 0;
						}
					}
				} else {
					moveBy(_pacX * movement, 0,"maze");
					// same direction/momentum only
					//if (collide("maze", x + _pacX * movement, y)) {
						//moveTowards(x + _pacX * movement, y, step, "maze", false);
						//_pacX = 0;
					//} else {
						//moveBy(_pacX * movement, 0);
					//}
					
				}
				
			} else if (_pacY != 0) 
			{
				// vertical inertia
				if (dy != 0) { _pacY = dy; }
				if(dx !=0) {
					while(movement >=1){
						if (collide("maze", x+dx*movement, y))
						{
							moveTowards(x, y + _pacY * movement, step, "maze", false);
							movement -= step;
						} else {
							//
							moveTo(x + dx * movement, y);
							_pacX = dx;
							_pacY = 0;
							movement = 0;
						}
					}
				} else {
					// same direction/momentum only
					moveBy(0, _pacY * movement, "maze");
					//if (collide("maze", x, y + _pacY * movement)) {
						//
						//moveTowards(x,y + _pacY * movement, step, "maze", false);
						//_pacY = 0;
					//} else {
						//moveBy(0,_pacY * movement);
					//}
				}
			} else {
				// movement from standstill
				if (dx != 0) {
					trace("moving from a standstill - X");
				
					// crappily only handle either horiz or vert
					if (! collide("maze", x + dx * movement, y)) {
						moveBy(dx * movement, 0);
						_pacX = dx;
						_pacY = 0;
					}
				}
				else if (dy != 0) {
					trace("moving from a standstill - Y");

					if (! collide("maze", x, y + dy * movement)) {
						_pacX = 0;
						_pacY = dy;
					}
				}
			}
			
			/*if (dx == 0) { dx = _pacX; }
			if (dy == 0) { dy = _pacY; }
			
			//moveBy(dx * movement, dy * movement,"maze");
			while (movement > 0) {
				var tmpX:Number = x;
				var tmpY:Number = y;
				

				moveTowards(x + dx * movement, y + dy * movement, factor, "maze", false);
				movement--;
				if (movement == 0 ) {
					_pacX = tmpX - x;
					_pacY = tmpY - y;
				}
			}*/
		}

			
		
		override public function update():void
		{
			updateMovement();
		}
		
		private function updateCollision():void
		{
			if (collide("maze", x, y)) {
				trace("Collision!");
			}
		}
		private function updateMovement():void
		{
			
			var dx:int = 0;
			var dy:int = 0;
			if (Input.check("MOVELEFT")) {
				dx = -1;
			}
			
			if (Input.check("MOVERIGHT")) {
				dx = 1;
			}
			
			if (Input.check("MOVEUP")) {
				dy = -1;
			}
			
			if (Input.check("MOVEDOWN")) {
				dy = 1;
			}
			move(dx, dy);
		}
	}

}