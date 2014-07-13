package common
{
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class AssetsUtil
	{
		private static var m_instance:AssetsUtil = new AssetsUtil;
		
		public function AssetsUtil()
		{
			if(m_instance) throw new Error("Single instance");
		}
		
		public static function get instance():AssetsUtil
		{
			return m_instance;
		}
		
		public function getImageFromBitmap(bitmap:Bitmap):Image
		{
			var tex:Texture = Texture.fromBitmap(bitmap);
			var image:Image = new Image(tex);
			return image;
		}
	}
}