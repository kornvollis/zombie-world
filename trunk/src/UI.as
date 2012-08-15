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
		private var model : GameModel;
		private var creatorGui : MapCreator = new MapCreator();
		private var mapMakerPanel : MapMakerPanel = new MapMakerPanel();
		
		
		public function UI(model : GameModel) 
		{
			this.model = model;
			creatorGui.y = 600;
			mapMakerPanel.x = 730;
			addChild(creatorGui);
			addChild(mapMakerPanel);
			
			//INTI SELECTION
			model.buildTowerClass = PointDefense;
			model.spawnEnemyClass = BasicEnemy;
			
			
			//POPULATE TOWER COMBO BOX
			creatorGui.add_tower_combo.addItem( { label: "Point defense", data: PointDefense } );
			creatorGui.add_tower_combo.addItem( { label: "Cannon tower", data: Cannon } );
			
			//POPULATE ENEMY COMBO BOX
			creatorGui.add_enemy_combo.addItem( { label: "Basic enemy", data: BasicEnemy} );
			creatorGui.add_enemy_combo.addItem({ label: "Cannon tower", data: Cannon});
			
////////////LISTENERS///////////////////////////////////////////////////////////////////////////
			creatorGui.add_tower.addEventListener(MouseEvent.CLICK, addTowerClick);
			//Turret combo box change
			creatorGui.add_tower_combo.addEventListener(Event.CHANGE, towerSelect);
			
			//Enemy combo box change
			creatorGui.add_enemy_combo.addEventListener(Event.CHANGE, enemySelect);
			
			//Build block clicked
			creatorGui.build_block.addEventListener(MouseEvent.CLICK, addWallClick)
			
			//Spawn Enemy
			creatorGui.add_enemy.addEventListener(MouseEvent.CLICK, addEnemy);
			
			//Remove block 
			creatorGui.remove_block.addEventListener(MouseEvent.CLICK, removeBlockKick);
			
			//Sell tower
			creatorGui.sell_tower.addEventListener(MouseEvent.CLICK, sellTowerClick);
			
			//EVENT LISTENERS
			//COIN CHANGED
			this.model.addEventListener(GameEvents.COIN_CHANGED, coinChanged);
			Factory.getInstance().addEventListener(GameEvents.UI_MESSAGE, messageArrived);
			
			
			/*
			addZombieButton.addEventListener(MouseEvent.CLICK, addZombieClick);
			addWallButton.addEventListener(MouseEvent.CLICK, addWallClick);
			this.model.addEventListener(GameEvents.LIFE_LOST, lifeChanged);
			
			*/
		}
		
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
		
	}
}