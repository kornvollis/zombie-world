package massdefense.units 
{
	import massdefense.assets.Assets;
	import starling.display.Image;

	public class Units 
	{
		[Embed(source="../config/units.xml", mimeType = "application/octet-stream")] 
		private static const Units:Class;
		
		private static var units : XML = XML(new Units());
		
		public function Units() {}
		
		public static function getTowerTypes() : Vector.<String>
		{
			var towerTypes : Vector.<String> = new Vector.<String>;
			
			for each(var tower : XML in units.tower) 
			{
				var towerType : String = tower.attribute("type");
				towerTypes.push(towerType);
			}
			
			return towerTypes;
		}
		
		public static function getTowerCost(type:String) : int  
		{
			return int(units.tower.(@type == type).upgradeLevel.(@num == "1").cost);
		}
		
		public static function getTowerImage(type:String, level:int) : Image  
		{
			var imageName : String = units.tower.(@type == type).upgradeLevel.(@num == level.toString()).image;
			var image : Image = Assets.getImage(imageName);
			
			return image;
		}
			
		public static function getTowerFireType(type:String):String
		{
			return String(units.tower.(@type == type).fireType);
		}
		
		public static function getTowerMaxLevel(type:String) : int 
		{
			var tower:XMLList = units.tower.(@type == type).upgradeLevel;
			
			return tower.length();
		}
		
		public static function getTowerTypeAtUpgradeLevel(type:String, level:int) : XMLList 
		{
			var tower:XMLList = units.tower.(@type == type).upgradeLevel.(@num == level.toString()).children();
			
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
		
		static public function getTowerRange(type:String, level:int):int 
		{
			return int(units.tower.(@type == type).upgradeLevel.(@num == level.toString()).range);
		}
		
		static public function getTowerName(type:String):String
		{
			return String(units.tower.(@type == type).name);
		}
		
		static public function getTowerReloadTime(type:String, level:int):Number 
		{
			return Number(units.tower.(@type == type).upgradeLevel.(@num == level.toString()).reloadTime);
		}
	}
}