package massdefense.ui 
{
	import flash.display.Sprite;
	import massdefense.assets.Assets;
	import starling.display.Button;
	
	/**
	 * ...
	 * @author OMLI
	 */
	public class TowerUpgrade extends Sprite 
	{
		private var upgrade : Button = new Button(Assets.getImage("BaseButton"));
		
		
		public function TowerUpgrade() 
		{
			upgrade.width = 80;
			upgrade.height = 30;
			
			addChild(upgrade);
		}
		
	}

}