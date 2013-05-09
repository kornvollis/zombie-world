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
	/**
	 * ...
	 * @author OMLI
	 */
	public class LevelLoader 
	{
		[Embed(source="../config/levels/level01.xml", mimeType = "application/octet-stream")] 
		public static const Level_01:Class;
		
		private var levelData:XML;
		
		public function LevelLoader() {}
		
		public function createLevel(LevelClass : Class): Level 
		{
			var level : Level = new Level();
			
			levelData = XML(new LevelClass());
			
			setStartingMoney(level);
			setLife(level);
			setWaves(level);			
			setTowers(level);
			
			setupPathfinder(level);
			//level.pathfinder.calculateNodesDistances();
			
			return level;
		}	
		
		private function setTowers(level:Level):void 
		{
			level.towers = 	getTowers();
		}
		
		private function setWaves(level:Level):void 
		{
			level.waves = getWaves();
		}
		
		private function setLife(level:Level):void 
		{
			level.life = levelData.life;
		}
		
		private function setupPathfinder(level:Level):void 
		{
			var pathfinder : PathFinder = new PathFinder();
			pathfinder.grid = new Grid(getRows(), getCols() );
			pathfinder.closeNodes(getClosedNodes(pathfinder.grid) );
			pathfinder.setStartNodes(getEscapeNodes(pathfinder.grid) );
			
			level.pathfinder = pathfinder;
		}
		
		private function setStartingMoney(level:Level):void 
		{
			level.money = int(levelData.money);
		}
		
		private function getTowers():Vector.<Tower>
		{
			var towers : Vector.<Tower> = new Vector.<Tower>();
			for each (var xml_tower : XML in levelData.towers.tower) 
			{
				var towerProperties : Dictionary = new Dictionary;
				setTowerProperties(towerProperties, xml_tower);
				
				var tower : Tower = new Tower(towerProperties);
				
				towers.push(tower);
			}
			
			return towers;
		}
		
		private function setTowerProperties(towerProperties:Dictionary, xml_tower:XML):void 
		{
			towerProperties["row"] = xml_tower.row;
			towerProperties["col"] = xml_tower.col;
			towerProperties["type"] = xml_tower.type;	
		}
		
		private function getWaves():Vector.<Wave> 
		{
			var waves : Vector.<Wave> = new Vector.<Wave>();
			for each (var xml_wave : XML in levelData.waves.wave) 
			{
				var wave:Wave = new Wave();
				wave.row = xml_wave.row;
				wave.col = xml_wave.col;
				wave.startAfterSecond  = xml_wave.startInSecond;
				wave.delayBetweenSpawns  = xml_wave.delayBetweenSpansInSecond;
				wave.timeToNextSpawn = wave.startAfterSecond;
				wave.creepsToSpawn = xml_wave.creepsToSpawn;
				
				waves.push(wave);
			}
			
			return waves;
		}
		
		private function getEscapeNodes(grid : Grid):Vector.<Node> 
		{
			var startNodes : Vector.<Node> = new Vector.<Node>;
			
			for each (var xml_node : XML in levelData.start_nodes.node) 
			{
				var row : int = int(xml_node.attribute("row"));
				var col : int = int(xml_node.attribute("col"));
				
				var node : Node  = grid.getNodeAtRowCol(row, col);
				node.distance = 0;
				
				startNodes.push(node);
			}
			
			return startNodes;
		}
		
		public function getClosedNodes(grid : Grid):Vector.<Node>
		{
			var closedNodes : Vector.<Node> = new Vector.<Node>();
			for each (var xml_node : XML in levelData.closed_nodes.node) 
			{
				var row : int = int(xml_node.attribute("row"));
				var col : int = int(xml_node.attribute("col"));
				
				var node : Node = grid.getNodeAtRowCol(row,col);
				node.close();
				closedNodes.push(node);
			}
			return closedNodes;
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