package massdefense.assets 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.display.Button;
	import starling.display.Image;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		// LEVELS
		[Embed(source="images/levels/level_01.PNG")]
		public static const Level_01 : Class;
		
		// BORDER
		[Embed(source = "images/gui/border_small.png")]
		public static const BorderSmall : Class;
		[Embed(source = "images/gui/heart.png")]
		public static const Heart : Class;
		// BORDER
		
		// UI/TOWER_BUILD
		[Embed(source = "images/gui/tower_build/menu_arrow.png")]
		public static const MenuArrowUp : Class;
		[Embed(source = "images/gui/tower_build/tower_buy_border.png")]
		public static const TowerBuyBorder : Class;
		[Embed(source="images/gui/tower_build/tower_buy_panel.png")]
		public static const TowerBuilderBG : Class;
		[Embed(source = "images/gui/tower_build/menu_arrow_down.png")]
		public static const MenuArrowDown : Class;
		// UI/TOWER_BUILD
		
		// UI/TOWER
		[Embed(source = "images/gui/tower/tower_info.png")]
		public static const TowerInfo : Class;
		[Embed(source = "images/gui/tower/tower_item_box.png")]
		public static const TowerPropItem : Class;
		// UI/TOWER
		
		// BUTTONS
		[Embed(source="images/gui/buttons/button_base.png")]
		public static const BaseButton : Class;
		[Embed(source = "images/gui/timecontroll/play.png")]
		public static const PlayButton : Class;
		[Embed(source = "images/gui/timecontroll/pause.png")]
		public static const PauseButton : Class;
		[Embed(source = "images/gui/timecontroll/play_step.png")]
		public static const StepButton : Class;
		[Embed(source = "images/gui/buttons/button_sell.png")]
		public static const SellButton : Class;
		[Embed(source = "images/gui/buttons/button_upgrade.png")]
		public static const UpgradeButton : Class;
		// BUTTONS
		
		[Embed(source = "images/projectils/simple_bullet.png")]
		public static const SimpleBullet : Class;
		[Embed(source="images/projectils/bullet_01.PNG")]
		public static const Bullet01 : Class;
		// IMAGES/CREEPS
		[Embed(source = "images/creeps/cow.png")]
		public static const CreepCow : Class;
		[Embed(source="images/creeps/croco.png")]
		public static const CreepCroco : Class;
		[Embed(source = "images/creeps/deer.png")]
		public static const CreepDeer : Class;
		[Embed(source = "images/creeps/duck.png")]
		public static const CreepDuck : Class;
		[Embed(source = "images/creeps/giraffe.png")]
		public static const CreepGiraffe : Class;
		[Embed(source="images/creeps/goat.png")]
		public static const CreepGoat : Class;
		[Embed(source = "images/creeps/lion.png")]
		public static const CreepLion : Class;
		[Embed(source = "images/creeps/simple_enemy.PNG")]
		public static const SimpleEnemyBitmap : Class;
		// IMAGES/CREEPS
		
		
		[Embed(source = "images/blocks/block_01.png")]
		public static const Block01:Class;
		
		[Embed(source = "images/towers/base.png")]
		public static const BaseSprite:Class;
		
		// IMAGES/TOWERS
		[Embed(source = "images/towers/turret_01.png")]
		public static const TowerSprite01:Class;
		[Embed(source = "images/towers/turret_02.png")]
		public static const TowerSprite02:Class;
		[Embed(source = "images/towers/turret_03.png")]
		public static const TowerSprite03:Class;
		[Embed(source = "images/towers/laser_01.PNG")]
		public static const Laser01:Class;
		[Embed(source = "images/towers/cannon_01.PNG")]
		public static const Cannon01:Class;
		// IMAGES/TOWERS
		
		// IMAGES/PROJECTILS
		[Embed(source="images/projectils/laserBig.PNG")]
		public static const Laser : Class;
		// IMAGES/PROJECTILS
		[Embed(source = "images/exit/exit.png")]
		public static const ExitBitmap : Class;
		
		public static var gameTextures:Dictionary = new Dictionary();
		public static var gameTextureAtlas:TextureAtlas;
		
		//FONT
		[Embed(source="font/astera_font.fnt", mimeType="application/octet-stream")]
		public static const FontXml:Class;
		
		[Embed(source="font/astera_font_0.png")]
		public static const FontTexture:Class;
		
		/*
		[Embed(source="../media/graphics/mySpritesheet.png")]
		public static const AtlasTextureGame:Class;
		
		[Embed(source="../media/graphics/mySpritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas;
		}
		*/
		

		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name](); //Assets.name
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		public static function getImage(name:String):Image {
			var texture:Texture = getTexture(name);
			var image:Image = new Image(texture);
			
			return image;
		}
	}
}