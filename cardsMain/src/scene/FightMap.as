package scene
{
	import flash.display.Bitmap;
	
	import common.AssetsLoader;
	import common.AssetsUtil;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class FightMap extends Sprite
	{
		private var bg:Sprite;
		
		public function FightMap()
		{
			super();
			init();
		}
		
		private function init():void
		{
			bg = new Sprite;
			AssetsLoader.instance.load("assets/bbg_cave_hall.jpg", bgComplete);
		}
		
		private function bgComplete(path:String, obj:Object):void
		{
			var bitmap:Bitmap = obj as Bitmap;
			var image:Image = AssetsUtil.instance.getImageFromBitmap(bitmap);
			image.scaleX = image.scaleY = 640/image.height;
			addChild(image);
		}
	}
}