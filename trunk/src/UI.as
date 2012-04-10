package  
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;	
	import mvc.GameModel;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class UI extends MovieClip 
	{		
		private var addZombieButton   : ZButton = new ZButton();
		private var addWallButton 	  : ZButton = new ZButton();
		private var addSurvivorButton : ZButton = new ZButton();
	
		private var model : GameModel = null;
		
		private var lifeText : ZButton = new ZButton();
		
		//var lifeLabel : Label
		
		public function UI(model : GameModel) 
		{
			this.model = model;
			
			lifeText.y = 430;
			lifeText.x = 450;
			//lifeText.ztext.text = "Life: " + GameModel.life;
			
			addZombieButton.y = 430;
			addZombieButton.ztext.text = "Spawn zombie";
			
			addWallButton.y = 430;
			addWallButton.x = 150;
			addWallButton.ztext.text = "Create wall";
			
			addSurvivorButton.y = 430;
			addSurvivorButton.x = 300;
			addSurvivorButton.ztext.text = "Spawn survivor";
			
			addChild(lifeText);
			addChild(addZombieButton);
			addChild(addSurvivorButton);
			addChild(addWallButton);
			
			//LISTENERS
			addZombieButton.addEventListener(MouseEvent.CLICK, addZombieClick);
			addWallButton.addEventListener(MouseEvent.CLICK, addWallClick);
			addSurvivorButton.addEventListener(MouseEvent.CLICK, addSurvivorClick);
			this.model.addEventListener(GameEvents.LIFE_LOST, lifeChanged);
		}
		
		private function lifeChanged(e: GameEvents):void 
		{
			trace("UI: Szevasz");
			lifeText.ztext.text = "Life: " + e.data;
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