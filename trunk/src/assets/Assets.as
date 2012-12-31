package assets 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.display.Button;
	import starling.display.Image;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		// BUTTONS
		[Embed(source="../../media/gui/buttons/default-button.png")]
		public static const ButtonDefaultBM:Class;
		
		[Embed(source = "../../media/gui/buttons/build-button.png")]
		public static const ButtonBuildBM:Class;
		
		[Embed(source = "../../media/gui/buttons/delete-button.png")]
		public static const ButtonDeleteBM:Class;
		
		[Embed(source = "../../media/gui/buttons/small-icon.png")]
		public static const ButtonSmallIcon:Class;
		
		[Embed(source = "../../media/gui/buttons/wide-button.png")]
		public static const ButtonWide:Class;
		
		// BLOCKS
		[Embed(source = "../../media/blocks/block_01.png")]
		public static const Block01:Class;
		
		[Embed(source = "../../media/gui/popup.png")]
		public static const PopUp:Class;
		
		[Embed(source = "../../media/towers/base.png")]
		public static const BaseSprite:Class;
		
		[Embed(source = "../../media/towers/turret_01.png")]
		public static const TowerSprite01:Class;
		
		[Embed(source = "../../media/exit/exit.png")]
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