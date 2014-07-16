package ui
{
	import common.AssetsLoader;
	
	import engine.StarlingEngine;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class HeadContainer extends Sprite
	{
		private var f:FightOver;
		private var head0:Head;
		private var head1:Head;
		private var head2:Head;
		private var head3:Head;
		private var head4:Head;
		private var head5:Head;
		private var iconArr:Array=["assets/Axe.jpg","assets/BatRider.jpg","assets/BB.jpg","assets/DragonTurtle.jpg","assets/Ench.jpg","assets/DragonBaby.jpg"];
		private var bmpArr:Array = new Array;
		private var blood:Array=[1,1,1,1,1,1];
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
		
		public function reset():void
		{
			for(var i:int=0;i<6;i++){
				Head(this["head"+i]).filters = null;
				Head(this["head"+i]).setBlood(1,1);
			}
		}
		
		private function init():void {
			var curx:int=104;
			for(var i:int=0;i<6;i++){
				this["head"+i] = new Head();
				Head(this["head"+i]).setView(i,bmpArr[i]);
				Head(this["head"+i]).x = curx;
				Head(this["head"+i]).setBlood(500,500);
				addChild(Head(this["head"+i]));
				curx = Head(this["head"+i]).x + 106;
			}
			this.x = 94;
			this.y = 640-height-10;
		}
		
		/**
		 *设置血量 
		 * @param curBlood
		 * @param maxBlood
		 * 
		 */		
		public function setBlood(id:int,curBlood:int,maxBlood:int):void {
			var b:Boolean;
			Head(this["head"+id]).setBlood(curBlood,maxBlood);
			blood[id] = curBlood;
			trace("blood"+id+"===="+curBlood);
			trace("blood1"+id+"===="+blood[0]+"===="+blood[1]+"===="+blood[2]);
			trace("blood2"+id+"===="+blood[3]+"===="+blood[4]+"===="+blood[5]);
			if(blood[0]<=0&&blood[1]<=0&&blood[2]<=0){
				b = false;
				fightover(b);
			}
			if(blood[3]<=0&&blood[4]<=0&&blood[5]<=0){
				b = true;
				fightover(b);
			}
		} 
		
		private function fightover(b:Boolean):void {
			if(f==null){
				f=new FightOver(b);
			}else{
				f.vs = b;
			}
			StarlingEngine.instance.curStage.addChild(f);
		}
	}
}