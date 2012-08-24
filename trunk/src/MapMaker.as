package  
{
	import fl.controls.Slider;
	import fl.data.SimpleCollectionItem;
	import fl.events.SliderEvent;
	import fl.motion.Motion;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import levels.SpawnPoint;
	import mvc.GameModel;
	/**
	 * ...
	 * @author OML!
	 */
	public class MapMaker extends GameObject 
	{
		static public const IDLE : String = "idle";
		static public const SPAWN_POINT_CREATOR:String = "spawnPointCreator";
		
		static private var _state : String = IDLE;
		private var creatorGui : MapCreator = new MapCreator();
		private var mapMakerPanel : MapMakerPanel = new MapMakerPanel();
		private var model : GameModel;
		
		private var waveNum : int = 0;
		
		private var spawnPoints : Vector.<SpawnPoint> = new Vector.<SpawnPoint>();
		
		public function MapMaker(model : GameModel) 
		{
			this.model = model;
			creatorGui.y = 600;
			mapMakerPanel.x = 730;
			addChild(creatorGui);
			addChild(mapMakerPanel);
			
		
			//TEMP STUFF
			addNewSpawnPoint(20, 20);
			
			
			//INTI SELECTION
			model.buildTowerClass = PointDefense;
			model.spawnEnemyClass = BasicEnemy;
			
			
			//DENSITY
			mapMakerPanel.density_input.text =  mapMakerPanel.spawn_density.value.toString();
			
			//POPULATE TOWER COMBO BOX
			creatorGui.add_tower_combo.addItem( { label: "Point defense", data: PointDefense } );
			creatorGui.add_tower_combo.addItem( { label: "Cannon tower", data: Cannon } );
			
			//POPULATE ENEMY COMBO BOX
			creatorGui.add_enemy_combo.addItem( { label: "Basic enemy", data: BasicEnemy} );
			creatorGui.add_enemy_combo.addItem({ label: "Cannon tower", data: Cannon});
			
			mapMakerPanel.enemy_type.addItem( { label: "Basic enemy", data: BasicEnemy } );
			
			
////////////LISTENERS///////////////////////////////////////////////////////////////////////////
			//STAGE CLICK
			model.myStage.addEventListener(MouseEvent.CLICK, onStageClick);

			//DENSITY
			mapMakerPanel.spawn_density.addEventListener(SliderEvent.CHANGE, onDenistySliderChange);
			mapMakerPanel.density_input.addEventListener(KeyboardEvent.KEY_DOWN, onDensityInputKeyDown);
			
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
			
			
			//RIGHT COLUMN
			mapMakerPanel.add_wave.addEventListener(MouseEvent.CLICK, addWave);
			mapMakerPanel.remove_wave.addEventListener(MouseEvent.CLICK, removeWave);
			
			mapMakerPanel.new_spawn.addEventListener(MouseEvent.CLICK, onNewSpawnPointButton);
			
			//EVENT LISTENERS
			//COIN CHANGED
			this.model.addEventListener(GameEvents.COIN_CHANGED, coinChanged);
			Factory.getInstance().addEventListener(GameEvents.UI_MESSAGE, messageArrived);
		}
		
		private function onDensityInputKeyDown(e:KeyboardEvent):void 
		{
			// if the key is ENTER
		   if (e.charCode == 13) {
				var denisity : int  = int(mapMakerPanel.density_input.text);
				
				if (denisity > 200) {
					denisity = 200;
					mapMakerPanel.density_input.text = "200";
				}
			    
				mapMakerPanel.spawn_density.value = int(mapMakerPanel.density_input.text);
		   }
		}
		
		private function onDenistySliderChange(e:SliderEvent):void 
		{
			mapMakerPanel.density_input.text = e.value.toString();
		}
		
		private function onNewSpawnPointButton(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.IDLE;
			
			MapMaker.state = SPAWN_POINT_CREATOR;
		}
		
		private function onStageClick(e:MouseEvent):void 
		{
			var row : int = e.stageY / Constants.CELL_SIZE;
			var col : int = e.stageX / Constants.CELL_SIZE;
			
			if (row >= 0 && row < Constants.ROW_NUM && col >= 0 && col < Constants.COL_NUM)
			{
				if(MapMaker.state == SPAWN_POINT_CREATOR)
				{
					//trace("row: " + row + " col: " + col);
					addNewSpawnPoint(row, col);
					MapMaker.state = IDLE;
				}
			}
		}
		
		private function addNewSpawnPoint(row:Number, col:Number):void 
		{
			var newSpawnPoint : SpawnPoint = new SpawnPoint(row, col);
			
			if (!isExsistingSpawnPoint(newSpawnPoint))
			{
				spawnPoints.push(newSpawnPoint);
				addChildAt(newSpawnPoint,0);
				addChildAt(newSpawnPoint.label,1);
				
				mapMakerPanel.spawn_points.addItem({ label: "R/C: "  + row + "/" + col, data: newSpawnPoint })
			}
		}
		
		private function isExsistingSpawnPoint(newSpawnPoint:SpawnPoint):Boolean
		{
			var isExsisting : Boolean = false;
			
			for each (var item: SpawnPoint in spawnPoints) 
			{
				if (item.row == newSpawnPoint.row && item.col == newSpawnPoint.col)
				{
					isExsisting = true;
					break;
				}
			}
			
			return isExsisting;
		}
		
		private function removeWave(e:MouseEvent):void 
		{
			var selectedItem : Object = mapMakerPanel.waves.selectedItem;
			if (selectedItem != null)
			{				
				mapMakerPanel.waves.removeItem(selectedItem);
				mapMakerPanel.waves.selectedItem = null;
				waveNum--;
			}
		}
		
		private function addWave(e:MouseEvent):void 
		{
			//var startMoney : int = int(mapMakerPanel.money.text);
			var spawnTime : int = int(mapMakerPanel.spawn_start.text);
			var numOfEnemies : int = int(mapMakerPanel.spawn_num.text);
			var denisty : int = int(mapMakerPanel.density_input.text);
			var spawnPoint : SpawnPoint = SpawnPoint(mapMakerPanel.spawn_points.selectedItem.data);
			
			if (spawnTime >= 0 && numOfEnemies > 0 && spawnPoint != null)
			{
				mapMakerPanel.waves.addItem( { label: "S.Time: " + spawnTime + " NoE: " + numOfEnemies + " D: " + denisty +   " SP: " + spawnPoint.toString() , data: "kókusz" } );
				waveNum++;
			}
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
		
		static public function get state():String 
		{
			return _state;
		}
		
		static public function set state(value:String):void 
		{
			_state = value;
		}
		
	}

}