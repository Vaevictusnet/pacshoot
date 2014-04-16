package  
{
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Vaevictus
	 */
	public class MazeWorld extends World 
	{
		private function pd(message:String):void
		{
			if (0)
			{
				trace(message);
			}
		}
		public function MazeWorld() 
		{
			super();
			add(new Mob(4*32+16,4*32+16));
			add(new Player(18*32+16,14*32+16));
			add(new Maze());
			add(new GameScore(8,6*32+16));
		}
		
		override public function update():void
		{
			super.update();
			GameLoop();
		}
		
		private function GameLoop():void
		{
			pd("Starting Game Loop");
			
			getPlayerMove();
			runMobs();
			
			pd("End Of Loop");
		}
		
		private function getPlayerMove():void
		{
			var player:Player;
			var players:Array = [];
			//players = getClass(Player, players);
			getClass(Player, players);
			
			if ( players == null )
			{
				//trace('no player in getPlayerMove()');
				return;
			}
			pd('had a player');
			player = players.pop();
			
		}
		
		public function runMobs():void
		{
			var mobs:Array = [];
			getClass(Mob, mobs);
			if ( mobs == null )
			{
				
				//trace('no player in getPlayerMove()');
				return;
			}
			
			pd("had at least one mob: " + mobs.length);
			/*for (var moob:Mob in mobs)
			{
				m.decideAndMove();
			}*/
		}
		
	}

}