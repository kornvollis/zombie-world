package debug 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author OML!
	 */
	public class ZDebug extends Sprite
	{
		private var textArea : TextField = new TextField();
		
		private var watchList : Dictionary = new Dictionary();
		
		private static var instance : ZDebug = new ZDebug();
		
		public function ZDebug() 
		{
			if(instance)
			{
				throw new Error ("We cannot create a new instance.Please use Factory.getInstance()");
			} else
			{
				textArea.width = 200;
				textArea.height = 420;
				
				textArea.multiline = true;
				
				textArea.text = "szevasz";
				
				addChild(textArea);
			}
		}
		
		public static function getInstance():ZDebug
		{
			return instance;
		}
		
		public function watch(name : String, variable : Object) : void
		{
			watchList[name] = variable;
		}
		
		public function refresh() : void
		{
			var text : String = "";
			for (var key:String in watchList) {
				text += key + " = " + watchList[key];
				text += '\n';
			}
			textArea.text = text;
		}
		
	}

}