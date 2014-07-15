package common
{
	import com.greensock.TweenLite;
	
	import animation.TextureAtlasStarling;
	
	import scene.PreLoad;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class BloodFly extends Sprite
	{
		private static var m_atlas:TextureAtlasStarling;
		private static var m_textures:HashMap;
		
		private var m_num:int;
		
		public function BloodFly(num:int)
		{
			m_num = num;
			super();
			checkInit();
			showNum();
		}
		
		private function checkInit():void
		{
			if(m_atlas == null)
			{
				m_atlas = new TextureAtlasStarling(PreLoad.instance.getBitmap("digits").bitmapData, PreLoad.instance.getXml("digits"));
				m_textures = new HashMap();
				for(var i:int = 0; i < 10; ++i)
				{
					m_textures.put("red_" + i.toString(),  m_atlas.getTexture("red_" + i.toString()));
				}
				m_textures.put("red_-", m_atlas.getTexture("red_-"));
			}
		}
		
		private function showNum():void
		{
			var str:String = m_num.toString();
			var len:int = str.length;
			for(var i:int = 0; i < len; ++i)
			{
				var image:Image = new Image(m_textures.getValue("red_" + str.charAt(i)));
				image.x = this.width;
				addChild(image);
			}
		}
		
		public function start():void
		{
			TweenLite.to(this, 0.5, {y:y-60, onComplete:onComplete});
		}
		
		private function onComplete():void
		{
			this.removeFromParent(true);
		}
	}
}