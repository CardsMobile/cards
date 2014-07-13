package engine
{
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.events.Event;

	public class StarlingEngine
	{
		private static var m_instance:StarlingEngine;
		private var m_starling:Starling;
		private var m_layer:LayerView;
		private var m_stage:Stage;
		
		public function StarlingEngine()
		{
			if(m_instance) throw new Error("Single instance");
			
		}
		
		public static function get instance():StarlingEngine
		{
			if(m_instance == null) m_instance = new StarlingEngine();
			return m_instance;
		}
		
		public function initStarling(stage:Stage):void
		{
			m_stage = stage;
			Starling.multitouchEnabled = false;
			Starling.handleLostContext = false;
			m_starling = new Starling(LayerView, stage,new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
			m_starling.simulateMultitouch  = false;
			m_starling.enableErrorChecking = false;
			m_starling.showStats = true;
			m_starling.showStatsAt("right", "top", 1);
			m_starling.addEventListener(Event.ROOT_CREATED, initOver);
		}
		
		private function initOver():void
		{
			m_layer = m_starling.root as LayerView;
			m_layer.init();
			m_starling.start();
		}
		
		public function get starling():Starling
		{
			return m_starling;
		}
		
		public function get rootLayer():LayerView
		{
			return m_layer;
		}
		
		public function get mouseLocation():Point
		{
			return new Point(m_stage.mouseX, m_stage.mouseY);
		}
	}
}