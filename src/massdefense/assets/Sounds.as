package massdefense.assets 
{
	import flash.media.Sound;
	[Embed(source = "sounds/aa_fire.mp3")]
	public static const AAfire : Class;
	
	public class Sounds 
	{
		public var fireSound : Sound = new AAfire();
		
		private var instance : Sounds = null;
		
		public function Sounds() 
		{
			instance = this;
		}
		
	}

}