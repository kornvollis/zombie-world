package levels 
{
	import flash.xml.XMLNode;
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
				</towers>
				
				<blocks>
				</blocks>
				
				<waves>
				</waves>
			</map>;
		}
		
		public function addBlock(row : int, col : int):void
		{
			//data.insertChildAfter(data.blocks, <block row="5" col="1"></block>);
			var blockNode : XML = <block row='' col='' />;
			blockNode.@row = row;
			blockNode.@col = col;
			
			data.blocks.appendChild(blockNode);
		}
		
		public function toXMLString():String 
		{
			return data.toXMLString();
		}
		
		
		
	}

}