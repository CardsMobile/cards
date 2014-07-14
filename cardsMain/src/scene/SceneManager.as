package scene
{
	import flash.display.Bitmap;
	
	import common.AssetsLoader;
	import common.AssetsUtil;
	
	import engine.StarlingEngine;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	import ui.HeadContainer;

	public class SceneManager
	{
		private static var m_instance:SceneManager = new SceneManager;
		private var m_mapLayer:Sprite;
		private var m_skyLayer:Sprite;
		
		private var m_mainMap:MainMap;
		private var m_fightMap:FightMap;
		private var m_fightView:Sprite;
		
		private var m_head:HeadContainer;
		
		public function SceneManager()
		{
			if(m_instance) throw new Error("Single instance");
		}
		
		public static function get instance():SceneManager
		{
			return m_instance;
		}
		
		public function init():void
		{
			m_skyLayer = new Sprite;
			StarlingEngine.instance.rootLayer.sceneLayer.addChild(m_skyLayer);
			AssetsLoader.instance.load("assets/main_bg_sky_left.jpg", skyComplete);
			
			m_mapLayer = new Sprite();
			StarlingEngine.instance.rootLayer.sceneLayer.addChild(m_mapLayer);
			
			showMainMap();
		}
		
		private function skyComplete(path:String, obj:Object):void
		{
			var sky:Bitmap = obj as Bitmap;
			var image:Image = AssetsUtil.instance.getImageFromBitmap(sky);
			image.width = 960;
			image.height = 640;
			m_skyLayer.addChild(image);
		}
		
		public function showMainMap():void
		{
			if(m_mainMap == null) m_mainMap = new MainMap();
			while(m_mapLayer.numChildren) m_mapLayer.removeChildAt(0);
			
			m_mapLayer.addChild(m_mainMap);
		}
		
		public function startFight():void
		{
			if(m_fightMap == null) m_fightMap = new FightMap();
			while(m_mapLayer.numChildren) 
			{
				m_mapLayer.removeChildAt(0);
			}
			m_mapLayer.addChild(m_fightMap);
			
			if(m_fightView == null) m_fightView = new Sprite();
			m_mapLayer.addChild(m_fightView);
			FightHandler.instance.init(m_fightView);
			
			if(m_head == null) m_head = new HeadContainer;
			StarlingEngine.instance.curStage.addChild(m_head);
		}
		
		public function get head():HeadContainer
		{
			return m_head;
		}
	}
}