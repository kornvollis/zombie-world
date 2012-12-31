package ui
{
	import assets.Assets;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import levels.LevelData;
	import levels.Wave;
	import mapMaker.FileManager;
	import org.as3commons.collections.ArrayList;
	import screens.GameScreen;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import units.Enemy;
	import units.towers.Tower;
	import flash.display.DisplayObject;
	import levels.SpawnPoint;

	public class MapMaker extends GameObject 
	{		
		public static const IDLE  : String = "idle";
		public static const ENEMY : String = "enemy";
		public static const BLOCK : String = "block";
		public static const TOWER:String = "tower";
		public static const DELETE:String = "delete";
		
		public static var state : String = IDLE;
		public static var gameObjData : Object;
		
		private var model : GameModel;
		private var gameScreen : GameScreen;
		
		private var waveNum : int = 0;
		
		private var enemies : ArrayList = new ArrayList();
		private var towers  : ArrayList = new ArrayList();
		private var blocks  : ArrayList = new ArrayList();
		private var spawnPoints : Vector.<SpawnPoint> = new Vector.<SpawnPoint>();
		private var waves : Vector.<Wave> = new Vector.<Wave>();
			
		private var levelData : LevelData = new LevelData();
		private var fileReader:FileReference = new FileReference();
		
		
		
		// BUTTONS
		private var startNeditButton : Button;
		private var buildButton  : SwitchButton;
		private var deleteButton : SwitchButton;
		private static const MAPEDITOR : String = "Map editor";
		private static const STARTGAME : String = "Start_Game";
		
		public var objectsPanel : ObjectsPanel;
		//
		//private var buildTowerClass : Class = Tower;
		//private var	spawnEnemyClass : Class = Enemy;
		
		public function MapMaker(model : GameModel, gameScreen : GameScreen) 
		{
			// START & EDIT BUTTON
			startNeditButton = new Button(Assets.getTexture("ButtonWide"), MAPEDITOR);
			startNeditButton.fontSize = 12;
			startNeditButton.fontName = Constants.FONT_NAME;
			startNeditButton.addEventListener(starling.events.Event.TRIGGERED, onSwitchClick);
			addChild(startNeditButton);
			
			// BUILD BUTTONS
			buildButton = new SwitchButton(Assets.getTexture("ButtonBuildBM"));
			buildButton.setPos(0, 0);
			buildButton.addEventListener(starling.events.Event.TRIGGERED, onBuildButtonClick);			
			addChild(buildButton);
			
			// DELETE BUTTON
			deleteButton = new SwitchButton(Assets.getTexture("ButtonDeleteBM"));
			deleteButton.setPos(90, 0);
			deleteButton.addEventListener(starling.events.Event.TRIGGERED, onDeleteButtonClick);
			addChild(deleteButton);
			
			// OBJECT PANEL
			objectsPanel = new ObjectsPanel();
			objectsPanel.y = 90;
			
			// VISIBILITY
			buildButton.visible = false;
			deleteButton.visible = false;
			objectsPanel.visible = false;
			
			addChild(objectsPanel);
			
			//PAUSE THE GAME
			//model.pause = true;
		}

		private function onDeleteButtonClick(e:starling.events.Event):void 
		{
			if (deleteButton.on) {
				if (buildButton.on) buildButton.switchIt();
				
				MapMaker.state = MapMaker.DELETE;
			}
			
		}
		
		private function onBuildButtonClick(e:starling.events.Event):void 
		{
			if (buildButton.on) {
				if (deleteButton.on) deleteButton.switchIt();
			}
			
			if(buildButton.on) {
				objectsPanel.visible = true;
			} else {
				objectsPanel.visible = false;
			}
		}
		
		private function onSwitchClick(e:starling.events.Event):void 
		{
			if (startNeditButton.text == MapMaker.MAPEDITOR) {
				//switchButton.visible = false;
				startNeditButton.y = Constants.SCREEN_HEIGHT - 40;
				startNeditButton.text = MapMaker.STARTGAME;
				deleteButton.visible = true;
				buildButton.visible = true;
				Factory.getInstance().clickState = Factory.MAP_MAKER_ON;
			} else if (startNeditButton.text == MapMaker.STARTGAME) {
				startNeditButton.y = 0;
				startNeditButton.text = MapMaker.MAPEDITOR;
				deleteButton.visible = false;
				buildButton.visible = false;
				objectsPanel.visible = false;
				Factory.getInstance().clickState = Factory.GAME_ON;
			}
		}
		/*
		private function removeClick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.REMOVE;
		}
			
		private function onMouseUp(e:MouseEvent):void 
		{
			Factory.mouseDown = false;
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			Factory.mouseDown = true;
		}
		
		private function onHammerClick(e:MouseEvent):void 
		{
			model.pause = true;
			
			hammerButton.visible = false;
			creatorGui.visible = true;
			mapMakerPanel.visible = true;
			
			//CLEEAR THE GAME SCREEN
			Factory.getInstance().removeAllEnemy();
			
			//REPOPPULATE
			for (var i : int = 0; i < enemies.size; i++ ) {
				var enemy : Object = enemies.itemAt(i);
				Factory.getInstance().addEnemy(enemy.row, enemy.col, Class(getDefinitionByName(getQualifiedClassName(enemy))) );
			}
		}
		
		private function processLevelData(levelData : LevelData) : void
		{			
			
		}
		
		private function onSaveClick(e:MouseEvent):void 
		{
			model.levelManager.saveFile();
		}
		
		private function onLoadClick(e:MouseEvent):void 
		{
			model.levelManager.loadFile();
		}
		
		private function mapLoaded(e:Event):void 
		{
			var levelData : LevelData = model.levelManager.getLevel();
		}
		
		private function onAddExit(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.ADD_EXIT;
		}
		
		private function onStartMapClick(e:MouseEvent):void 
		{
			model.pause = false;
			
			model.money = int(mapMakerPanel.money.text);
			
			//START ALL WAVE TIMERS
			for (var i : int = model.waves.size-1; i >=0 ; i--) {
				var wave: Wave = model.waves.itemAt(i);
				wave.start();
			}
			
			this.mapMakerPanel.visible = false;
			this.creatorGui.visible = false;
			this.hammerButton.visible = true;
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
		
		private function addWave(e:MouseEvent):void 
		{
			var spawnTime : int = int(mapMakerPanel.spawn_start.text);
			var numOfEnemies : int = int(mapMakerPanel.spawn_num.text);
			var delay : int = int(mapMakerPanel.delay_input.text);
			var enemy : Class = Enemy;
			var spawnPoint : SpawnPoint = SpawnPoint(mapMakerPanel.spawn_points.selectedItem);
			
			if (spawnTime >= 0 && numOfEnemies > 0 && spawnPoint != null)
			{
				var wave : Wave = new Wave(spawnPoint.row, spawnPoint.col, spawnTime, numOfEnemies, delay, enemy);
				
				//ADDING TO THE MODEL
				model.waves.add(wave);
				
				//ADDING TO THE MAPMAKER ARRAY
				//waves.push(wave);
				
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
		
		private function addBlockClick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.BLOCK_BUILDER;
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
		*/
	}

}