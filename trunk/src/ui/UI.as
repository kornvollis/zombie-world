package ui
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;	
	import mvc.GameModel;
	import ui.GameInterface;
	import ui.MapMaker;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class UI extends MovieClip 
	{			
		public static const MAP_MAKER : String = "mapmaker";
		public static const GAME_PLAY : String = "GAME_PLAY";
		public static var mapMaker : MapMaker;
		
		public static var gameInterface : GameInterface;
		private static var hammerButton :  HammerButton = new HammerButton();
		private static var _state : String = GAME_PLAY;
		
		private static var model : GameModel;
		
		public function UI(model : GameModel) 
		{
			UI.model = model;
			gameInterface = new GameInterface(model);
			mapMaker = new MapMaker(model);
			
			hammerButton.y = 3;
			hammerButton.x = 725;			
			//GAMEPANEL
			gameInterface.y = 605;
			gameInterface.x = 5;
			//gameInterface.block_button.label = "Box (" + model.blockers + ")";

			
			if (_state == MAP_MAKER)
			{
				hammerButton.visible = false;
				gameInterface.visible = false;
			} else if (_state == GAME_PLAY)
			{
				mapMaker.visible = false;
				hammerButton.visible = true;
				gameInterface.visible = true;
			}
			
			//EVENT LISTENERS
			UI.hammerButton.addEventListener(MouseEvent.CLICK, onHammerClick);
			model.addEventListener(GameEvents.COIN_CHANGED, updateMoney);
			
			addChild(mapMaker);
			addChild(hammerButton);
			//addChild(gameInterface);
		}
		
		private function updateMoney(e:GameEvents):void 
		{
			UI.gameInterface.cash_label.text = "Cash: " + model.money;
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
				gameInterface.visible = false;
				mapMaker.visible = true;
			} else if (value == GAME_PLAY && _state == MAP_MAKER) {
				mapMaker.visible = false;
				hammerButton.visible = true;
				gameInterface.visible = true;
			}
			
			_state = value;
		}
		
	}
}