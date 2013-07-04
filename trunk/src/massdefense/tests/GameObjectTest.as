package massdefense.tests 
{
	import flexunit.framework.Assert;
	import massdefense.units.GameObject;

	public class GameObjectTest 
	{
		private var gameObject : SuperGameObject;
		private var properties : Object = new Object();
		
		[Before]
		public function init():void {
			gameObject = new SuperGameObject();
			properties["life"] = 5;
			properties["myname"] = "kacsa";
		}
		[Test]
		public function	testInjection(): void {
			gameObject.injectProperties(properties);
			
			Assert.assertEquals(gameObject.life, 5);
			Assert.assertEquals(gameObject.myname, "kacsa");
		}
		
		
	}

}
import massdefense.units.GameObject;
class SuperGameObject extends GameObject
{
   public var life : int;
   public var myname : String;
	
   public function SuperGameObject()
   {

   }
}