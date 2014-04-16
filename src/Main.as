package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Vaevictus
	 */
	public class Main extends Engine 
	{
		
		public function Main() 
		{
			super(800, 640, 60, false);
			FP.world = new MazeWorld;
			FP.console.enable();

		}
		

		override public function init():void 
		{
			trace("FP START");
		}
		
	}
	
}