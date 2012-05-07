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
		private var addTurretButton : ZButton = new ZButton();
		
		private var coins : ZButton = new ZButton();
	
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
			
			coins.y = 500;
			coins.ztext.text = "Coins: 0";
			
			addWallButton.y = 430;
			addWallButton.x = 150;
			addWallButton.ztext.text = "Create wall";
			
			addTurretButton.y = 430;
			addTurretButton.x = 300;
			addTurretButton.ztext.text = "Add turret";
			
			
			addChild(coins);
			addChild(lifeText);
			addChild(addZombieButton);
			addChild(addTurretButton);
			addChild(addWallButton);
			
			//LISTENERS
			
			addZombieButton.addEventListener(MouseEvent.CLICK, addZombieClick);
			addWallButton.addEventListener(MouseEvent.CLICK, addWallClick);
			addTurretButton.addEventListener(MouseEvent.CLICK, addTurretClick);
			this.model.addEventListener(GameEvents.LIFE_LOST, lifeChanged);
			this.model.addEventListener(GameEvents.COIN_CHANGED, coinChanged);
		}
		
		private function coinChanged(e:GameEvents):void 
		{
			coins.ztext.text = "Coins: " + model.coins;
		}
		
		private function addTurretClick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.TURRET_BUILDER;
		}
		
		private function lifeChanged(e: GameEvents):void 
		{
			trace("UI: Szevasz");
			lifeText.ztext.text = "Life: " + e.data;
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