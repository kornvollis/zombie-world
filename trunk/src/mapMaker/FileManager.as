package mapMaker 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import levels.LevelData;
	import mvc.GameModel;
	import org.as3commons.collections.ArrayList;
	import units.Box;
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
			
			//DEFAULT MAP///////////////
			levelData.addBlock(5, 6);
			levelData.addBlock(5, 7);
			levelData.addBlock(5, 8);
			
			levelData.addExitPoint(0, 0);
			levelData.addExitPoint(1, 0);
			levelData.addExitPoint(0, 1);
			/////////////////////////////
			
			fileOpener.addEventListener(Event.SELECT, selectFileOpen);
			fileOpener.addEventListener(Event.COMPLETE, fileLoadComplete);
			
		}
		
		public function loadMap() : void
		{
			var blocks : ArrayList = levelData.getBlocks();
			
			for (var i:int = 0; i < blocks.size; i++) 
			{
				Factory.getInstance().addBlock(blocks.itemAt(i).row, blocks.itemAt(i).col, true);
			}
			
			var exits : ArrayList = levelData.getExits();
			
			for (i = 0; i < exits.size; i++) 
			{
				Factory.getInstance().addExitPoint(exits.itemAt(i));
			}
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
			levelData.loadMapData(xmlData);
			
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