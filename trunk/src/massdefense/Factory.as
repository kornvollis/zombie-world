package massdefense 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import massdefense.assets.Assets;
	import massdefense.level.Level;
	import massdefense.misc.Position;
	import massdefense.units.BulletProperties;
	import massdefense.units.Creep;
	import massdefense.units.Fortress;
	import massdefense.units.Projectil;
	import massdefense.units.Tower;
	import massdefense.units.Units;
	import org.flexunit.runners.BlockFlexUnit4ClassRunner;
	import starling.core.Starling;
	import starling.extensions.PDParticleSystem;

	public class Factory
	{
		public static var level : Level = null;
		public static var numofdelete : uint = 0;
		public function Factory() { }
		
		public static function newCreep(row:int, col:int, type:String):void {
			var creep: Creep = new Creep();
			//creep.injectAttributesFromXML(Units.getCreepAttibutes(type));
			creep.injectProperties(Units.getCreepProperties(type));
			creep.row = row;
			creep.col = col;
			
			level.addCreep(creep);
		}
		
		public static function addTower(row:int, col:int, type:String, isFree:Boolean = false ):void 
		{
			var towerProperties : Object = Units.getTowerProperties(type, 1);
			var cost : int = towerProperties.cost;
			if(isOpenNode(row,col) && affordable(cost,isFree) )
			{
				var tower: Tower = new Tower();
				tower.injectProperties(towerProperties);
				tower.row = row;
				tower.col = col;
				tower.type = type;
				
				level.addTower(tower);
				
				if (!isFree) level.money -= cost;
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
		
		public static function affordable(cost:int, isFree:Boolean = false):Boolean 
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
			var cost : int = 0;//Game.units.block.(@type == type).cost;

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
			
			target.slow(projectil.bulletProperties.slowDuration, projectil.bulletProperties.slowEffect);
			
			if (projectil.bulletProperties.splash) {
				
				addExplosionEffect(projectil);
				
				for (var i:int = 0; i < level.creeps.length; i++) 
				{
					var creep : Creep = level.creeps[i];
					if (Position.distance(creep.position, projectil.position) <= projectil.bulletProperties.splashRange) {
						creep.health -= projectil.bulletProperties.damage;
						creep.slow(projectil.bulletProperties.slowDuration, projectil.bulletProperties.slowEffect);
					}
				}
			}
		}
		
		static public function fireToDirection(point:Point, tower:Tower):void 
		{
			// var projectil = new Projectil(
		}
		
		static public function createFortress(row:int, col:int, width:int, height:int):void 
		{
			var fortress : Fortress = new Fortress(width, height);
			fortress.x = col * 32;
			fortress.y = row * 32;
			
			level.addFortress(fortress);
		}
		
		static public function upgradeTower(selectedTower:Tower):int 
		{
			if (selectedTower.upgradeCost <= level.money) {
				selectedTower.upgrade();
				level.money -= selectedTower.upgradeCost;
				return 1;
			}
			return -1;
		}
		
		static private function addExplosionEffect(projectil:Projectil):void 
		{
			// create particle system
			var drugsConfig:XML = XML(new Assets.ParticleConfig());
			
			var  mParticleSystem :PDParticleSystem = new PDParticleSystem(drugsConfig, Assets.getTexture("ParticleTexure"));
			mParticleSystem.emitterX = projectil.x;
			mParticleSystem.emitterY = projectil.y;

			// start emitting particles
			mParticleSystem.start(0.2);
			
			// add it to the stage and the juggler
			level.addChild(mParticleSystem);
			Starling.juggler.add(mParticleSystem);
		}
	}

}