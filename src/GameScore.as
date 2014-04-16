package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Vaevictus
	 */
	public class GameScore extends Entity 
	{
		private var _score:int = 0;
		
		public function GameScore(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			graphic = new Text("Score: 0");
			_score = 0;
			super(x, y, graphic, mask);
			name = "score";
		}
		
		public function AddPoints(points:int):void
		{
			_score += points;
			Text(graphic).text = "Score: " + _score.toString();
		}
		
		public function ChangeMessage(msg:String):void
		{
			Text(graphic).text = msg;
		}
		
		public function destroy():void
		{
			graphic = null;
		}
	}

}