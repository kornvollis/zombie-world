package levels 
{
	import flash.xml.XMLNode;
	import org.as3commons.collections.ArrayList;
	import units.Box;
	import units.Turret;
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
				</towers>
				
				<blocks>
				</blocks>
				
				<exits>
				</exits>
				
				<waves>
					<wave row='3' col='1' start='5' density='40' type='BasicEnemy' />
				</waves>
			</map>;
		}
		
		public function loadMapData(xmlData : XML) : void
		{
			this.data = xmlData;
		}
		
		public function getExits() : ArrayList
		{
			var exits : ArrayList = new ArrayList();
			
			for each (var exit : XML in data.exits.exit) 
			{
				var new_exit : ExitPoint = new ExitPoint(int(exit.attribute("row")), int(exit.attribute("col")));
				exits.add(new_exit);
			}
			
			return exits;
		}
		
		public function getBlocks() : ArrayList
		{
			var blocks : ArrayList = new ArrayList();
			
			for each (var block : XML in data.blocks.block) 
			{
				var new_block : Box = new Box(int(block.attribute("row")), int(block.attribute("col")));
				blocks.add(new_block);
			}
			
			return blocks;
		}
		
		public function addTower(row:int, col:int, type:String):void
		{
			var towerNode : XML = <tower row='' col='' type='' />;
			towerNode.@row = row;
			towerNode.@col = col;
			towerNode.@type = type;
			
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
		
		public function addWave(start:int, density:int, row:int, col:int, type:String):void
		{
			var waveNode : XML = <wave row='' col='' start='' density='40' type='BasicEnemy' />;
			waveNode.@row = row;
			waveNode.@col = col;
			waveNode.@start = start;
			waveNode.@density = density;
			waveNode.@type = type;
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