package massdefense.level 
{
	import flash.utils.Dictionary;
	import massdefense.Block;
	import massdefense.misc.SimpleGraphics;
	import massdefense.pathfinder.Grid;
	import massdefense.pathfinder.Node;
	import massdefense.pathfinder.PathFinder;
	import massdefense.tests.TestSuit;
	import massdefense.ui.TimeControll;
	import massdefense.units.Creep;
	import massdefense.units.Projectil;
	import massdefense.units.Tower;
	import massdefense.Wave;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	

	public class Level extends Sprite
	{
		public static const STEP_FRAMES : uint = 10;
		public static const MONEY_CHANGED:String = "moneyChanged";
		
		// LEVEL LOADER
		// private var _levelData : XML;
		// private var levelLoader:LevelLoader;
		
		// UI
		private var timeControll : TimeControll;
		private var lifeDisplay  : TextField;
		private var moneyDisplay : TextField;
		
		// PATHFINDER 
		private var _pathfinder  : PathFinder;
		
		// GAME OBJECTS
		private var _waves       : Vector.<Wave> = new Vector.<Wave>;
		private var _towers      : Vector.<Tower> = new Vector.<Tower>;
		private var _blocks      : Vector.<Block> = new Vector.<Block>;
		private var _projectils  : Vector.<Projectil> = new Vector.<Projectil>;
		private var _creeps      : Vector.<Creep> = new Vector.<Creep>;
		
		// GAME attributes
		private var _life : int = 1;
		private var _money : int = 0;
		
		// LAYERS
		private var layer_0 : Sprite = new Sprite();
		private var layer_1 : Sprite = new Sprite();
		private var layer_2 : Sprite = new Sprite();
		
		public function Level() {}
		
		public function init() : void 
		{			
			pathfinder.calculateNodesDistances();
			
			addChild(layer_0);
			addChild(layer_1);
			addChild(layer_2);
		}
		
		public function play() : void {
			//clearLevel();
			//levelLoader.loadLevel(_levelData);
		}
		
		public function pause() : void {
			//if (paused) paused = false;
			//else paused = true;
		}
		
		public function spawnCreep(creepAttributes : Dictionary) : void {
			var creep : Creep = new Creep();
			creep.setPositionRowCol(creepAttributes["row"], creepAttributes["col"]);
			
			creeps.push(creep);
			layer_2.addChild(creep);
		}
		
		public function update(passedTime : Number) : void 
		{
			//trace(creeps.length);
			if (life <= 0)
			{
				//trace("GAME OVER");
				
				//return;
			}
				
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
				if (creeps[i].health <= 0) {
					money = money + creeps[i].rewardMoney;
					layer_2.removeChild(creeps[i]);
					creeps.splice(creeps.indexOf(creeps[i]), 1);
				} else if (creeps[i].isEscaped()) {
					layer_2.removeChild(creeps[i]);
					creeps.splice(creeps.indexOf(creeps[i]), 1);
					life--;
				}
			}	
		}
		
		private function clearLevel():void 
		{
			for each (var creep: Creep  in creeps ) 
			{
				layer_2.removeChild(creep);
			}
			for each (var tower: Tower in towers) 
			{
				layer_1.removeChild(tower);
			}
			for each (var projectil: Projectil in projectils) 
			{
				layer_1.removeChild(projectil);
			}
			
			creeps      = new Vector.<Creep>;
			towers      = new Vector.<Tower>;
			projectils  = new Vector.<Projectil>;
			waves       = new Vector.<Wave>;
		}
		
		private function resetWaves():void 
		{
			for each (var wave: Wave in waves) 
			{
				wave.reset();
			}
		}
		
		public function debugDraw() : void 
		{
			layer_0.addChild(SimpleGraphics.drawGrid(pathfinder.grid.rows, pathfinder.grid.cols, Node.NODE_SIZE, 1, 0x880000, 0.3));
			
			drawDebugWalls();
		}
		
		public function addTower(tower:Tower):void 
		{
			towers.push(tower);
			tower.targetList = creeps;
			
			pathfinder.grid.getNode(tower.row, tower.col).close();
			pathfinder.calculateNodesDistances();
			
			if (!TestSuit.isTestRun) {
				tower.addGraphics();
				layer_1.addChild(tower);
			}
		}
		
		public function addCreep(creep:Creep):void 
		{
			creeps.push(creep);
			creep.pathfinder = pathfinder;
			
			if (!TestSuit.isTestRun) {
				creep.addGraphics();
				layer_2.addChild(creep);
			}
		}
		
		public function addBlock(block:Block):void 
		{
			blocks.push(block);
			
			pathfinder.grid.getNode(block.row, block.col).close();
			pathfinder.calculateNodesDistances();
			
			if (!TestSuit.isTestRun) {
				block.addGraphics();
				layer_1.addChild(block);
			}
		}
		
		private function drawDebugWalls():void 
		{
			for (var i:int = 0; i < pathfinder.grid.rows; i++) 
			{
				for (var j:int = 0; j < pathfinder.grid.rows; j++) 
				{
					if (!pathfinder.grid.getNode(i, j).isOpen()) {
						layer_0.addChild(SimpleGraphics.drawXatRowCol(i, j, Node.NODE_SIZE, 1, 0x880000, 0.3));
					}
				}
			}
		}
		
		public function get pathfinder():PathFinder 
		{
			return _pathfinder;
		}
		
		public function set pathfinder(value:PathFinder):void 
		{
			_pathfinder = value;
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
		
		public function get money():int 
		{
			return _money;
		}
		
		public function set money(value:int):void 
		{
			_money = value;
			var event : Event = new Event(MONEY_CHANGED);
			dispatchEvent(event);
		}
		
		public function get blocks():Vector.<Block> 
		{
			return _blocks;
		}
		
		public function set blocks(value:Vector.<Block>):void 
		{
			_blocks = value;
		}
	}

}