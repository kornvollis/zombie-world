package ui
{
	import fl.controls.Slider;
	import fl.data.SimpleCollectionItem;
	import fl.events.SliderEvent;
	import fl.motion.Motion;
	import flash.display.Loader;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import levels.LevelData;
	import levels.Wave;
	import mapMaker.FileManager;
	import screens.GameScreen;
	import units.Enemy;
	
	import flash.display.DisplayObject;
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
		private var creatorGui : MapCreator = new MapCreator();
		private var mapMakerPanel : MapMakerPanel = new MapMakerPanel();
		private var model : GameModel;
		private var gameScreen : GameScreen;
		
		
		private var waveNum : int = 0;
		
		private var spawnPoints : Vector.<SpawnPoint> = new Vector.<SpawnPoint>();
		private var waves : Vector.<Wave> = new Vector.<Wave>();
			
		private var levelData : LevelData = new LevelData();
		private var fileReader:FileReference = new FileReference();
		
		private	var fileManager:FileManager = new FileManager();
		
		private var buildTowerClass : Class = PointDefense;
		private var	spawnEnemyClass : Class = BasicEnemy;
		public function MapMaker(model : GameModel, gameScreen : GameScreen) 
		{			
			this.gameScreen = gameScreen;
			this.model = model;
			creatorGui.y = 600;
			mapMakerPanel.x = 730;
			addChild(creatorGui);
			addChild(mapMakerPanel);
			
			//DENSITY
			mapMakerPanel.delay_input.text =  mapMakerPanel.spawn_density.value.toString();
			
			//POPULATE TOWER COMBO BOX
			creatorGui.add_tower_combo.addItem( { label: "Point defense", data: PointDefense } );
			creatorGui.add_tower_combo.addItem( { label: "Cannon tower", data: Cannon } );
			
			//POPULATE ENEMY COMBO BOX
			creatorGui.add_enemy_combo.addItem( { label: "Basic enemy", data: BasicEnemy} );
			creatorGui.add_enemy_combo.addItem({ label: "Cannon tower", data: Cannon});
			
			mapMakerPanel.enemy_type.addItem( { label: "Basic enemy", data: BasicEnemy } );
			
			//LISTENERS///////////////////////////////////////////////////////////////////////////
			addEventlisteners();
		}
		
		private function addEventlisteners():void 
		{
			//STAGE CLICK
			gameScreen.addEventListener(MouseEvent.CLICK, onGameScreenClick);
			
			//DENSITY
			mapMakerPanel.spawn_density.addEventListener(SliderEvent.CHANGE, onDenistySliderChange);
			mapMakerPanel.delay_input.addEventListener(KeyboardEvent.KEY_DOWN, onDensityInputKeyDown);
			
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
			
			//START BUTTON CLICK
			mapMakerPanel.startMap_button.addEventListener(MouseEvent.CLICK, onStartMapClick);
			
			//LOAD BUTTON CLICK
			mapMakerPanel.load_button.addEventListener(MouseEvent.CLICK, onLoadClick);
			
			//SAVE BUTTON CLICK
			mapMakerPanel.save_button.addEventListener(MouseEvent.CLICK, onSaveClick);
			
			//RIGHT COLUMN
			mapMakerPanel.add_wave.addEventListener(MouseEvent.CLICK, addWave);
			mapMakerPanel.remove_wave.addEventListener(MouseEvent.CLICK, removeWave);
			mapMakerPanel.remove_spawn.addEventListener(MouseEvent.CLICK, onRemoveSpawnPointClick);
			mapMakerPanel.new_spawn.addEventListener(MouseEvent.CLICK, onNewSpawnPointButton);
			mapMakerPanel.edit_button.addEventListener(MouseEvent.CLICK, onEditClick);
			mapMakerPanel.addExit_button.addEventListener(MouseEvent.CLICK, onAddExit);
			mapMakerPanel.removeExit_button.addEventListener(MouseEvent.CLICK, onRemoveExit);
			
			//FILE MANAGER
			fileManager.addEventListener(Event.COMPLETE, mapLoaded);
			
			//EVENT LISTENERS
			//COIN CHANGED
			this.model.addEventListener(GameEvents.COIN_CHANGED, coinChanged);
		}
		
		private function processLevelData(levelData : LevelData) : void
		{			
			
		}
		
		private function onSaveClick(e:MouseEvent):void 
		{
			fileManager.saveFile();
		}
		
		private function onLoadClick(e:MouseEvent):void 
		{
			fileManager.loadFile();
		}
		
		private function mapLoaded(e:Event):void 
		{
			var levelData : LevelData = fileManager.getLevel();
		}
		
		private function onRemoveExit(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.REMOVE_EXIT;
		}
		
		private function onAddExit(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.ADD_EXIT;
		}
		
		private function onStartMapClick(e:MouseEvent):void 
		{
			UI.state = UI.GAME_PLAY;
			
			model.money = int(mapMakerPanel.money.text);
			
			//START ALL WAVE TIMERS
			for each (var wave: Wave in  waves) 
			{			
				wave.start();
			}
			
		}
		
		private function onEditClick(e:MouseEvent):void 
		{

			var selectedWave : Wave = Wave(mapMakerPanel.waves.selectedItem);
			if (selectedWave != null)
			{
				
				var spawnTime : int = int(mapMakerPanel.spawn_start.text);
				var numOfEnemies : int = int(mapMakerPanel.spawn_num.text);
				var delay : int = int(mapMakerPanel.delay_input.text);
				var enemy : Class = Enemy;
				var spawnPoint : SpawnPoint = SpawnPoint(mapMakerPanel.spawn_points.selectedItem);
				
				if(spawnTime > 0 && numOfEnemies > 0 && delay > 0 && enemy != null && spawnPoint != null)
				{
					trace("edit click: ");
					selectedWave.row = spawnPoint.row;
					selectedWave.col = spawnPoint.col;
					selectedWave.setStartTime(spawnTime);
					selectedWave.setDelay(delay);
					selectedWave.TypeOfEnemy = mapMakerPanel.enemy_type.selectedItem.data;					
					selectedWave.numOfEnemies = numOfEnemies;
					
					
					selectedWave.refreshLabel();
					
					trace(selectedWave.label);
					
					var index : int  =  mapMakerPanel.waves.selectedIndex;
					
					mapMakerPanel.waves.removeItem(selectedWave);
					mapMakerPanel.waves.addItemAt(selectedWave, index);
					//mapMakerPanel.waves.selectedItem = selectedWave;
				}
			}
		}
		
		private function onRemoveSpawnPointClick(e:MouseEvent): void
		{
			Factory.getInstance().clickState = Factory.SPAWN_POINT_REMOVER;
		}		
		
		private function removeSpawnPoint(spawnPoint:SpawnPoint):void
		{
			removeChild(spawnPoint.labelIconText);
			removeChild(spawnPoint);
			var spawnIndex : int = spawnPoints.indexOf(spawnPoint);
			spawnPoints.splice(spawnIndex, 1);
			
			
			mapMakerPanel.spawn_points.removeItem(spawnPoint);
			if(mapMakerPanel.spawn_points.length > 0) {
				mapMakerPanel.spawn_points.selectedItem = mapMakerPanel.spawn_points.getItemAt(0);
			} else {
				mapMakerPanel.spawn_points.selectedItem = null;
			}
		}
		
		private function onDensityInputKeyDown(e:KeyboardEvent):void 
		{
			// if the key is ENTER
		   if (e.charCode == 13) {
				var denisity : int  = int(mapMakerPanel.delay_input.text);
				
				if (denisity > 200) {
					denisity = 200;
					mapMakerPanel.delay_input.text = "200";
				}
			    
				mapMakerPanel.spawn_density.value = int(mapMakerPanel.delay_input.text);
		   }
		}
		
		private function onDenistySliderChange(e:SliderEvent):void 
		{
			mapMakerPanel.delay_input.text = e.value.toString();
		}
		
		private function onNewSpawnPointButton(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.SPAWN_POINT_CREATOR;
		}
		
		private function onGameScreenClick(e:MouseEvent):void 
		{
			var row : int = e.stageY / Constants.CELL_SIZE;
			var col : int = e.stageX / Constants.CELL_SIZE;
			
			if (row >= 0 && row < Constants.ROW_NUM && col >= 0 && col < Constants.COL_NUM)
			{
				var clickedCell : Cell = model.pathFinder.cellGrid.getCell(row, col);
				switch (Factory.getInstance().clickState) 
				{
					case Factory.ENEMY_SPAWNER:
						if(!clickedCell.blocked && !clickedCell.isExit())
						{	
							Factory.getInstance().addEnemy(row, col, this.spawnEnemyClass);
						}
					break;
					case Factory.TOWER_BUILDER:
						if(!clickedCell.blocked && !clickedCell.isExit())
						{	
							Factory.getInstance().addTower(row, col, this.buildTowerClass, true);
						}
					break;
					case Factory.SPAWN_POINT_CREATOR:
						if(!clickedCell.blocked && !clickedCell.isExit())
						{	
							addSpawnPoint(row, col);
						}
					break;
					case Factory.SPAWN_POINT_REMOVER:
						if(!clickedCell.blocked && !clickedCell.isExit() && clickedCell.isSpawnPoint())
						{	
							removeSpawnPoint(clickedCell.spawnPoint);
						}
					break;
					case Factory.ADD_EXIT:
						if(!clickedCell.blocked && !clickedCell.isSpawnPoint())
						{
							var exitPoint : ExitPoint = new ExitPoint(row, col);
							
							Factory.getInstance().addExitPoint(exitPoint);
						}
					break;
					case Factory.REMOVE_EXIT:
						if (clickedCell.isExit()) { 
							model.pathFinder.removeExitPoint(row, col); 
							model.gameScreen.removeChild(clickedCell.exitPoint);
						}
					break;
				}
			}
		}
		
		private function addWave(e:MouseEvent):void 
		{
			var spawnTime : int = int(mapMakerPanel.spawn_start.text);
			var numOfEnemies : int = int(mapMakerPanel.spawn_num.text);
			var delay : int = int(mapMakerPanel.delay_input.text);
			var enemy : Class = Enemy;
			var spawnPoint : SpawnPoint = SpawnPoint(mapMakerPanel.spawn_points.selectedItem);
			
			if (spawnTime >= 0 && numOfEnemies > 0 && spawnPoint != null)
			{
				var wave : Wave = new Wave(spawnPoint, spawnTime, numOfEnemies, delay, enemy);
				
				//ADDING TO THE MAPMAKER ARRAY
				waves.push(wave);
				
				//ADDING TO THE COMBO BOX
				mapMakerPanel.waves.addItem(wave);
				waveNum++;
			}
		}
		
		private function addSpawnPoint(row:Number, col:Number):void 
		{			
			//Create
			var newSpawnPoint : SpawnPoint = new SpawnPoint(row, col);
			spawnPoints.push(newSpawnPoint);
			//Display
			addChildAt(newSpawnPoint,0);
			addChildAt(newSpawnPoint.labelIconText,1);
			
			//Set cell
			model.pathFinder.cellGrid.getCell(row, col).spawnPoint = newSpawnPoint;
			
			//Add to the drop down menu
			mapMakerPanel.spawn_points.addItem(newSpawnPoint);
			
			//newSpawnPoint.addEventListener(MouseEvent.CLICK, removeSpawnPoint);
			Factory.getInstance().clickState = Factory.IDLE;
			
		}
		
		private function addTowerClick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.TOWER_BUILDER;
		}
		
		private function addEnemy(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.ENEMY_SPAWNER;
		}
		
		private function addWallClick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.WALL_BUILDER;
		}
		//ADD END
		
		//REMOVE
		private function removeBlockKick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.REMOVE_BLOCK;
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
		//REMOVE END
		
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
		
		private function enemySelect(e:Event):void 
		{
			spawnEnemyClass = Class(creatorGui.add_enemy_combo.selectedItem.data);
		}
		
		
		
		private function towerSelect(e:Event):void 
		{
			buildTowerClass = Class(creatorGui.add_tower_combo.selectedItem.data);
		}
		
	}

}