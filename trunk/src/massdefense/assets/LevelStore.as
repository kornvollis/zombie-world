package massdefense.assets 
{
	import massdefense.level.Level;
	/**
	 * ...
	 * @author OMLI
	 */
	public class LevelStore 
	{
		// LEVELS
		[Embed(source="../config/levels/level01.xml", mimeType = "application/octet-stream")] 
		public static const Level_01:Class;
		
		private var levels : Array = new Array;
		
		public static function getLevel(index : uint):Level
		{
			var level : Level = new Level();
			
			
			return null;
		}
		
		public function LevelStore() 
		{
			
		}
		
	}

}