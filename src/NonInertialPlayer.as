package  
{
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

		[Embed(source = "assets/player_left.png")] private const PLAYERGFX:Class;
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			graphic = new Image(PLAYERGFX);

			super(x, y, graphic, mask);
			setHitbox(32, 32, 0, 0);
			//setHitbox(30, 30, -1, -1);
			Input.define("MOVELEFT", Key.A, Key.LEFT);
			Input.define("MOVERIGHT", Key.D, Key.RIGHT);
			Input.define("MOVEUP", Key.W, Key.UP);
			Input.define("MOVEDOWN", Key.S, Key.DOWN);
			
		}
		
		private function move(dx:Number,dy:Number):void
		{
			// check for collision
			
			// adjust speed for inertia
			
			var adjustX:Number = speed * FP.elapsed;
			var adjustY:Number = speed * FP.elapsed;
			var factor:Number = 100;
			while ( adjustX > 0 && collide("maze", x + dx*adjustX, y)) {
				adjustX -= speed * FP.elapsed / factor;
			}
			while ( adjustY > 0 && collide("maze", x, y+ dy*adjustY)) {
				adjustY -= speed * FP.elapsed / factor;
			}
			if (adjustX < 0) { adjustX = 0; }
			if (adjustY < 0) { adjustY = 0; }
			//if (collide("maze", x, y + adjustY)) {
				//adjustY = 0;
			//}
			x += dx * adjustX;
			y += dy * adjustY;
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