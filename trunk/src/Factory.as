package  
{
	import mvc.GameModel;
	import debug.ZDebug;
	/**
	 * ...
	 * @author OML!
	 */
	public class Factory 
	{
		/** Only one instance of the model locator **/
 
		private static var model: GameModel = null;
		
        private static var instance:Factory = new Factory();
        
       	public function Factory()
		{
			if(instance)
			{
				throw new Error ("We cannot create a new instance.Please use Factory.getInstance()");
			}
		}
		
		public static function getInstance():Factory
		{
			return instance;
		}
		
		public function setModel(model: GameModel) :void
		{
			Factory.model = model;
		}
		
		public function addBox(row:int , col :int) : void
		{
			if (row <0 || row >= Constants.ROW_NUM ||
			    col <0 || col >= Constants.COL_NUM)
			{
				throw(new Error("addBox row, col out of bound"));
			} else {
				if (model != null)
				{
					var box : Box = new Box(row, col);
					model.boxes.push(box);
				}
			}
			ZDebug.getInstance().refresh();
		}
	}

}