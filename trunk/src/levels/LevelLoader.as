package levels 
{
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import mvc.GameModel;
	/**
	 * ...
	 * @author OML!
	 */
	public class LevelLoader 
	{
		private var  model : GameModel;
		
		private var myXML : XML =
		<level num="1">
			<exit row="0" col="0"></exit>
			<exit row="1" col="0"></exit>
			<exit row="2" col="0"></exit>
			<exit row="3" col="0"></exit>
			
			<tower row="4" col="4" type="gun" lvl="1"></tower>			
			
			<wall row="7" col="10"></wall>
			
			<wave begin="4" delay="600" type="monster_type" count="4" hp="1" speed="2" row="19" col="39"></wave>
			<wave begin="20" delay="200" type="monster_type" count="0" hp="1" speed="2" row="19" col="39"></wave>
			
		</level>
		
		private var waves : Vector.<Timer> = new Vector.<Timer>;
		
		public function LevelLoader(model: GameModel) 
		{
			this.model = model;
			
			/*
			for each (var exit : XML in myXML.exit ) 
			{
				trace("Exit row: " + exit.attribute("row") + ", col " +  exit.attribute("col"));
			}
			*/
		}
		
		public function loadLevel(num : int) : void
		{
			waves = new Vector.<Timer>;
			
			//LOAD EXIT POINTS
			for each (var exit : XML in myXML.exit ) 
			{
				var row : int = exit.attribute("row");
				var col : int = exit.attribute("col");
				
				trace("Adding exit row: " + row + ", col " +  col);
				model.pathFinder.addTargetCell(row, col);
			}
			
			//LOAD WALLS
			for each (var wall : XML in myXML.wall ) 
			{
				row  = wall.attribute("row");
				col  = wall.attribute("col");
				
				trace("Adding wall: " + row + ", col " +  col);
				Factory.getInstance().addBox(row, col);
			}
			
			//LOAD TOWERS
			for each (var tower : XML in myXML.tower ) 
			{
				row  = tower.attribute("row");
				col  = tower.attribute("col");
				
				trace("Adding tower: " + row + ", col " +  col);
				Factory.getInstance().addTurret(row, col);
			}
			
			//LOAD WAVES
			for each (var wave : XML in myXML.wave) 
			{
				var w : Wave = new Wave(wave.attribute("begin"), wave.attribute("count"), wave.attribute("delay"), null, wave.attribute("row"), wave.attribute("col"));
			}
			
			model.pathFinder.findPath();
		}
	}

}