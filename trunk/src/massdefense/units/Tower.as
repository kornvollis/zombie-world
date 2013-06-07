package massdefense.units 
{
	import adobe.utils.ProductManager;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flexunit.utils.ArrayList;
	import massdefense.assets.Assets;
	import massdefense.Factory;
	import massdefense.Game;
	import massdefense.misc.Position;
	import massdefense.misc.SimpleGraphics;
	import massdefense.pathfinder.Node;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Tower extends Sprite 
	{
		public static const TOWER_CLICKED_EVENT : String = "TOWER_CLICKED";
		public static const SIMPLE_TOWER : String = "simpleTower";
		
		
		public static const IDLE   : String = "idle";
		public static const FIRING : String = "firing";
		
		// Properties
		public var angle : Number = 0;
		private var _cost : int = 50;
		private var _sellPrice : int = 0;
		private var _position : Position = new Position();
		private var _targetList : Vector.<Creep>;
		private var target : Creep = null;
		public var type : String = "";
		
		public var image : String = "";
		public var level : int = 1;
		
		private var _row : int;
		private var _col : int;
		private var _showRange : Boolean = true;
		
		// RELOAD && FIRE
		public var damage       : uint = 1;
		public var range        : uint = 250;
		public var reloaded     : Boolean = true;
		public var reloadTime   : Number = 2; 					// IN SECOND
		public var timeToReload : Number = 2;
		
		// GRAPHICS
		private var baseImage   : Image;
		private var towerImage  : Image;
		private var rangeGraphics : Sprite = new Sprite();
		
		public function Tower() 
		{
			
		}
		
		public function init(row:int, col:int, type:String = ""):void 
		{
			this.row  = row;
			this.col  = col;
			this.type = type;
			
			setTypeSpecificAttributes();
		}
		
		private function setTypeSpecificAttributes():void 
		{
			var towerProps : XMLList = Units.getTowerTypeAtUpgradeLevel(type, level);
			
			for each(var typeSpecPropety : XML in towerProps) 
			{
				var propName  : String = typeSpecPropety.localName();
				var propValue : Object= typeSpecPropety;
				this[propName] = propValue;
			}
		}
		
		public function upgrade():void 
		{
			level++;
			
			setTypeSpecificAttributes();
			
			updateRangeGraphics();
			
			removeChild(towerImage);
			towerImage = new Image(Assets.getTexture(image));
			towerImage.pivotX = 16;
			towerImage.pivotY = 16;
			towerImage.useHandCursor = true;
			addChild(towerImage);
		}
		
		private function updateRangeGraphics():void 
		{
			rangeGraphics.removeChildAt(0);
			rangeGraphics.addChild(SimpleGraphics.drawCircle(-range, -range, range, 1, 0xff0000));
		}
		
		public function addGraphics():void 
		{
			baseImage = new Image(Assets.getTexture("BaseSprite"));
			towerImage = new Image(Assets.getTexture(image));
			addRangeGraphics();
			
			towerImage.pivotX = 16;
			towerImage.pivotY = 16;
			baseImage.pivotX = 16;
			baseImage.pivotY = 16;
			
			addChild(baseImage);
			addChild(towerImage);
			
			baseImage.useHandCursor = true;
			towerImage.useHandCursor = true;
			
			addEventListener(TouchEvent.TOUCH, onClick);
		}
		
		private function addRangeGraphics():void 
		{
			addChild(rangeGraphics);
			rangeGraphics.touchable = false;
			rangeGraphics.visible = false;
			rangeGraphics.addChild(SimpleGraphics.drawCircle(-range, -range, range, 1, 0xff0000));
		}
		
		private function onClick(e:TouchEvent):void 
		{
			e.stopImmediatePropagation();
			
			var touch: Touch = e.getTouch(this);
			
			if (touch != null) 
			{
				if (touch.phase == TouchPhase.ENDED) {
					var event : Event = new Event(TOWER_CLICKED_EVENT, true, this);
					dispatchEvent(event);
				}
			}
		}
		
		public function setPositionRowCol(row:Number, col:Number):void 
		{
			// TODO REFACTOR
			// setPositionXY(col * Node.NODE_SIZE + Node.NODE_SIZE * 0.5, row * Node.NODE_SIZE + Node.NODE_SIZE * 0.5);
		}
		
		public function update(timeElapssed : Number) : void
		{
			checkIfTargetIsAlive();
			reloadProgress(timeElapssed);
			
			if(target == null || outOfRange(target) || target.health <= 0 ) {
				target = findTheFirstTargetInRange();
			}
			
			if (target != null) {
				rotateToTarget();
				if(reloaded) fire();
			}
		}
		
		private function checkIfTargetIsAlive():void 
		{
			if (target != null) {
				if (target.health <= 0) {
					target = null;
				}
			}
		}
		
		public function outOfRange(target:Creep):Boolean 
		{
			if (target == null) return true;
			
			if (Position.distance(target.position, this.position) > this.range) {
				return true;
			}
			
			return false;
		}
		
		public function reloadProgress(timeElapssed:Number):void 
		{
			if (!reloaded) {
				timeToReload -= timeElapssed;
				
				if (timeToReload <= 0) {
					reloaded = true;
					timeToReload = reloadTime;
				}
			}
		}
		
		public function showRange():void 
		{
			rangeGraphics.visible = true;
		}
		
		public function hideRange():void 
		{
			rangeGraphics.visible = false;
		}
		
		private function rotateToTarget():void 
		{
			var vect : Point = new Point;
			vect.x = target.x - this.x;
			vect.y = target.y - this.y;
			
			angle = Math.atan2(vect.y, vect.x);
			
			towerImage.rotation = angle;
		}
		
		private function findTheFirstTargetInRange():Creep
		{
			var nearestTarget : Creep = null;
			
			for each (var creep:Creep in targetList ) 
			{				
				if (Position.distance(creep.position, this.position) <= this.range && creep.health > 0 && !creep.isEscaped()) {
					return creep;
				}
			}
			
			return null;
		}
		
		private function fire():void 
		{
			// target.life -= this.damage;
			var projAttr : Dictionary = new Dictionary();
			projAttr["posx"] = this.x;
			projAttr["posy"] = this.y;
			projAttr["target"] = target;
			projAttr["damage"] = this.damage;
			
			Factory.addProjectil(projAttr);
			//target.life -= 1;
			
			reloaded = false;
			timeToReload = reloadTime;
		}
		
		public function get targetList():Vector.<Creep> 
		{
			return _targetList;
		}
		
		public function set targetList(value:Vector.<Creep>):void 
		{
			_targetList = value;
		}
		
		public function get row():int 
		{
			return _row;
		}
		
		public function set row(value:int):void 
		{
			_row = value;
			this.y = _row * Node.NODE_SIZE + Node.NODE_SIZE * 0.5;
		}
		
		public function get col():int 
		{
			return _col;
		}
		
		public function set col(value:int):void
		{
			_col = value;
			this.x = _col * Node.NODE_SIZE + Node.NODE_SIZE * 0.5;
		}
		
		public function get position():Position 
		{
			_position.x = x;
			_position.y = y;
			
			return _position;
		}
		
		public function set position(value:Position):void 
		{
			_position = value;
		}
		
		public function get cost():int 
		{
			return _cost;
		}
		
		public function set cost(value:int):void 
		{
			_cost = value;
			sellPrice += value * 0.7;
		}
		
		public function get sellPrice():int 
		{
			return _sellPrice;
		}
		
		public function set sellPrice(value:int):void 
		{
			_sellPrice = value;
		}
	}
}