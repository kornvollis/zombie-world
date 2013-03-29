package massdefense.tests.wave 
{
	import flash.display.Sprite;
	import massdefense.Wave;
	/**
	 * ...
	 * @author OMLI
	 */
	public class WaveTest extends Sprite
	{
		
		public function WaveTest() 
		{
			var wave : Wave = new Wave();
			
			wave.enemiesToSpawn = 20;
			wave.delayBetweenSpawns = 200;
			wave.startAfterSecond = 1;
			
			wave.start();
		}
		
	}

}