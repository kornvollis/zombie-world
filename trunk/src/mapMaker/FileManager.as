package mapMaker 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import levels.LevelData;
	import levels.LevelLoader;
	/**
	 * ...
	 * @author OML!
	 */
	public class FileManager extends EventDispatcher
	{
		private var fileOpener : FileReference = new FileReference();
		private var fileSaver : FileReference = new FileReference();
		private var xmlData : XML = new XML();
		private var levelData : LevelData = new LevelData();
		
		public function FileManager() 
		{
			trace("file manager!");
			var fileTypes:FileFilter = new FileFilter("Images", "*.jpg;*.jpeg;*.gif;*.png");
			
			fileOpener.addEventListener(Event.SELECT, selectFileOpen);
			fileOpener.addEventListener(Event.COMPLETE, fileLoadComplete);
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