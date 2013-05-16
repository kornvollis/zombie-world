package massdefense 
{
	import flash.utils.Dictionary;
	import massdefense.level.Level;
	import massdefense.misc.Position;
	import massdefense.units.Creep;
	import massdefense.units.Projectil;
	import massdefense.units.Tower;
	/**
	 * ...
	 * @author OMLI
	 */
	public class Factory 
	{
		public static var level : Level = null;
		public static var numofdelete : uint = 0;
		public function Factory() { }
		
		public static function spawnCreep(attributes : Array) : void {
			var creep: Creep = new Creep();
			creep.init(attributes);
			
			creep.pathfinder = level.pathfinder;
			
			creep.addGraphics();
			
			level.creeps.push(creep);
			level.addChild(creep);
		}
		
		public static function addTower(attributes : Array) : void {
			var tower: Tower = new Tower();
			//var type : String = attributes["type"];
			//var towerProps : XMLList = Game.units.tower.(@type == type);	
			tower.init(attributes);
			
			tower.addGraphics();
			
			
			//tower.targetList = level.creeps;
			
			level.towers.push(tower);
			level.addChild(tower);
			
			//level.pathfinder.calculateNodesDistances();
		}
		
		public static function addProjectil(attributes : Dictionary) : void {
			var posx : uint = attributes["posx"];
			var posy : uint = attributes["posy"];
			var target : Creep = attributes["target"];
			
			var projectil : Projectil = new Projectil();
			projectil.damage = attributes["damage"];
			
			
			var position : Position = new Position;
			position.x = posx;
			position.y = posy;
			
			projectil.position = position;
			projectil.target = target;
			
			projectil.addGraphics();
			
			level.projectils.push(projectil);
			level.addChild(projectil);
		}
		
		static public function removeProjectil(projectil:Projectil):void 
		{
			level.removeChild(projectil);
			level.projectils.splice(level.projectils.indexOf(projectil), 1);
		}		
	}

}