package massdefense 
{
	import flash.utils.Dictionary;
	import massdefense.level.Level;
	import massdefense.misc.Position;
	import massdefense.units.Creep;
	import massdefense.units.Projectil;
	import massdefense.units.Tower;

	public class Factory 
	{
		public static var level : Level = null;
		public static var numofdelete : uint = 0;
		public function Factory() { }
		
		public static function spawnCreep(attributes : Array) : void {
			var creep: Creep = new Creep();
			creep.init(attributes);

			level.addCreep(creep);
		}
		
		public static function addTower(row:int, col:int, type:String = "", isFree:Boolean = false ):void 
		{
			var cost : int = Game.units.tower.(@type == Tower.SIMPLE_TOWER).cost;
			if(level.money >= cost || isFree)
			{
				var tower: Tower = new Tower();
				tower.init(row, col, type);
				
				level.addTower(tower);
				
				if(!isFree) level.money -= cost;
			}
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