package scene
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.utils.Dictionary;
	
	import common.AssetsLoader;

	public class PreLoad
	{
		private static var m_instance:PreLoad = new PreLoad;
		
		private var m_preBm:Array = ["npc_pa_enemy019.png"];
		private var m_bmIndex:int = 0;
		private var m_preXml:Array = ["npc_pa_enemy019.xml"];
		private var m_xmlIndex:int = 0;
		private var m_backFunc:Function;
		
		private var m_bmPool:Dictionary;
		private var m_xmlPool:Dictionary;
		
		public function PreLoad()
		{
			if(m_instance) throw new Error("Single instance");
			
			m_bmPool = new Dictionary;
			m_xmlPool = new Dictionary;
		}
		
		public static function get instance():PreLoad
		{
			return m_instance;
		}
		
		public function load(onComplete:Function):void
		{
			m_backFunc = onComplete;
			AssetsLoader.instance.load("assets/"+m_preBm[m_bmIndex++], nextBm);
		}
		
		private function nextBm(path:String, obj:Object):void
		{
			var bm:Bitmap = obj as Bitmap;
			path = path.replace("assets/", "").replace(".png", "");
			m_bmPool[path] = bm;
			
			if(m_bmIndex == m_preBm.length)
			{
				startXml();
				return;
			}else{
				AssetsLoader.instance.load("assets/"+m_preBm[m_bmIndex++], nextBm);
			}
		}
		
		private function startXml():void
		{
			loadXml("assets/"+m_preXml[m_xmlIndex++]);
		}
		
		private function loadXml(path:String):void
		{
			var rootLoader:URLLoader = new URLLoader();
			rootLoader.addEventListener(Event.COMPLETE, nextXml);
			var header:URLRequestHeader = new URLRequestHeader("pragma", "no-cache");
			var request:URLRequest = new URLRequest(path);
			request.requestHeaders.push(header);
			rootLoader.load(request);
		}
		
		private function nextXml(e:Event):void
		{
			var rootLoader:URLLoader = e.target as URLLoader;
			rootLoader.removeEventListener(Event.COMPLETE, nextXml);
			var rsString:String = rootLoader.data as String;
			var xml:XML = XML(rsString);
			var path:String = m_preXml[m_xmlIndex - 1];
			path = path.replace("assets/", "").replace(".xml", "");
			m_xmlPool[path] = xml;
			
			if(m_xmlIndex == m_preXml.length)
			{
				m_backFunc.apply();
				return;
			}else{
				loadXml("assets/"+m_preXml[m_xmlIndex++]);
			}
		}
		
		public function getBitmap(name:String):Bitmap
		{
			var bitmap:Bitmap = m_bmPool[name];
			return bitmap;
		}
		
		public function getXml(name:String):XML
		{
			var xml:XML = m_xmlPool[name];
			return xml;
		}
	}
}