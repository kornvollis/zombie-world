package massdefense 
{
	import flash.utils.Dictionary;
	import massdefense.level.Level;
	import massdefense.units.Creep;
	import massdefense.units.Tower;
	/**
	 * ...
	 * @author OMLI
	 */
	public class Factory 
	{
		public static var level : Level = null;
		
		public function Factory() { }
		
		public static function spawnCreep(attributes : Dictionary) : void {
			var row : uint = attributes["row"];
			var col : uint = attributes["col"];
			var creep: Creep = new Creep();
			
			creep.setPositionRowCol(row, col);
			
			creep.path = level.pathfinder.getRandomPathForRowCol(row, col);
			
			level.creeps.push(creep);
			level.addChild(creep);
		}
		
		public static function addTower(attributes : Dictionary) : void {
			var row : uint = attributes["row"];
			var col : uint = attributes["col"];
			var tower: Tower = new Tower();
			
			tower.setPositionRowCol(row, col);
			
			level.addChild(tower);
		}
		
		public static function removeCreep(creep:Creep):void {
			level.removeChild(creep);
		}
		
	}

}