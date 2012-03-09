package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
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
			
			//LISTENERS
			addZombieButton.addEventListener(MouseEvent.CLICK, addZombieClick);
			addWallButton.addEventListener(MouseEvent.CLICK, addWallClick);
			addSurvivorButton.addEventListener(MouseEvent.CLICK, addSurvivorClick);
		}
		
		private function addSurvivorClick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.SURVIVOR_SPAWNER;
		}
		
		private function addWallClick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.WALL_BUILDER;
		}
		
		private function addZombieClick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.ZOMBIE_SPAWNER;
		}
		
	}

}