package levels 
{
	import flash.xml.XMLNode;
	import org.as3commons.collections.ArrayList;
	import units.Box;

	/**
	 * ...
	 * @author OML!
	 */
	public class LevelData
	{
		private var data : XML = new XML();
		
		public function LevelData() 
		{
			//INIT MAP SKELETON
			this.data = 
			<map>
				<title>
				</title>
				
				<towers>
					<!-- 
					<tower row='3' col='1' myclass='Cannon' />
					-->
				</towers>
				
				<blocks>
				</blocks>
				
				<exits>
				</exits>
				
				<waves>
					<!-- 
					<wave row='3' col='1' start='5' density='40' myclass='BasicEnemy' />
					-->
				</waves>
			</map>;
		}
		
		public function setLevelDataFromXML(xmlData : XML) : void
		{
			this.data = xmlData;
		}
		
		public function getExitsObjects() : ArrayList
		{
			var exits : ArrayList = new ArrayList();
			
			for each (var exit : XML in data.exits.exit) 
			{
				var exitObj : Object = new Object();
				exitObj.row = int(exit.attribute("row"));
				exitObj.col = int(exit.attribute("col"));
				exits.add(exitObj);
			}
			
			return exits;
		}
		
		public function getBlockObjects() : ArrayList
		{
			var blocks : ArrayList = new ArrayList();
			
			for each (var block : XML in data.blocks.block) 
			{
				var blockObject : Object = new Object();
				blockObject.row = int(block.attribute("row"));
				blockObject.col = int(block.attribute("col"));
				
				blocks.add(blockObject);
			}
			
			return blocks;
		}
		
		public function getTowerObjects() : ArrayList
		{
			var towers : ArrayList = new ArrayList();
			
			for each (var tower : XML in data.towers.tower) 
			{
				var row : int = int(tower.attribute("row"));
				var col : int = int(tower.attribute("col"));
				var towerClass : String = String(tower.attribute("myclass"));
				
				var towerObject : Object = new Object();
				towerObject.row = row;
				towerObject.col = col;
				towerObject.towerClass = towerClass;
				
				towers.add(towerObject);
			}
			
			return towers;
		}
		
		public function getWaveObjects() : ArrayList
		{
			var waves : ArrayList = new ArrayList();
			
			for each (var wave : XML in data.waves.wave) 
			{
				var row : int = int(wave.attribute("row"));
				var col : int = int(wave.attribute("col"));
				var start : int = int(wave.attribute("start"));
				var density : int = int(wave.attribute("density"));
				var enemyClass : String = String(wave.attribute("myclass"));
				
				var waveObject : Object = new Object();
				waveObject.row = row;
				waveObject.col = col;
				waveObject.start = start;
				waveObject.density = density;
				waveObject.enemyClass = enemyClass;
				
				waves.add(waveObject);
			}
			
			return waves;
		}
		
		public function addTower(row:int, col:int, myclass:String):void
		{
			var towerNode : XML = <tower row='' col='' myclass='' />;
			towerNode.@row = row;
			towerNode.@col = col;
			towerNode.@myclass = myclass;
			
			//INSERT TOWER IN THE XML
			data.towers.appendChild(towerNode);
		}
		
		public function addExitPoint(row:int, col:int):void 
		{
			var exitNode : XML = <exit row='' col=''  />;
			exitNode.@row = row;
			exitNode.@col = col;
			
			//INSERT TOWER IN THE XML
			data.exits.appendChild(exitNode);
		}
		
		public function addWave(row:int, col:int, start:int, num:int, density:int, type:String):void
		{
			var waveNode : XML = <wave row='' col='' start='' num='' density='40' myclass='BasicEnemy' />;
			waveNode.@row = row;
			waveNode.@col = col;
			waveNode.@start = start;
			waveNode.@num = num;
			waveNode.@density = density;
			waveNode.@myclass = type;
			
			data.waves.appendChild(waveNode);
		}
		
		public function addBlock(row : int, col : int):void
		{
			//data.insertChildAfter(data.blocks, <block row="5" col="1"></block>);
			var blockNode : XML = <block row='' col='' />;
			blockNode.@row = row;
			blockNode.@col = col;
			
			//INSERT BLOCK IN THE XML
			data.blocks.appendChild(blockNode);
		}
		
		public function toXMLString():String 
		{
			return data.toXMLString();
		}
		
	}

}