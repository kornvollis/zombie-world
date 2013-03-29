package ui 
{
	import flash.events.MouseEvent;
	import mvc.GameModel;
	/**
	 * ...
	 * @author OML!
	 */
	public class GameInterface extends GamePanel 
	{
		private var model : GameModel;
		
		public function GameInterface(model : GameModel) 
		{
			this.model = model;
			//this.block_button.addEventListener(MouseEvent.CLICK, onBlockBuildClick);
			
			model.addEventListener(GameEvents.BLOCKS_CHANGED, updateBlocks);
		}
		
		private function updateBlocks(e:GameEvents):void 
		{
			//block_button.label = "Box (" + model.blockers + ")";
		}
		
		private function onBlockBuildClick(e:MouseEvent):void 
		{
			Factory.getInstance().clickState = Factory.BLOCK_BUILDER;
		}
		
	}

}