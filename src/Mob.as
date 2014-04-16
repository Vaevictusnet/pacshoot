package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
//	import Helper;
	
	/**
	 * ...
	 * @author Vaevictus
	 */
	public class Mob extends Entity 
	{

		[Embed(source = "assets/red_left.png")] private const GENERICMOBGFX:Class;
		private var _pacX:Number = 0;
		private var _pacY:Number = 0;
		private var _aimode:int = 0;
		private var speed:int = 300;
		private var facing:int = 3; // 0=> up, 1=> right, 2=> down, 3 => left;
		protected var animatedSprite:Spritemap;// = new Spritemap(Assets.RED_MOB, 32, 32);
		
		public function Mob(x:Number=0, y:Number=0, AImode:int = 0, graphic:Graphic=null, mask:Mask=null) 
		{
			animatedSprite = new Spritemap(Assets.RED_MOB, 32, 32);
			_aimode = AImode;
			graphic = animatedSprite;
			animatedSprite.setFrame(facing);
			graphic.x = -16;
			graphic.y = -16;
			setHitbox(32, 32, 16, 16);
			super(x, y, graphic, mask);
		}
		
		override public function update():void 
		{
			decideAndMove();
		}
		
		public function decideAndMove():void
		{
			trace("Mob deciding and moving");
			var target:Player = FP.world.getInstance("player"); // different target for different aimodes
			
			var decX:Number = (target.x - x)/Math.max(Math.abs(target.x - x),Math.abs(target.y-y));
			var decY:Number = (target.y - y) / Math.max(Math.abs(target.x - x), Math.abs(target.y - y));
			
			move(decX, decY);
		}

		public function move(decX:Number = 0, decY:Number = 0):void
		{
			//var slide:Number = speed * FP.elapsed;
			//var movement:Number = slide;
			//var factor:Number = slide / 100;
			//var factor:Number = 1;
			//var tilesize:int = 16;
			//var step:Number = 1;
			
			var H:Helper = new Helper;
			
			// major (square) vector
			var desiredDirection:int = 0;
			var dx:int = 0;
			var dy:int = 0;
			
			// minor vector
			var mvx:int = 0;
			var mvy:int = 0;
			var minorVector:int = 0;
			
			// truncate input to 8 directions
			if (decX == 1 || decX == -1) { dx = decX; }
			if (decY == 1 || decY == -1) { dy = decY; }
			
			//trace(" solving direction: " + dx + "," + dy + "," + facing + " -> " + H.xyToDirection(dx, dy, facing));
			desiredDirection = H.xyToDirection(dx, dy, facing);
			
			animatedSprite.setFrame(desiredDirection); // look towards player :D
			
			if ( decX < 0 ) { mvx = -1; }
			else if ( decX > 0 ) { mvx = 1; }
			
			if (decY < 0 ) { mvy = -1; }
			else if ( decY > 0 ) { mvy = 1; }
			
			minorVector = H.xyToDirection(mvx, mvy, desiredDirection);
			trace( "facing: " + facing + " | dd:" + dx + "," + dy + "," + facing + " -> " + H.xyToDirection(dx, dy, facing) + " | mv: " + minorVector + " => " + mvx + "," + mvy );
			
		}
		
		
		
		
		
		
		public function byberasedf(decX:Number = 0, decY:Number = 0):void
		{
			var desiredDirection:int = 0;
			var dx:int = 0;
			var dy:int = 0;
			var slide:Number = speed * FP.elapsed;
			var movement:Number = slide;
			//var factor:Number = slide / 100;
			var factor:Number = 1;
			var tilesize:int = 16;
			var step:Number = 1;
			// dx & dy are on the square vector at this point, in cardinal directions
			
			var facingReverse:int = (facing + 2) % 4; // for ease
						
			// should perfect 45 degree preference favor change?
			// -- desiredDirection: turn this way when possible ( not reverse )
			// -- desiredDirection = facing: turn minor vector when required
			// ---- or opposite minor vector if forced
			
			if (facing % 2 == 0) {
				// facing is vertical
				if (dx != 0) { desiredDirection = 2 - dx; } // favor horizontal for diagonal tie
			//	else if ( 
				else if ( decY == 0 ) { return; }	// error situation, no vector to player
				else { desiredDirection = 1 + ( decY / Math.abs(decY)); }
			} else {
				// facing is horizontal
				if (dy != 0) { desiredDirection = 1 + dy; }
				else if ( decX == 0 ) { return; }	// error situation, no vector to player
				else { desiredDirection = 2 - ( decX / Math.abs(decX)); }
			}
			
//			trace( " facing: " + facing + ", desired: " + desiredDirection);
			if ( desiredDirection == facingReverse ) {
//				trace("BUT CANT!");
				desiredDirection = (facing + 1) % 4; // favor clockwise turn -- not sure i like this
				//AI OPTION
			}
			animatedSprite.setFrame(desiredDirection);
			
			
			//if (_pacX == 0 && _pacY == 0) { trace("zeroed: " + dx + "," + dy); }
			
			if (_pacX != 0) {
				// horizontal inertia
				
				// no rversing 
				// if (dx != 0) { _pacX = dx; }
				
				if(dy !=0) { // requesting vertical change
					while(movement >= 1){
						if (! collide("maze", x, y + dy * movement))
						{
						// move vert if not collide vert
							moveTo(x, y + dy * movement);
							_pacX = 0;
							_pacY = dy;
							movement = 0;
						}
						else if (! collide("maze", x + _pacX * movement, y))
						{
						// move horiz if not collide horiz
							moveTo(x, y + dy * movement);
							
						}
						else 
						{
						// move -vert if cornered
						}
						
						
						/*	moveBy(x + _pacX * movement, y, step, "maze", false);
							movement -= step;
							collideY = true;
						} 
						else if (collide("maze", x, y + dy * movement))
						{
							moveBy(x + _pacX * movement, y, step, "maze", false);
							movement -= step;
							collideY = true;
						} 
						else {
							// move vert if not collide vert
							moveTo(x, y + dy * movement);
							_pacX = 0;
							_pacY = dy;
							movement = 0;
						*/
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
				// no reversing 
				// if (dy != 0) { _pacY = dy; }
				
				
				if(dx !=0) { // requested horizontal
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

		}
		
	}

}