package massdefense.tests.level 
{
	import flexunit.framework.Assert;
	import massdefense.level.Level;
	import massdefense.level.LevelLoader;

	public class LevelLoaderTest 
	{
		[Test]
		public function testCreateLevelNotNull():void {
			var levelLoader : LevelLoader = new LevelLoader();
			
			var level : Level = levelLoader.createLevel(LevelLoader.Level_01);
			
			Assert.assertNotNull(level);
		}
		
	}

}