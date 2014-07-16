package ui
{
	import common.AssetsLoader;
	import common.HashMap;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class FightOver extends Sprite
	{
		private var iconArr:Array=["assets/battledone_failed_enhance.png",
			"assets/battledone_failed_herolevelup.png","assets/herodetail-detail-close.png",
			"assets/battledone_failed_equip.png","assets/stagedone_win_tag.png","assets/replaybtn.png"
		];
		private var bmpHash:HashMap = new HashMap;
		private var loadindex:int =0;
		private var loadb:Boolean = false;
		private var _vs:Boolean;
		private var _sheng:Sprite = new Sprite;
		private var _fu:Sprite = new Sprite;
		private var shape:Shape = new Shape;
		public function FightOver(v:Boolean)
		{
			super();
			shape.graphics.beginFill(0x00000, 0.8);
			shape.graphics.drawRect(0, 0, 960, 640);
			shape.graphics.endFill();
			addChild(shape);
			addChild(_sheng);
			addChild(_fu);
			vs = v;
			load();
		}
		
		
		
		private function load(index:int = 0):void {
			AssetsLoader.instance.load(iconArr[index], complete);
		}
		
		private function complete(path:String, obj:Object):void
		{
			var bmp:Bitmap = obj as Bitmap;
			var key:String = path.replace("assets/","");
			key = key.replace(".png","");
			key = key.replace(".jpg","");
			bmpHash.put(key,bmp);
			loadindex++;
			if(bmpHash.size()==iconArr.length){
				loadb = true;
				init();
			}else{
				load(loadindex);
			}
		}
		private var but:Sprite = new Sprite;
		private function init():void {
			//败
			var bmp:Bitmap;
			var rukou:Sprite;
			bmp = bmpHash.getValue("battledone_failed_enhance");
			bmp.y = 300;
			bmp.x =50;
			_fu.addChild(bmp);
			bmp = bmpHash.getValue("battledone_failed_herolevelup");
			bmp.y = 300;
			bmp.x =50+bmp.width+20;
			_fu.addChild(bmp);
			
			//胜利
			bmp = bmpHash.getValue("stagedone_win_tag");
			bmp.y = (640-bmp.width)*.5;
			bmp.x = (960-bmp.width)*.5;
			_sheng.addChild(bmp);
			var fanhui:Sprite = new Sprite();
			bmp = bmpHash.getValue("replaybtn");
			fanhui.addChild(bmp);
			fanhui.y = (640-bmp.height)*.5+150;
			fanhui.x = (960-bmp.width)*.5;
			
			fanhui.addEventListener(MouseEvent.CLICK,fanhuif);
			_sheng.addChild(fanhui);
			//按钮
			
			bmp = bmpHash.getValue("herodetail-detail-close");
			but.y = 250;
			but.x = 50;
			but.addChild(bmp);
			addChild(but);
			but.addEventListener(MouseEvent.CLICK,close);
		}
		
		private function close(e:MouseEvent=null):void {
			if(this.parent!=null){
				parent.removeChild(this);
			}
		}

		public function set vs(value:Boolean):void
		{
			_vs = value;
			setvisible();
		}
		
		private function fanhuif(e:MouseEvent=null):void{
			close();
		}
		
		private function setvisible():void {
			if(_vs){
				_sheng.visible=true;
				_fu.visible = false;
				but.visible = false;
				shape.visible = false;
			}else{
				_fu.visible = true;
				but.visible = true;
				_sheng.visible=false;
				shape.visible = true;
			}
		}

	}
}