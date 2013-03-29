package massdefense.level 
{
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
		private var level : Level;
		private var levelData:XML;
		
		public function LevelLoader(level: Level) 
		{
			this.level = level;
		}
		
		public function loadLevel(levelData : XML) : void
		{			
			this.levelData = levelData;
			// Set grid for pathfinder
			level.pathfinder = new PathFinder();
			level.grid  = new Grid(getRows(), getCols());
			level.pathfinder.grid = level.grid;
			
			// Set closed and start nodes
			level.escapeNodes = getEscapeNodes();
			level.pathfinder.closeNodes(getClosedNodes() );
			level.pathfinder.setStartNodes(getEscapeNodes() );
			
			level.pathfinder.calculateNodesDistances();
			
			level.waves = getWaves();
			level.towers = getTowers();
		}
		
		private function getTowers():Vector.<Tower> 
		{
			var towers : Vector.<Tower> = new Vector.<Tower>();
			for each (var xml_tower : XML in levelData.towers.tower) 
			{
				var tower:Tower = new Tower();
				tower.row = xml_tower.row;
				tower.col = xml_tower.col;
				
				tower.setPositionRowCol(tower.row, tower.col);
				tower.targetList = level.creeps;
				
				towers.push(tower);
				
				level.addChild(tower);
			}
			
			return towers;
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
		
		private function getEscapeNodes():Vector.<Node> 
		{
			var startNodes : Vector.<Node> = new Vector.<Node>;
			
			for each (var xml_node : XML in levelData.start_nodes.node) 
			{
				var row : int = int(xml_node.attribute("row"));
				var col : int = int(xml_node.attribute("col"));
				
				var node : Node  = level.grid.getNodeAtRowCol(row, col);
				node.distance = 0;
				
				startNodes.push(node);
			}
			
			return startNodes;
		}
		
		public function getClosedNodes():Vector.<Node>
		{
			var closedNodes : Vector.<Node> = new Vector.<Node>();
			for each (var xml_node : XML in levelData.closed_nodes.node) 
			{
				var row : int = int(xml_node.attribute("row"));
				var col : int = int(xml_node.attribute("col"));
				
				var node : Node = level.grid.getNodeAtRowCol(row,col);
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