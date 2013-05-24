package massdefense.units 
{
	/**
	 * ...
	 * @author OMLI
	 */
	public class Units 
	{
		[Embed(source="../config/units.xml", mimeType = "application/octet-stream")] 
		private static const Units:Class;
		
		private static var units : XML = XML(new Units());
		
		public function Units() 
		{
			
		}
		
		public static function getTowerCost(type:String) : int  
		{
			return int(units.tower.(@type == type).upgradeLevel.(@num == "1").cost);
		}
		
		public static function getTowerTypeAtUpgradeLevel(type:String, upgradeLevel:String) : XMLList 
		{
			var tower:XMLList = units.tower.(@type == type).upgradeLevel.(@num == upgradeLevel).children();
			
			return tower;
		}
	}

}