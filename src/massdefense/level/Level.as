package massdefense.level 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import massdefense.Block;
	import massdefense.misc.SimpleGraphics;
	import massdefense.pathfinder.Grid;
	import massdefense.pathfinder.Node;
	import massdefense.pathfinder.PathFinder;
	import massdefense.tests.TestSuit;
	import massdefense.ui.TimeControll;
	import massdefense.units.Creep;
	import massdefense.units.Fortress;
	import massdefense.units.Projectil;
	import massdefense.units.Tower;
	import massdefense.units.Units;
	import massdefense.Wave;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	

	public class Level extends Sprite
	{
		public static const STEP_FRAMES : uint = 10;
		public static const MONEY_CHANGED:String = "moneyChanged";
		static public const LIFE_LOST:String = "lifeLost";
		
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
		private var _fortress	 : Fortress;
		
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
			
			addChild(SimpleGraphics.drawLineFromTo(new Point(0, 0), new Point(0, 100), 1, 0x990000));
		}
		
		public function addToLayer_1(obj : DisplayObject) : void {
			layer_1.addChild(obj);
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
				wave.update(passedTime)
			}
			
			for each (var tower: Tower in towers) 
			{
				tower.update(passedTime);
				if (tower.level < Units.getTowerMaxLevel(tower.type)) {
					if (money >= Units.getTowerUpgradeCost(tower.type, tower.level +1)) {
						tower.showUpgradeIndicator();
					} else {
						tower.hideUpgradeIndicator();
					}
				} else {
					tower.hideUpgradeIndicator();
				}
				
			}
			
			for (i = projectils.length-1; i >= 0 ; i--) 
			{
				projectils[i].update(passedTime);
			}
			
			for (var i:int = creeps.length-1; i >= 0 ; i--) 
			{
				creeps[i].update(passedTime);
				if (creeps[i].state == Creep.DIE) {
					money = money + creeps[i].rewardMoney;
					//layer_2.removeChild(creeps[i]);
					creeps.splice(creeps.indexOf(creeps[i]), 1);
				} else if (creeps[i].state == Creep.ATTACK) {
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
		
		public function debugDraw() : void 
		{
			layer_0.addChild(SimpleGraphics.drawGrid(pathfinder.grid.rows, pathfinder.grid.cols, Node.NODE_SIZE, 1, 0x880000, 0.3));
			
			drawDebugWalls();
		}
		
		public function addTower(tower:Tower):void 
		{
			pathfinder.grid.getNode(tower.row, tower.col).close();
			pathfinder.calculateNodesDistances();
			
			if (pathfinder.isMazeBlocked()) {
				pathfinder.grid.getNode(tower.row, tower.col).open();
				pathfinder.calculateNodesDistances();
				return;
			}
			
			towers.push(tower);
			tower.targetList = creeps;
			
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
			pathfinder.grid.getNode(block.row, block.col).close();
			pathfinder.calculateNodesDistances();
			
			if (pathfinder.isMazeBlocked()) {
				pathfinder.grid.getNode(block.row, block.col).open();
				pathfinder.calculateNodesDistances();
				return;
			}
			
			blocks.push(block);
			
			if (!TestSuit.isTestRun) {
				block.addGraphics();
				layer_1.addChild(block);
			}
		}
		
		public function removeTower(tower:Tower):void 
		{
			
			towers.splice(towers.indexOf(tower), 1);
			layer_1.removeChild(tower);
			
			pathfinder.grid.getNode(tower.row, tower.col).open();
			pathfinder.calculateNodesDistances();
		}
		
		public function addProjectil(projectil : Projectil):void 
		{
			projectils.push(projectil);
			
			if (!TestSuit.isTestRun) {
				layer_1.addChild(projectil);
				projectil.addGraphics();
			}
		}
		
		public function removeProjectil(projectil:Projectil):void 
		{
			projectils.splice(projectils.indexOf(projectil), 1);
			layer_1.removeChild(projectil);
		}
		
		public function addFortress(fortress:Fortress):void 
		{
			this.fortress = fortress;
			
			if (!TestSuit.isTestRun) {
				layer_1.addChild(fortress);
				fortress.addGraphics();
			}
		
		}
		
		private function drawDebugWalls():void 
		{
			for (var i:int = 0; i < pathfinder.grid.rows; i++) 
			{
				for (var j:int = 0; j < pathfinder.grid.cols; j++) 
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
			dispatchEvent(new Event(LIFE_LOST, true, _life));
		}
		
		public function get money():int 
		{
			return _money;
		}
		
		public function set money(value:int):void 
		{
			_money = value;
			dispatchEvent(new Event(MONEY_CHANGED));
		}
		
		public function get blocks():Vector.<Block> 
		{
			return _blocks;
		}
		
		public function set blocks(value:Vector.<Block>):void 
		{
			_blocks = value;
		}
		
		public function get fortress():Fortress 
		{
			return _fortress;
		}
		
		public function set fortress(value:Fortress):void 
		{
			_fortress = value;
		}
	}

}