package common
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class AssetsLoader
	{
		private static var m_instance:AssetsLoader;
		private var m_loaded:Dictionary;
		private var m_loading:Dictionary;
		
		public function AssetsLoader()
		{
			if(m_instance) throw new Error("Single instance");
			
			init();
		}
		
		public static function get instance():AssetsLoader
		{
			if(m_instance == null) m_instance = new AssetsLoader();
			return m_instance;
		}
		
		private function init():void
		{
			m_loaded = new Dictionary;
			m_loading = new Dictionary;
		}
		
		public function load(path:String, onComplete:Function):void
		{
			var assets:Object = m_loaded[path];
			if(assets)
			{
				if(onComplete != null) onComplete.apply(this, [path, assets]);
			}else{
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
				loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadError);
				loader.name = path;
				loader.load(new URLRequest(path));
				m_loading[path] = onComplete;
			}
		}
		
		private function loadComplete(e:Event):void
		{
			var loader:Loader = (e.target as LoaderInfo).loader;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadError);
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loadError);
			var assets:Object = loader.content;
			var path:String = loader.name;
			
			var backFunc:Function = m_loading[path];
			if(backFunc != null) backFunc.apply(this, [path, assets]);
			m_loading[path] = null;
			m_loaded[path] = assets;
			loader = null;
		}
		
		private function loadError(e:Error):void
		{
			var loader:Loader = (e.target as LoaderInfo).loader;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadError);
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loadError);
			throw new Error();
		}
	}
}