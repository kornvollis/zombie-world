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
		public static const MAP_MAKER : String = "mapmaker";
		public static const GAME_PLAY : String = "GAME_PLAY";
		public static var mapMaker : MapMaker;
		private static var hammerButton : HammerButton = new HammerButton();
		private static var _state : String = GAME_PLAY;
		
		private var model : GameModel;
		
		public function UI(model : GameModel) 
		{
			hammerButton.y = 3;
			hammerButton.x = 725;
			
			mapMaker = new MapMaker(model);
			
			if (_state == MAP_MAKER)
			{
				hammerButton.visible = false;
			} else if (_state == GAME_PLAY)
			{
				mapMaker.visible = false;
				hammerButton.visible = true;
			}
			
			UI.hammerButton.addEventListener(MouseEvent.CLICK, onHammerClick);
			
			addChild(mapMaker);
			addChild(hammerButton);
		}
		
		private function onHammerClick(e:MouseEvent):void 
		{
			state = MAP_MAKER;
		}
		
		static public function get state():String 
		{
			return _state;
		}
		
		static public function set state(value:String):void 
		{
			if (value == MAP_MAKER && _state == GAME_PLAY) {
				Factory.getInstance().removeAllEnemy();
				hammerButton.visible = false;
				mapMaker.visible = true;
			} else if (value == GAME_PLAY && _state == MAP_MAKER) {
				mapMaker.visible = false;
				hammerButton.visible = true;
			}
			
			_state = value;
		}
		/*
		private function messageArrived(e:GameEvents):void 
		{
			creatorGui.events_area.textField.text = creatorGui.events_area.textField.text + e.data + "\n";
		}
		
		private function coinChanged(e:GameEvents):void 
		{
			creatorGui.money_text.text = "Money: " + model.money.toString();
		}
		
		private function sellTowerClick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.SELL_TOWER;
		}
		
		private function removeBlockKick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.REMOVE_BLOCK;
		}
		
		private function enemySelect(e:Event):void 
		{
			model.spawnEnemyClass = Class(creatorGui.add_enemy_combo.selectedItem.data);
		}
		
		private function addEnemy(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.ZOMBIE_SPAWNER;
		}
		
		private function towerSelect(e:Event):void 
		{
			model.buildTowerClass = Class(creatorGui.add_tower_combo.selectedItem.data);
		}
		
		private function addTowerClick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.TURRET_BUILDER;
		}
		
		private function addWallClick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.WALL_BUILDER;
		}
		*/
	}
}