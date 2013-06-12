package massdefense 
{
	import flash.utils.Dictionary;
	import massdefense.level.Level;
	import massdefense.misc.Position;
	import massdefense.units.BulletProperties;
	import massdefense.units.Creep;
	import massdefense.units.Projectil;
	import massdefense.units.Tower;
	import massdefense.units.Units;
	import org.flexunit.runners.BlockFlexUnit4ClassRunner;

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
		
		public static function addTower(row:int, col:int, type:String, isFree:Boolean = false ):void 
		{
			var cost : int = Units.getTowerCost(type);

			if(isOpenNode(row,col) && affordable(cost,isFree) )
			{
				var tower: Tower = new Tower();
				tower.init(row, col, type);
				
				level.addTower(tower);
				
				if(!isFree) level.money -= cost;
			}
		}

		public static function sellTower(tower : Tower):void 
		{
			level.removeTower(tower);
			level.money += tower.sellPrice;
		}
		
		private static function isOpenNode(row:int, col:int):Boolean 
		{
			return (level != null && level.pathfinder.grid.getNode(row, col).isOpen());
		}
		
		private static function affordable(cost:int, isFree:Boolean):Boolean 
		{
			return (level.money >= cost || isFree);
		}
		
		public static function addProjectil(target:Creep, position:Position, bulletProperties : BulletProperties) : void {		
			var projectil : Projectil = new Projectil(target,position,bulletProperties);
			
			level.addProjectil(projectil);
		}
		
		static public function removeProjectil(projectil:Projectil):void 
		{
			level.removeProjectil(projectil);
		}		
		
		static public function addBlock(row:int, col:int, type: String, isFree:Boolean = false ):void 
		{
			var cost : int = Game.units.block.(@type == type).cost;

			if(isOpenNode(row,col) && affordable(cost,isFree) )
			{			
				var block : Block= new Block();
				block.init(row, col, type);
				
				level.addBlock(block);
				
				level.money -= cost;
			}
		}
		
		static public function calculateBulletHitOn(projectil:Projectil, target:Creep):void 
		{
			target.health -= projectil.bulletProperties.damage;
			Factory.removeProjectil(projectil);
			
			if (projectil.bulletProperties.splash) {
				for (var i:int = 0; i < level.creeps.length; i++) 
				{
					if (Position.distance(level.creeps[i].position, projectil.position) <= projectil.bulletProperties.splashRange) {
						level.creeps[i].health -= projectil.bulletProperties.damage;
					}
				}
			}
		}
	}

}