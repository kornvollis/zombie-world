package assets 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.display.Button;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		//Graphics
		[Embed(source = "../../media/towers/base.png")]
		private static const BaseSprite:Class;
		
		[Embed(source = "../../media/towers/turret_01.png")]
		private static const TowerSprite01:Class;
		
		[Embed(source = "../../media/exit/exit.png")]
		private static const ExitBitmap : Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		//FONT
		[Embed(source = "fonts/Astera.ttf", embedAsCFF="false", fontFamily="Astera")]
		private static const MyFont : Class;
		
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
		
		public static function getFont() : Object {
			return new MyFont();
		}

		
		public static function getTexture(name:String):Texture
		{
			var button : Button
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
	}
}