package ui 
{
	import assets.Assets;
	import org.as3commons.collections.ArrayList;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import units.Box;
	import units.towers.Tower;
	
	public class ObjectsPanel extends Sprite 
	{
		private var objectButtons :ArrayList = new ArrayList;
		private static const PADDING : int = 30;
		private static const COLUMNS : int = 10;
		private var elements : int = 0;
		
		public var selectedItem:SwitchButton = null;
		
		public function ObjectsPanel() 
		{
			addGraphics();
		}
		
		private function addGraphics():void 
		{
			addChild(Assets.getImage("PopUp"));
			
			
			addItem(MapMaker.TOWER,null, "BaseSprite", "TowerSprite01");
			addItem(MapMaker.BLOCK,null, "Block01");
		}
		
		
		private function addItem(objType:String, objData:Object, firstImage : String, secondImage:String = null): void {
			
			var buttonData : Object = new Object();
			buttonData.objType = objType;
			buttonData.objData = objData;
			
			var baseIcon : Texture = Assets.getTexture("ButtonSmallIcon");
			var button : SwitchButton = new SwitchButton(baseIcon);
			
			button.data = buttonData;
			
			var itemIcon : Image = Assets.getImage(firstImage);
			itemIcon.pivotX = itemIcon.width  * 0.5;
			itemIcon.pivotY = itemIcon.height * 0.5;
			itemIcon.x = baseIcon.width * 0.5;
			itemIcon.y = baseIcon.height * 0.5;
			button.addImage(itemIcon);
			
			if (secondImage != null) {
				var secondItemIcon : Image = Assets.getImage(secondImage);
				secondItemIcon.pivotX = itemIcon.width  * 0.5;
				secondItemIcon.pivotY = itemIcon.height * 0.5;
				secondItemIcon.x = baseIcon.width * 0.5;
				secondItemIcon.y = baseIcon.height * 0.5;
				button.addImage(secondItemIcon);
			}
			
			
			button.y = PADDING + int(elements/COLUMNS)*50;
			button.x = PADDING + (elements % COLUMNS) * 50;
			
			addChild(button);
			
			button.addEventListener(Event.TRIGGERED, onButtonClick);
			
			elements++;
		}
		
		private function onButtonClick(e:Event):void 
		{
			var button:SwitchButton = e.currentTarget as SwitchButton;
			
			if (selectedItem != null && button != selectedItem) {
				selectedItem.switchIt();
				selectedItem = button;
				
				MapMaker.state = button.data["objType"];
				MapMaker.gameObjData = button.data["objData"];
			} else if (selectedItem != null && button == selectedItem) {
				selectedItem = null;
				MapMaker.state = MapMaker.IDLE;
			}
			else {
				selectedItem = button;
				MapMaker.state = button.data["objType"];
				MapMaker.gameObjData = button.data["objData"];
			}
			
			trace(MapMaker.state);
		}
		
	}

}