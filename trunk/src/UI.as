package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class UI extends MovieClip 
	{
		var addZombieButton   : ZButton = new ZButton();
		var addWallButton 	  : ZButton = new ZButton();
		var addSurvivorButton : ZButton = new ZButton();
		
		public function UI() 
		{
			addZombieButton.y = 430;
			addZombieButton.ztext.text = "Spawn zombie";
			
			addWallButton.y = 430;
			addWallButton.x = 150;
			addWallButton.ztext.text = "Create wall";
			
			addSurvivorButton.y = 430;
			addSurvivorButton.x = 300;
			addSurvivorButton.ztext.text = "Spawn survivor";
			
			addChild(addZombieButton);
			addChild(addSurvivorButton);
			addChild(addWallButton);
		}
		
	}

}