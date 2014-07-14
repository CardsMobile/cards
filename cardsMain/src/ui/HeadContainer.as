package ui
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import common.AssetsLoader;
	
	public class HeadContainer extends Sprite
	{
		private var head0:Head;
		private var head1:Head;
		private var head2:Head;
		private var head3:Head;
		private var head4:Head;
		private var head5:Head;
		private var iconArr:Array=["assets/Axe.jpg","assets/BatRider.jpg","assets/BB.jpg","assets/DragonTurtle.jpg","assets/Ench.jpg","assets/DragonBaby.jpg"];
		private var bmpArr:Array=[];
		public function HeadContainer()
		{
			super();
			load();
		}
		
		private function load(index:int = 0):void {
			AssetsLoader.instance.load(iconArr[index], complete);
		}
		
		private function complete(path:String, obj:Object):void
		{
			// TODO Auto Generated method stub
			var bmp:Bitmap = obj as Bitmap;
			bmpArr.push(bmp);
			if(bmpArr.length==6){
				init();
			}else{
				load(bmpArr.length);
			}
		}
		
		private function init():void {
			var curx:int=104;
			for(var i:int=0;i<6;i++){
				this["head"+i] = new Head();
				Head(this["head"+i]).setView(i,bmpArr[i]);
				Head(this["head"+i]).x = curx;
				addChild(Head(this["head"+i]));
			}
		}
		
		/**
		 *设置血量 
		 * @param curBlood
		 * @param maxBlood
		 * 
		 */		
		public function setBlood(id:int,curBlood:int,maxBlood:int):void {
			Head(this["head"+id]).setBlood(curBlood,maxBlood);
		} 
	}
}