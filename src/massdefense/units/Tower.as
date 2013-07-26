package massdefense.units 
{
	import adobe.utils.ProductManager;
	import com.greensock.easing.Linear;
	import com.greensock.plugins.SoundTransformPlugin;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	import flexunit.utils.ArrayList;
	import massdefense.assets.Assets;
	import massdefense.bullets.Beam;
	import massdefense.Factory;
	import massdefense.Game;
	import massdefense.misc.Position;
	import massdefense.misc.SimpleGraphics;
	import massdefense.pathfinder.Node;
	import massdefense.ui.tower.TowerSelection;
	import massdefense.Utils;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Tower extends GameObject 
	{
		// EVENTS
		public static const CLICK        : String = "TOWER_CLICKED";
		
		// FIRE TYPES
		public static const FT_POINT     : String = "ft_point";
		public static const FT_BEAM      : String = "ft_beam";
		public static const FT_DIRECTION : String = "ft_direction";
		
		//public static const SIMPLE_TOWER : String = "simpleTower";
		
		// STATES
		public static const IDLE         : String = "idle";
		public static const FIRING       : String = "firing";
		static public const HOVER        : String = "hover";
		static public const HOVER_OUT    : String = "hoverOut";
		
		// Properties
		public  var angle         : Number = 0;
		private var _cost         : int = 50;
		private var _upgradeCost  : int;
		private var _sellPrice    : int = 0;
		private var _position     : Position = new Position();
		private var _targetList   : Vector.<Creep>;
		public var splash         : Boolean = false;
		public var splashRange    : int = 0;
		private var target        : Creep = null;
		public var type           : String = "";
		
		public var image    : String = "";
		public var level    : int = 1;
		public var maxLevel : int = 1;
		
		private var _row       : int;
		private var _col       : int;
		private var _showRange : Boolean = true;
		
		// RELOAD && FIRE
		public var fireType     : String = FT_POINT;
		public var damage       : Number = 1;
		public var range        : uint = 250;
		public var reloaded     : Boolean = true;
		public var reloadTime   : Number = 2; 					// IN SECOND
		public var timeToReload : Number = 2;
		public var slowEffect   : Number = 1;
		public var slowDuration : Number = 0;
		// BEAM
		private var beam        : Beam = null;
		
		// GRAPHICS
		private var baseImage            : Image;
		private var upgradeIndicator     : Image;
		private var turretImage          : Image;
		private var rangeGraphics        : Sprite = new Sprite();
		public  var bulletImage          : String = "";
		public  var shopImage            : String = "";
		// private var towerSelection       : TowerSelection = new TowerSelection();
		
		// SOUNDS
		private var fireSound            : Sound;
		public  var fireSoundName        : String = "";
		
		public function Tower() {}
		
		public function update(timeElapssed : Number) : void
		{
			checkIfTargetIsAlive();
			reloadProgress(timeElapssed);
			
			if(outOfRange(target)) target = null;
			
			if (target == null) {
				//target = findTheFirstTargetInRange();
				target = findTheClosestTargetInRange();
				if (fireType == FT_BEAM) {
					reloaded = false;
					timeToReload = reloadTime;
				}
			}
			
			if (target != null) {
				rotateTurretToTarget();
				if (reloaded) fire(timeElapssed);
			}
			
			if (beam != null) beam.update(timeElapssed);
		}
		
		private function checkIfTargetIsAlive():void 
		{
			if (target != null) {
				if (target.health <= 0) {
					target = null;
					if (fireType == FT_BEAM) {
						reloaded = false;
						timeToReload = reloadTime;
					}
				}
			}
		}
		
		override public function injectProperties(properties:Object):void 
		{
			for (var property:String in properties) {
				if (this.hasOwnProperty(property)) {
					this[property] = properties[property];
				} else {
					throw new Error("Private or missing property: " + property);
				}
			}
			
			if(fireSoundName != "")	fireSound = Assets.getSound(fireSoundName);
		}
		
		public function upgrade():void 
		{
			level++;
			
			injectProperties(Units.getTowerProperties(type, level));
			
			updateRangeGraphics();
			
			removeChild(turretImage);
			turretImage = new Image(Assets.getTexture(image));
			turretImage.pivotX = turretImage.width*0.5;
			turretImage.pivotY = turretImage.height*0.5;
			turretImage.useHandCursor = true;
			addChild(turretImage);
		}
		
		private function updateRangeGraphics():void 
		{
			rangeGraphics.removeChildAt(0);
			rangeGraphics.addChild(SimpleGraphics.drawCircle(-range, -range, range, 1, 0xff0000));
		}
		
		override public function addGraphics():void 
		{
			baseImage = Assets.getImage("BaseSprite");
			addChild(baseImage);
			Utils.centerPivot(baseImage);
			
			turretImage = Assets.getImage(image);
			addChild(turretImage);
			Utils.centerPivot(turretImage);
			turretImage.touchable = false;
			
			addRangeGraphics();
			
			
			if (fireType == FT_BEAM) {
				if (beam == null) {
					beam = new Beam(position, range);
				}
				addChild(beam);
			}
			
			baseImage.useHandCursor = true;
			turretImage.useHandCursor = true;
			
			addEventListener(TouchEvent.TOUCH, onClick);
			
			upgradeIndicator = Assets.getImage("TowerUpgradeIndicator");
			addChild(upgradeIndicator);
			upgradeIndicator.y = -20;
			Utils.centerPivot(upgradeIndicator);
			TweenMax.to(upgradeIndicator, 0.5, { y: -30,yoyo :true, repeat: -1 , ease:Linear.easeNone} );
		}
		
		public function showUpgradeIndicator():void 
		{
			upgradeIndicator.visible = true;
		}
		
		public function hideUpgradeIndicator():void 
		{
			upgradeIndicator.visible = false;
		}
		
		private function addRangeGraphics():void 
		{
			addChildAt(rangeGraphics,0);
			rangeGraphics.touchable = false;
			rangeGraphics.visible = false;
			rangeGraphics.addChild(SimpleGraphics.drawCircle( -range, -range, range, 1, 0xff0000));
		}
		
		private function onClick(e:TouchEvent):void 
		{
			e.stopImmediatePropagation();
			
			var touch: Touch = e.getTouch(this);
			
			if (touch != null) 
			{
				if (touch.phase == TouchPhase.ENDED) {
					var event : Event = new Event(CLICK, true, this);
					dispatchEvent(event);
				} else if (touch.phase == TouchPhase.HOVER) {
					event = new Event(HOVER, true, this);
					dispatchEvent(event);
				} 
			} else if (!e.getTouch(this, TouchPhase.HOVER)) {
				//trace("hover out");
				event = new Event(HOVER_OUT, true, this);
				dispatchEvent(event);
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
		
		public function select():void 
		{
			showRange();
			//towerSelection.show();
		}
		
		public function deselect():void 
		{
			hideRange();
			//towerSelection.hide();
		}
		
		public function isMaxLevel() : Boolean {
			if (maxLevel == level) return true;
			else return false;
		}
		
		private function rotateTurretToTarget():void 
		{
			var vect : Point = new Point;
			vect.x = target.x - this.x;
			vect.y = target.y - this.y;
			
			angle = Math.atan2(vect.y, vect.x);
			
			turretImage.rotation = angle;
		}
		
		private function findTheFirstTargetInRange():Creep
		{			
			for each (var creep:Creep in targetList ) 
			{				
				if (Position.distance(creep.position, this.position) <= this.range && creep.health > 0 && !creep.isEscaped()) {
					return creep;
				}
			}
			
			return null;
		}
		
		private function findTheClosestTargetInRange():Creep
		{
			var target      : Creep  = null;
			var minDistance : Number = 0;
			
			for each (var creep:Creep in targetList ) 
			{
				var creepDistance : Number = Position.distance(creep.position, this.position);
				if (creepDistance <= this.range && creep.health > 0) {
					//trace("haho3");
					if (target == null) {
						target = creep;
						minDistance = creepDistance;
						//trace("haho2");
					} else {
						if (minDistance > creepDistance) {
							target = creep;
							minDistance = creepDistance;
							//trace("haho");
						}
					}
				}
			}
			
			return target;
		}
		
		private function fire(timeElapssed:Number):void 
		{
			switch (fireType) 
			{
				case FT_POINT:
					pointFire();
				break;
				case FT_BEAM:
					beamFire(timeElapssed);
				break;
				case FT_BEAM:
					directionFire();
				break;
				default:
			}
		}
		
		private function directionFire():void 
		{
			//Factory.fireToDirection(point:Point, this);
		}
		
		private function beamFire(timeElapssed:Number):void 
		{			
			if (beam.beamReleased == false) {
				beam.beamReleased = true;
				//fireSound.play();
			}
			beam.target = target;

			target.health -= damage * timeElapssed;
			target.slow(slowDuration, slowEffect);
		}
		
		private function pointFire():void 
		{
			if(fireSound != null && !Game.muted)fireSound.play();
			
			var towerPosition : Position = new Position;
			towerPosition.x = x; towerPosition.y = y;
			var bulletPorperties : BulletProperties = new BulletProperties;
			bulletPorperties.damage = damage;
			bulletPorperties.image = bulletImage;
			bulletPorperties.splash = splash;
			bulletPorperties.splashRange = this.splashRange;
			bulletPorperties.slowDuration = slowDuration;
			bulletPorperties.slowEffect = slowEffect;
			
			Factory.addProjectil(target, towerPosition, bulletPorperties);
			
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
		
		public function get upgradeCost():int 
		{
			return _upgradeCost;
		}
		
		public function set upgradeCost(value:int):void 
		{
			_upgradeCost = value;
		}
	}
}