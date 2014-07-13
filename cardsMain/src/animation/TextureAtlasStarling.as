package animation
{
	import flash.display.BitmapData;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class TextureAtlasStarling extends TextureAtlas
	{
		private var m_bmd:BitmapData;
		private var m_xml:XML;
		
		public function TextureAtlasStarling(_bitmapdata:BitmapData, _xml:XML)
		{
			m_bmd = _bitmapdata;
			m_xml = _xml;
			var texture:Texture = Texture.fromBitmapData(m_bmd, false);
			
			super(texture, _xml);
		}
		
		public function get bitmapData():BitmapData
		{
			return m_bmd;
		}
		
		public function get xml():XML
		{
			return m_xml;	
		}
	}
}