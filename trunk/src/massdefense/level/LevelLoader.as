package massdefense.level 
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import massdefense.Factory;
	import massdefense.Game;
	import massdefense.pathfinder.Grid;
	import massdefense.pathfinder.Node;
	import massdefense.pathfinder.PathFinder;
	import massdefense.units.Tower;
	import massdefense.Wave;

	public class LevelLoader 
	{
		[Embed(source="../config/levels/level01.xml", mimeType = "application/octet-stream")] 
		public static const Level_01:Class;
		[Embed(source = "../config/levels/level02.xml", mimeType = "application/octet-stream")] 
		public static const Level_02:Class;
		
		private var levelData:XML;
		
		private var levels : Vector.<Class> = new Vector.<Class>;
		
		public function LevelLoader() 
		{
			levels.push(Level_01);
			levels.push(Level_02);
		}
		
		public function createLevel(levelIndex : uint): Level 
		{
			var level : Level = new Level();
			
			Factory.level = level;
			var levelClass : Class = levels[levelIndex];
			levelData = XML(new levelClass() );
			
			setStartingMoney(level);
			setLife(level);
			setWaves(level);			
			
			setupPathfinder(level);
			setTowers(level);
			
			return level;
		}	
		
		private function setStartingMoney(level:Level):void { level.money = int(levelData.money); }
		
		private function setLife(level:Level):void { level.life = levelData.life; }
		
		private function setWaves(level:Level):void { 
			for each (var xml_wave : XML in levelData.waves.wave) 
			{
				var wave:Wave = new Wave();
				wave.row = xml_wave.row;
				wave.col = xml_wave.col;
				wave.type = xml_wave.type;
				wave.startAfterSecond  = xml_wave.startInSecond;
				wave.delayBetweenSpawns  = xml_wave.delayBetweenSpansInSecond;
				wave.timeToNextSpawn = wave.startAfterSecond;
				wave.creepsToSpawn = xml_wave.creepsToSpawn;
				wave.remainingCreepsToSpawn = xml_wave.creepsToSpawn;
				wave.repeat = xml_wave.repeat;
				wave.repeatAfter = xml_wave.repeatAfter;
				
				level.waves.push(wave);
			}
		}
		
		private function setTowers(level:Level):void
		{
			for each (var xml_tower : XML in levelData.towers.tower) 
			{				
				Factory.addTower(xml_tower.row, xml_tower.col, xml_tower.type, true);
			}
		}
		
		private function setupPathfinder(level:Level):void 
		{
			var pathfinder : PathFinder = new PathFinder();
			var grid : Grid = new Grid(getRows(), getCols() );
			configureMap(grid);
			
			pathfinder.grid = grid;
			level.pathfinder = pathfinder;
			
			for each (var xml_wave : XML in levelData.waves.wave) 
			{
				var node : Node = grid.getNode(xml_wave.row, xml_wave.col);
				pathfinder.addWaveStartNode(node);
			}
		}
		
		private function configureMap(grid : Grid):void
		{
			var rowIndex : int = 0;
			for each (var row : XML in levelData.closed_nodes.row) 
			{
				var rowRepresentation : String = row.toString();;
				
				parseRowRepresentation(rowRepresentation, rowIndex, grid);
				rowIndex++;
			}
			
		}
		
		private function parseRowRepresentation(rowRepresentation:String, rowNum: int, grid:Grid):void 
		{
			var array : Array = rowRepresentation.split("|");
			rowRepresentation = array.join('');
			for (var i:int = 0; i < rowRepresentation.length; i++)
			{
				var code : String = rowRepresentation.charAt(i);
				switch (code) 
				{
					case "X" :
						grid.getNode(rowNum,i).close();
					break;
					case "E" :
						grid.getNode(rowNum,i).exit = true;
					break;
					default:
				}
			}
		}
		
		public function getRows() : uint {
			return levelData.rows;
		}
		
		public function getCols() : uint {
			return levelData.cols;
		}
		
		public function getCellSize() : uint {
			return levelData.cellSize;
		}
	}

}