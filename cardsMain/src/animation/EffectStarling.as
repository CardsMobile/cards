package animation
{
	import scene.PreLoad;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	public class EffectStarling extends Sprite
	{
		private var mfps:int;
		private var mres:String;
		private var mloop:Boolean;
		private var mdir:int=0; //方向，默认为0没方向
		
		private var mmc:MovieClipStarling;
		private var mplaying:Boolean;
		
		/**特效类starling
		 * @param type:ResType
		 * @param res:特效名
		 * @param dir:方向，0为无方向
		 * @param fps：帧率
		 * @param loop：是否循环播放
		 * */
		public function EffectStarling(res:String, dir:int=0, fps:int=8, loop:Boolean=false, autoPlay:Boolean=true)
		{
			mfps = fps;
			mres = res;
			mloop = loop;
			mdir = dir;
			mplaying = autoPlay;
			this.touchable = false;
			
			var atlas:TextureAtlasStarling = PreLoad.instance.getAtlas(mres);
			atlasAdded(res, atlas);
		}
		
		public function get loaded():Boolean
		{
			return (mmc!=null);
		}
		
		private function playComplete(e:Event):void
		{
			dispose();
		}
		
		private function atlasAdded(res:String, atlas:TextureAtlasStarling):void
		{
			mmc = new MovieClipStarling(atlas, res, mfps);
			if(mmc)
			{
				mmc.pivotX = mmc.width/2;
				mmc.x = 0;
				if(mdir > 5) mmc.scaleX = -1;
				addChild(mmc);
				if(mplaying) play();
			}
		}
		
		public function play():void
		{
			if(mmc)
			{
				if(mmc.currentFrame != 1) mmc.currentFrame = 1;
				mmc.play();
				Starling.juggler.add(mmc);
				if(mloop == false) mmc.addEventListener(Event.COMPLETE, playComplete);
			}
			mplaying = true;
		}
		
		public function stop():void
		{
			if(mmc)
			{
				Starling.juggler.remove(mmc);
				mmc.stop();
			}
			
			mplaying = false;
		}
		
		override public function dispose():void
		{
			if(mmc)
			{
				if(mmc.hasEventListener(Event.COMPLETE)) mmc.removeEventListener(Event.COMPLETE, playComplete);
				mmc.removeFromParent(true);
			}
			this.removeFromParent();
			super.dispose()
		}
	}
}