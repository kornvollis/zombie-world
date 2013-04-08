package massdefense.level 
{
	import flash.utils.Dictionary;
	import massdefense.misc.SimpleGraphics;
	import massdefense.pathfinder.Grid;
	import massdefense.pathfinder.Node;
	import massdefense.pathfinder.PathFinder;
	import massdefense.ui.TimeControll;
	import massdefense.units.Creep;
	import massdefense.units.Projectil;
	import massdefense.units.Tower;
	import massdefense.Wave;
	import starling.display.Sprite;
	import starling.text.TextField;
	

	public class Level extends Sprite
	{
		public static const STEP_FRAMES : uint = 10;
		
		private var _levelData : XML;
		
		// UI
		private var timeControll : TimeControll;
		private var lifeDisplay  : TextField;
		
		// PATHFINDER 
		private var _pathfinder  : PathFinder;
		private var _grid        : Grid;
		private var _escapeNodes : Vector.<Node>;
		
		// WAVES
		private var _waves : Vector.<Wave>;
		
		// TOWERS
		private var _towers : Vector.<Tower>;
		
		// PROJECTILS
		private var _projectils : Vector.<Projectil> = new Vector.<Projectil>;
		
		// CREEPS
		private var _creeps : Vector.<Creep> = new Vector.<Creep>;
		private var levelLoader:LevelLoader;
		
		// STATE
		public var paused : Boolean = false;
		public var stepFrames : uint = 0;
		
		// GAME attributes
		private var _life : int = 1;
		
		public function Level() {
			timeControll = new TimeControll(this);
		}
		
		public function initLevel():void 
		{
			levelLoader = new LevelLoader(this);
			levelLoader.loadLevel(_levelData);
			
			lifeDisplay = new TextField(150, 50, "Life: " + this.life);
			lifeDisplay.x = 600;
			lifeDisplay.y = 60;
			addChild(lifeDisplay);
			
			timeControll.x = 650;
			addChild(timeControll);
		}

		public function play() : void {
			clearLevel();
			levelLoader.loadLevel(_levelData);
		}
		
		private function clearLevel():void 
		{
			for each (var creep: Creep  in creeps ) 
			{
				removeChild(creep);
			}
			for each (var tower: Tower in towers) 
			{
				removeChild(tower);
			}
			for each (var projectil: Projectil in projectils) 
			{
				removeChild(projectil);
			}
			
			creeps      = new Vector.<Creep>;
			towers      = new Vector.<Tower>;
			projectils  = new Vector.<Projectil>;
			waves       = new Vector.<Wave>;
		}
		
		public function pause() : void {
			if (paused) paused = false;
			else paused = true;
		}
		
		public function update(passedTime : Number) : void 
		{
			//trace(creeps.length);
			if (life <= 0)
			{
				//trace("GAME OVER");
				
				//return;
			}
			
			if (!paused || stepFrames > 0) {
				
				
				for each (var wave: Wave in waves) 
				{
					if(wave.remainingCreepsToSpawn > 0) {
						wave.timeToNextSpawn -= passedTime;
					}
				}
				
				for each (var tower: Tower in towers) 
				{
					tower.update(passedTime);
				}
				
				for (i = projectils.length-1; i >= 0 ; i--) 
				{
					projectils[i].update(passedTime);
				}
				
				for (var i:int = creeps.length-1; i >= 0 ; i--) 
				{
					creeps[i].update(passedTime);
					if (creeps[i].life <= 0) {
						removeChild(creeps[i]);
						creeps.splice(creeps.indexOf(creeps[i]), 1);
					} else if (creeps[i].isAtEndPosition()) {
						removeChild(creeps[i]);
						creeps.splice(creeps.indexOf(creeps[i]), 1);
						life--;
					}
				}
				
				if (stepFrames > 0) stepFrames--;
			}
			
			
		}
		
		public function spawnCreep(creepAttributes : Dictionary) : void {
			var creep : Creep = new Creep();
			creep.setPositionRowCol(creepAttributes["row"], creepAttributes["col"]);
			
			creeps.push(creep);
			addChild(creep);
		}
		
		private function resetWaves():void 
		{
			for each (var wave: Wave in waves) 
			{
				wave.reset();
			}
		}
		
		public function debugDraw() : void {
			addChild(SimpleGraphics.drawGrid(grid.maxRow, grid.maxCol, Node.NODE_SIZE, 1, 0x880000, 0.3));
			
			drawDebugStartNodes();
			drawDebugWalls();
		}
		
		private function drawDebugWalls():void 
		{
			for (var i:int = 0; i < grid.maxRow; i++) 
			{
				for (var j:int = 0; j < grid.maxRow; j++) 
				{
					if (!grid.getNodeAtRowCol(i, j).isOpen()) {
						addChild(SimpleGraphics.drawXatRowCol(i, j, Node.NODE_SIZE, 1, 0x880000, 0.3));
					}
				}
			}
		}
		
		private function drawDebugStartNodes():void 
		{
			for (var i:int = 0; i < escapeNodes.length; i++) 
			{
				var currentNode : Node = escapeNodes[i];
				addChild(SimpleGraphics.drawCircle(currentNode.col * Node.NODE_SIZE, currentNode.row * Node.NODE_SIZE, Node.NODE_SIZE * 0.5));
			}
		}
		
		public function get levelData():XML 
		{
			return _levelData;
		}
		
		public function set levelData(value:XML):void 
		{
			_levelData = value;
		}
		
		public function get pathfinder():PathFinder 
		{
			return _pathfinder;
		}
		
		public function set pathfinder(value:PathFinder):void 
		{
			_pathfinder = value;
		}
		
		public function get grid():Grid 
		{
			return _grid;
		}
		
		public function set grid(value:Grid):void 
		{
			_grid = value;
		}
		
		public function get escapeNodes():Vector.<Node> 
		{
			return _escapeNodes;
		}
		
		public function set escapeNodes(value:Vector.<Node>):void 
		{
			_escapeNodes = value;
		}
		
		public function get waves():Vector.<Wave> 
		{
			return _waves;
		}
		
		public function set waves(value:Vector.<Wave>):void 
		{
			_waves = value;
		}
		
		public function get creeps():Vector.<Creep> 
		{
			return _creeps;
		}
		
		public function set creeps(value:Vector.<Creep>):void 
		{
			_creeps = value;
		}
		
		public function get towers():Vector.<Tower> 
		{
			return _towers;
		}
		
		public function set towers(value:Vector.<Tower>):void 
		{
			_towers = value;
		}
		
		public function get projectils():Vector.<Projectil> 
		{
			return _projectils;
		}
		
		public function set projectils(value:Vector.<Projectil>):void 
		{
			_projectils = value;
		}
		
		public function get life():uint 
		{
			return _life;
		}
		
		public function set life(value:uint):void 
		{
			_life = value;
			if(lifeDisplay != null)	lifeDisplay.text = "Life: " + _life;
		}
	}

}