package scene
{
	import flash.display.Bitmap;
	
	import animation.MovieClipStarling;
	import animation.TextureAtlasStarling;
	
	import common.AssetsLoader;
	import common.AssetsUtil;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MainMap extends Sprite
	{
		private var up:Sprite;
		private var down:Sprite;
		private var npc:MovieClipStarling;
		
		public function MainMap()
		{
			super();
			init();
		}
		
		private function init():void
		{
			up = new Sprite;
			down = new Sprite;
			addChild(down);
			addChild(up);
			
			AssetsLoader.instance.load("assets/main_bg_grass_left.png", leftComplete);
			AssetsLoader.instance.load("assets/main_bg_grass_right.png", rightComplete);
			AssetsLoader.instance.load("assets/main_bg_mountain_left.png", downleftComplete);
			AssetsLoader.instance.load("assets/main_bg_mountain_right.png", downrightComplete);
			
			var atlas:TextureAtlasStarling = new TextureAtlasStarling(PreLoad.instance.getBitmap("npc_pa_enemy019").bitmapData, PreLoad.instance.getXml("npc_pa_enemy019"));
			npc = new MovieClipStarling(atlas, "npc_pa_enemy019_st_", 6);
			npc.x = 200;
			npc.y = 200;
			Starling.juggler.add(npc);
			addChild(npc);
			npc.addEventListener(TouchEvent.TOUCH, npcTouch);
		}
		
		private function leftComplete(path:String, obj:Object):void
		{
			var left:Bitmap = obj as Bitmap;
			var image:Image = AssetsUtil.instance.getImageFromBitmap(left);
			image.y = 640 - image.height;
			image.height = 640;
//			image.blendMode = BlendMode.ADD;
			up.addChild(image);
		}
		
		private function rightComplete(path:String, obj:Object):void
		{
			var right:Bitmap = obj as Bitmap;
			var image:Image = AssetsUtil.instance.getImageFromBitmap(right);
			image.x = 1189;
			image.y = 640 - image.height;
			image.height = 640;
//			image.blendMode = BlendMode.ADD;
			up.addChild(image);
		}
		
		private function downleftComplete(path:String, obj:Object):void
		{
			var downb:Bitmap = obj as Bitmap;
			var image:Image = AssetsUtil.instance.getImageFromBitmap(downb);
			image.y = 200;
//			image.blendMode = BlendMode.ADD;
			down.addChild(image);
		}
		
		private function downrightComplete(path:String, obj:Object):void
		{
			var downb:Bitmap = obj as Bitmap;
			var image:Image = AssetsUtil.instance.getImageFromBitmap(downb);
			image.y = 200;
			image.x = 528;
			//			image.blendMode = BlendMode.ADD;
			down.addChild(image);
		}
		
		private function npcTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if(touch == null) return;
			
			SceneManager.instance.startFight();
		}
	}
}