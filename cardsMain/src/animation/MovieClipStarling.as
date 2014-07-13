package animation
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import engine.StarlingEngine;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.SubTexture;

	public class MovieClipStarling extends MovieClip
	{
		private var bmd:BitmapData;
		private var textureAtlas:TextureAtlasStarling;
		private var bmdWidth:Number = 0;
		private var bmdHeight:Number = 0;
		
		public function MovieClipStarling(atlas:TextureAtlasStarling, res:String, fps:Number=10)
		{
			bmd = atlas.bitmapData;
			bmdWidth = bmd.width;
			bmdHeight = bmd.height;
			textureAtlas = atlas;
			
			//trace("MovieClipStarling:" + res);
			super(atlas.getTextures(res), fps);
			addOverEvent();
		}
		
		private function addOverEvent():void
		{
			this.addEventListener(TouchEvent.TOUCH, overHandle);
		}
		
		private function overHandle(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this, TouchPhase.HOVER);
			if(touch == null) return;
			this.removeEventListener(TouchEvent.TOUCH, overHandle);
			
			e.stopImmediatePropagation();
			this.touchable = false;
			addEnterFrame();
		}
		
		private function addEnterFrame():void
		{
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandle);
		}
		
		private function removeEnterFrame():void
		{
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandle);
		}
		
		private function enterFrameHandle(e:Event):void
		{
			var mousepos:Point = this.globalToLocal(StarlingEngine.instance.mouseLocation);
			var bound:Rectangle = this.getBounds(this);
			
			if(bound.contains(mousepos.x, mousepos.y) == false)
			{
				this.touchable = true;
				removeEnterFrame();
				addOverEvent();
				return;
			}
			
			if(isTransparent(mousepos.x, mousepos.y))
			{
				this.touchable = false;
			}else{
				this.touchable = true;
			}
		}
		
		private var rect:Rectangle = new Rectangle();
		private function isInBound(sx:int, sy:int):Boolean
		{
			var b:Boolean;
			var subtex:SubTexture = this.texture as SubTexture;
			rect.x = -subtex.frame.x;
			rect.y = -subtex.frame.y;
			rect.width = subtex.clipping.width * bmdWidth;
			rect.height = subtex.clipping.height * bmdHeight;
			
			return rect.contains(sx, sy);
		}
		
		public function isTransparent(sx:Number, sy:Number):Boolean
		{
			var b:Boolean = true;
			
			var subtex:SubTexture = this.texture as SubTexture;
			
			rect.x = -subtex.frame.x;
			rect.y = -subtex.frame.y;
			rect.width = subtex.clipping.width * bmdWidth;
			rect.height = subtex.clipping.height * bmdHeight;
			if(rect.contains(sx, sy))
			{
				var tx:int = sx + subtex.frame.x + subtex.clipping.left * bmdWidth;
				var ty:int = sy + subtex.frame.y + subtex.clipping.top * bmdHeight;
				
				b = bmd == null ? false : bmd.getPixel32(tx, ty) >>> 24 == 0x00;
			}
			
			return b;
		}
		
		override public function dispose():void
		{
//			removeEnterFrame();
			Starling.juggler.remove(this);
			super.dispose();
		}
	}
}