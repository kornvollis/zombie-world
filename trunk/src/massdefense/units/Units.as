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
		
		public static function getTowerMaxLevel(type:String) : int 
		{
			var tower:XMLList = units.tower.(@type == type).children();
			
			return tower.length();
		}
		
		public static function getTowerTypeAtUpgradeLevel(type:String, upgradeLevel:String) : XMLList 
		{
			var tower:XMLList = units.tower.(@type == type).upgradeLevel.(@num == upgradeLevel).children();
			
			return tower;
		}
		
		static public function getTowerUpgradeCost(type:String, level:int):int 
		{
			var tower:XMLList = units.tower.(@type == type).upgradeLevel.(@num == level.toString());
			
			return tower.cost;
		}
		
		static public function getTowerDamage(type:String, level:int):int 
		{
			var tower:XMLList = units.tower.(@type == type).upgradeLevel.(@num == level.toString());
			
			return tower.damage;
		}
	}

}