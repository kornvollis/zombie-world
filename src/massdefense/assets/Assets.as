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
		
		// UI/TOWER
		[Embed(source = "images/gui/tower/tower_prop.png")]
		public static const TowerProp : Class;
		[Embed(source = "images/gui/tower/tower_item_box.png")]
		public static const TowerPropItem : Class;
		// UI/TOWER
		
		// BUTTONS
		[Embed(source = "images/gui/buttons/buy.png")]
		public static const BuyButton : Class;
		[Embed(source="images/gui/buttons/button_base.png")]
		public static const BaseButton : Class;
		[Embed(source = "images/gui/timecontroll/play.png")]
		public static const PlayButton : Class;
		[Embed(source = "images/gui/timecontroll/pause.png")]
		public static const PauseButton : Class;
		[Embed(source = "images/gui/timecontroll/play_step.png")]
		public static const StepButton : Class;
		[Embed(source="images/gui/buttons/default-button.png")]
		public static const ButtonDefaultBM:Class;
		[Embed(source = "images/gui/buttons/build-button.png")]
		public static const ButtonBuildBM:Class;
		[Embed(source = "images/gui/buttons/delete-button.png")]
		public static const ButtonDeleteBM:Class;
		[Embed(source = "images/gui/buttons/small-icon.png")]
		public static const ButtonSmallIcon:Class;
		[Embed(source = "images/gui/buttons/wide-button.png")]
		public static const ButtonWide:Class;
		// BUTTONS
		
		[Embed(source = "images/projectils/simple_bullet.png")]
		public static const SimpleBullet : Class;
		
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
		
		[Embed(source = "images/gui/popup.png")]
		public static const PopUp:Class;
		
		[Embed(source = "images/towers/base.png")]
		public static const BaseSprite:Class;
		
		// IMAGES/TOWERS
		[Embed(source = "images/towers/turret_01.png")]
		public static const TowerSprite01:Class;
		[Embed(source = "images/towers/turret_02.png")]
		public static const TowerSprite02:Class;
		[Embed(source = "images/towers/turret_03.png")]
		public static const TowerSprite03:Class;
		// IMAGES/TOWERS
		
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