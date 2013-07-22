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
		
		static public function getCreepProperties(type:String):Object
		{
			var properties : Object = new Object;
			//.attribute("type")
			
			for each(var creepAttributeNode : XML in units.creep.(@type == type).children()) 
			{
				var attributeName  : String = creepAttributeNode.localName();
				var attributeValue : Object = creepAttributeNode.attribute("value");
				properties[attributeName] = attributeValue;
			}
			
			return properties;
		}
		
		static public function getTowerTypes(tier:uint = -1):Vector.<String> 
		{
			var towerTypes : Vector.<String> = new Vector.<String>;
			
			var towers : Object = units.tower;
			
			if (tier != -1) {
				towers = units.tower.(@tier == tier);
			}
			
			for each(var tower : XML in towers) 
			{
				var towerType : String = tower.attribute("type");
				towerTypes.push(towerType);
			}
			
			return towerTypes;
		}
		
		static public function getTowerProperties(type: String, level:uint):Object 
		{
			var properties : Object = new Object;
			
			trace(units.tower.(@type == type).level.(@num == level.toString()).children());
			
			for each(var towerAttributeNode : XML in units.tower.(@type == type).level.(@num == level.toString()).children())
			{
				var attributeName  : String = towerAttributeNode.localName();
				var attributeValue : Object = String(towerAttributeNode.attribute("value"));
				properties[attributeName] = attributeValue;
			}
			
			return properties;
		}
	}
}