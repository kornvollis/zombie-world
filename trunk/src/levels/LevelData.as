package levels 
{
	import flash.xml.XMLNode;
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
				
				<waves>
					<wave row='3' col='1' start='5' density='40' type='BasicEnemy' />
				</waves>
			</map>;
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
		
		public function addWave(row:int, col:int, type:String):void
		{
			var waveNode : XML = <wave row='' col='' start='' density='40' type='BasicEnemy' />;
			waveNode.@row = row;
			waveNode.@col = col;
			waveNode.@start = start;
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