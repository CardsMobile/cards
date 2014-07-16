package ui
{
	import common.AssetsLoader;
	import common.HashMap;
	
	import engine.StarlingEngine;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import scene.SceneManager;

	public class Fuben extends Sprite
	{
		private var con:Sprite = new Sprite;
		private var iconArr:Array=["assets/stage-map-frame.png",
			"assets/stageselect_map_bg_6.jpg","assets/map6.png",
			"assets/build/stage-1.png","assets/build/stage-11.png",
			"assets/build/stage-20.png","assets/build/stage-23.png",
			"assets/build/stage-27.png","assets/build/stage-30.png",
			"assets/build/stage-4.png","assets/build/stage-7.png","assets/backbtn.png"
		];
		private var bmpHash:HashMap = new HashMap;
		private var loadindex:int =0;
		private var w:int =936;
		private var h:int = 507;
		private var but:Sprite;
		private var loadb:Boolean = false;
		public function Fuben()
		{
			super();
			con.y = 120;
			con.scrollRect = new Rectangle(0,0,0,0);
			addChild(con);
			load();
		}
		private var xx:int=0;
		private var yy:int=0;
		private var timer:Timer = new Timer(1);
		public function setScale(e:TimerEvent):void {
			xx+=200;
			yy+=200;
			if(xx>=936){
				xx = 936;
			}
			if(yy>=507){
				yy=507;
			}
			con.scrollRect = new Rectangle(0,0,xx,yy);
			if(xx==936&&yy==507){
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,setScale);
				xx=0;
				yy=0;
			}
		}
		
		private function load(index:int = 0):void {
			AssetsLoader.instance.load(iconArr[index], complete);
		}
		
		private function complete(path:String, obj:Object):void
		{
			var bmp:Bitmap = obj as Bitmap;
			var key:String = path.replace("assets/","");
			key = key.replace("build/","");
			key = key.replace(".png","");
			key = key.replace(".jpg","");
			bmpHash.put(key,bmp);
			loadindex++;
			if(bmpHash.size()==iconArr.length){
				loadb = true;
				init();
				timer.addEventListener(TimerEvent.TIMER,setScale);
				timer.start();
			}else{
				load(loadindex);
			}
		}
		
		private function init():void {
			var bmp:Bitmap;
			var rukou:Sprite;
			bmp = bmpHash.getValue("stageselect_map_bg_6");
			bmp.width = 917;
			bmp.height = 485;
			bmp.x = 9;
			bmp.y = 9;
			con.addChild(bmp);
			bmp = bmpHash.getValue("stage-map-frame");
			con.addChild(bmp);
			bmp = bmpHash.getValue("map6");
			bmp.x = 118;
			bmp.y = 76;
			con.addChild(bmp);
			rukou = getRukou("stage-1");
			rukou.x = 164;
			rukou.y = 104
			con.addChild(rukou);
			rukou = getRukou("stage-11");
			rukou.x = 171;
			rukou.y = 225;
			con.addChild(rukou);
			rukou = getRukou("stage-20");
			rukou.x = 292;
			rukou.y = 293;
			con.addChild(rukou);
			rukou = getRukou("stage-23");
			rukou.x = 394;
			rukou.y = 92;
			con.addChild(rukou);
			rukou = getRukou("stage-27");
			rukou.x = 432;
			rukou.y = 235;
			con.addChild(rukou);
			rukou = getRukou("stage-30");
			rukou.x = 579;
			rukou.y = 99;
			con.addChild(rukou);
			rukou = getRukou("stage-4");
			rukou.x = 595;
			rukou.y = 313;
			con.addChild(rukou);
			rukou = getRukou("stage-7");
			rukou.x = 694;
			rukou.y = 212;
			con.addChild(rukou);
			//按钮
			but = new Sprite;
			bmp = bmpHash.getValue("backbtn");
			but.y = bmp.height;
			but.addChild(bmp);
			addChild(but);
			but.addEventListener(MouseEvent.CLICK,close);
			
		}
		
		private function getRukou(st:String):Sprite{
			var rukou:Sprite = new Sprite;
			var bmp:Bitmap;
			bmp = bmpHash.getValue(st);
			rukou.addChild(bmp);
			rukou.addEventListener(MouseEvent.CLICK,click);
			return rukou;
		}
		
		private function click(e:MouseEvent):void {
			close();
			SceneManager.instance.startFight();
		}
		
		private function close(e:MouseEvent=null):void {
			if(this.parent!=null){
				con.scrollRect = new Rectangle(0,0,0,0);
				parent.removeChild(this);
			}
		}
		
		public function open():void {
			StarlingEngine.instance.curStage.addChild(this);
			if(loadb){
				timer.addEventListener(TimerEvent.TIMER,setScale);
				timer.start();
			}
		}
	}
}