package ui
{
	import common.AssetsLoader;
	import common.TickManager;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class Loading extends Sprite
	{
		private static var m_instance:Loading = new Loading;
		
		private var m_textField:TextField;
		
		public function Loading()
		{
			if(m_instance) throw new Error("single instance");
			super();
			init();
		}
		
		public static function get instance():Loading
		{
			return m_instance;
		}
		
		private function init():void
		{
			AssetsLoader.instance.load("assets/splash.jpg", loadComplete);
		}
		
		private function loadComplete(path:String, obj:Object):void
		{
			var bitmap:Bitmap = obj as Bitmap;
			bitmap.x = 960;
			bitmap.y = 640;
			addChild(bitmap);
			
			m_textField = new TextField();
			m_textField.textColor = 0x00ff00;
			m_textField.width = 960;
			m_textField.y = 560;
			m_textField.autoSize = TextFieldAutoSize.CENTER;
			m_textField.text = "资源加载中";
			addChild(m_textField);
			TickManager.instance.doLoop(1000, textLoop);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeFromState);
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
		
		private function removeFromState(e:Event):void
		{
			TickManager.instance.clearHandler(textLoop);
		}
	}
}