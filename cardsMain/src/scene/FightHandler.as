package scene
{
	public class FightHandler
	{
		private static var m_instance:FightHandler = new FightHandler;
		
		public function FightHandler()
		{
			if(m_instance) throw new Error("Single instance");
			init();
		}
		
		public static function get instance():FightHandler
		{
			return m_instance;
		}
		
		private function init():void
		{
			
		}
	}
}