package mapMaker 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.getDefinitionByName;
	import levels.LevelData;
	import mvc.GameModel;
	import org.as3commons.collections.ArrayList;
	import units.Box;
	import units.towers.Cannon;
	/**
	 * ...
	 * @author OML!
	 */
	public class FileManager extends EventDispatcher
	{
		private var model : GameModel;
		private var fileOpener : FileReference = new FileReference();
		private var fileSaver : FileReference = new FileReference();
		
		private var xmlData : XML = new XML();
		
		private var levelData : LevelData = new LevelData();
		
		
		public function FileManager(model : GameModel) 
		{

			this.model = model;
			trace("file manager!");
			var fileTypes:FileFilter = new FileFilter("Images", "*.jpg;*.jpeg;*.gif;*.png");
			
			// DEFAULT MAP ///////////////
			levelData.addBlock(5, 6);
			levelData.addBlock(5, 7);
			levelData.addBlock(5, 8);
			
			
			levelData.addTower(4, 4, "Cannon");
			levelData.addWave(1, 2, 2, 20, 200, "BasicEnemy");
			
			
			levelData.addExitPoint(0, 0);
			levelData.addExitPoint(1, 0);
			levelData.addExitPoint(0, 1);
			/////////////////////////////
			
			fileOpener.addEventListener(Event.SELECT, selectFileOpen);
			fileOpener.addEventListener(Event.COMPLETE, fileLoadComplete);
			
		}
		
		public function loadMap() : void
		{
			// TODO FIXING THE SHITTY LOAD MAP
			
			// ADD BLOCKERS
			/*
			var blocks : ArrayList = levelData.getBlockObjects();
			for (var i:int = 0; i < blocks.size; i++) 
			{
				var blockObject : Object = blocks.itemAt(i);
				Factory.getInstance().addBlock(blockObject.row, blockObject.col, true);
			}
			
			// ADD EXITS
			var exits : ArrayList = levelData.getExitsObjects();
			for (i = 0; i < exits.size; i++) 
			{
				var exitObject: Object = exits.itemAt(i);
				Factory.getInstance().addExitPoint(exitObject.row, exitObject.col);
			}
			
			// ADD TOWERS
			var towers : ArrayList = levelData.getTowerObjects();
			for (i = 0; i < towers.size; i++) 
			{
				var toverObj : Object = towers.itemAt(i)
				//Factory.getInstance().addTower(toverObj.row, toverObj.col, Class(getDefinitionByName(toverObj.towerClass)), true);
			}
			
			// ADD WAVES
			var waves : ArrayList = levelData.getWaveObjects();
			for (i = 0; i < waves.size; i++) 
			{
				var waveObj : Object = waves.itemAt(i);
				Factory.getInstance().addWave(waveObj.row, waveObj.col, waveObj.start, waveObj.num, waveObj.density, Class(getDefinitionByName("units.towers."+waveObj.enemyClass)));
			}
			*/
		}
		
		public function saveFile():void 
		{
			fileSaver.save(xmlData);
		}
		
		public function loadFile():void
		{
			//trace("load file");
			fileOpener.browse();
		}
		
		public function getLevel():LevelData	 
		{
			return this.levelData;
		}
		
		private function fileSaveComplete(e:Event):void 
		{
			
		}
		
		private function selectFileSave(e:Event):void 
		{
			
		}
		
		private function fileLoadComplete(e:Event):void 
		{
			xmlData = XML(fileOpener.data); // get data
			levelData.setLevelDataFromXML(xmlData);
			
			trace("MAP: \n");
			trace(xmlData);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function selectFileOpen(e:Event):void 
		{
			//trace("select file");
			fileOpener.load();
		}
	}

}