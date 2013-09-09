package massdefense.units 
{
	import starling.display.Sprite;
	
	public class GameObject extends Sprite
	{			
		public function addGraphics() : void {
			
		}
		
		public function injectProperties(properties:Object):void 
		{
			for (var property:String in properties) {
				if (this.hasOwnProperty(property)) {
					this[property] = properties[property];
				} else {
					throw new Error("Private or missing property: " + property);
				}
			}
		}
	}

}