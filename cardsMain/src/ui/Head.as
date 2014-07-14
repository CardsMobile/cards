package ui
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	
	public class Head extends Sprite
	{
		private var headicon:Bitmap;
		private var blood:Shape;
		private var _id:int;
		private var _icon:String;
		private static const W:int = 104;
		public function Head()
		{
			super();
		}
		
		public function setView(rid:int,ico:Bitmap):void {
			_id = rid;
			//获取bitmapdata
			headicon = ico;
			addChild(headicon);
			blood = new Shape();
			blood.y = 104;
			addChild(blood);
		}
		
		/**
		 *设置血量 
		 * @param curBlood
		 * @param maxBlood
		 * 
		 */		
		public function setBlood(curBlood:int,maxBlood:int):void {
			var curW:int;
			blood.graphics.clear();
			if(curBlood>0){
				curW = W *(curBlood/maxBlood);
				blood.graphics.beginFill(0xff0000, 1);
				blood.graphics.drawRect(0, 0, curW, 5);
				blood.graphics.endFill();
			}else{
				setHui();	
			}
		}
		
		/**图片变灰*/
		public function setHui():void
		{
			var _nRed:Number=0.3086;
			var _nGreen:Number=0.6094;
			var _nBlue:Number=0.0820;
			filters=[new ColorMatrixFilter([_nRed, _nGreen, _nBlue, 0, 0, _nRed, _nGreen, _nBlue, 0, 0, _nRed, _nGreen, _nBlue, 0, 0, 0, 0, 0, 1, 0])];
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		public function get icon():String
		{
			return _icon;
		}

		public function set icon(value:String):void
		{
			_icon = value;
		}


	}
}