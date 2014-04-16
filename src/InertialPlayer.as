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
	public class InertialPlayer extends Entity 
	{
		// 1500 fast
		// 1200 good without maze
		// 800
		private var speed:int = 800;
		private var inertiaConstant:int = speed/3;
		private var inertiaX:Number = 0;
		private var inertiaY:Number = 0;
		
		[Embed(source = "assets/player_left.png")] private const PLAYERGFX:Class;
		public function InertialPlayer(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			graphic = new Image(PLAYERGFX);

			super(x, y, graphic, mask);
			//setHitbox(30, 30, 0, 0);
			setHitbox(30, 30, -1, -1);
			Input.define("MOVELEFT", Key.A, Key.LEFT);
			Input.define("MOVERIGHT", Key.D, Key.RIGHT);
			Input.define("MOVEUP", Key.W, Key.UP);
			Input.define("MOVEDOWN", Key.S, Key.DOWN);
			
		}
		
		private function move(dx:Number,dy:Number):void
		{
			// check for collision
			
			// adjust speed for inertia
			
			var adjustX:Number = dx * speed * FP.elapsed;
			var adjustY:Number = dy * speed * FP.elapsed;
			
			if (adjustX == 0 && inertiaX != 0) { smoothX(); }
			if (adjustY == 0 && inertiaY != 0) { smoothY(); }
			
			inertiaX += adjustX;
			inertiaY += adjustY;
			
			if (inertiaX >= inertiaConstant) { inertiaX = inertiaConstant; }
			if (inertiaX <= -inertiaConstant) { inertiaX = -inertiaConstant; }
			if (inertiaY >= inertiaConstant) { inertiaY = inertiaConstant; }
			if (inertiaY <= -inertiaConstant) { inertiaY = -inertiaConstant; }
			
/*			if (collide("maze", x +inertiaX * FP.elapsed , y)) {
				inertiaX = 0;
			}
			if (collide("maze", x,y +inertiaY * FP.elapsed )) {
				inertiaY = 0;
			}*/
			
			while (collide("maze", x + inertiaX * FP.elapsed, y) && inertiaX != 0 ) {
				inertiaX -= (Math.abs(inertiaX) / inertiaX)*FP.elapsed;
			}
			while (collide("maze", x, y + inertiaY * FP.elapsed) && inertiaY != 0 ) {
				inertiaY -= (Math.abs(inertiaY) / inertiaY)*FP.elapsed;
			}
			x += inertiaX * FP.elapsed;
			y += inertiaY * FP.elapsed;
		}
		
		private function smoothX():void {
			var sign:int = 1;
			if (inertiaX < 0) { sign = -1; }
			
			if ( inertiaX * sign > speed * FP.elapsed ) { inertiaX -= sign * speed * FP.elapsed; }
			else { inertiaX = 0; }
		}
		
		private function smoothY():void {
			var sign:int = 1;
			if (inertiaY < 0) { sign = -1; }
			
			if ( inertiaY * sign > speed * FP.elapsed ) { inertiaY -= sign * speed * FP.elapsed; }
			else { inertiaY = 0; }
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