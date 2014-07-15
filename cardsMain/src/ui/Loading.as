package ui
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import common.AssetsLoader;
	import common.TickManager;
	
	import scene.SceneManager;
	
	public class Loading extends Sprite
	{
		private static var m_instance:Loading;
		
		private var m_textField:TextField;
		
		public function Loading()
		{
			if(m_instance) throw new Error("single instance");
			init();
		}
		
		public static function get instance():Loading
		{
			if(m_instance == null) m_instance = new Loading;
			return m_instance;
		}
		
		private function init():void
		{
			AssetsLoader.instance.load("assets/splash.jpg", loadComplete);
		}
		
		private function loadComplete(path:String, obj:Object):void
		{
			var bitmap:Bitmap = obj as Bitmap;
			bitmap.width = 960;
			bitmap.height = 640;
			addChild(bitmap);
			
			m_textField = new TextField();
			m_textField.textColor = 0x00ff00;
			m_textField.width = 960;
			m_textField.y = 560;
			m_textField.autoSize = TextFieldAutoSize.CENTER;
			m_textField.text = "资源加载中";
			addChild(m_textField);
			TickManager.instance.doLoop(500, textLoop);
		}
		
		private var textindex:int = 0;
		private function textLoop():void
		{
			var text:String = "资源加载中";
			for(var i:int = 0; i < textindex; ++i)
			{
				text += ".";
			}
			++textindex;
			m_textField.text = text;
		}
		
		public function showStart():void
		{
			TickManager.instance.clearHandler(textLoop);
			if(m_textField.parent) m_textField.parent.removeChild(m_textField);
			m_textField = null;
			
			AssetsLoader.instance.load("assets/start.png", buttonComplete);
		}
		
		private function buttonComplete(path:String, obj:Object):void
		{
			var button:Sprite = new Sprite;
			var bitmap:Bitmap = obj as Bitmap;
			button.addChild(bitmap);
			var tf:TextField = new TextField;
			tf.width = bitmap.width;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.text = "开始游戏";
			tf.y = 12;
			tf.mouseEnabled = false;
			button.addChild(tf);
			button.addEventListener(MouseEvent.CLICK, start);
			
			button.x = (960 - button.width)/2;
			button.y = 520;
			addChild(button);
		}
		
		private function start(e:MouseEvent):void
		{
			SceneManager.instance.init();
		}
	}
}