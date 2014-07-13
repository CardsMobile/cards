package scene
{
	import starling.display.Sprite;

	public class FightHandler
	{
		private static var m_instance:FightHandler = new FightHandler;
		private var m_panel:Sprite;
		private var m_roleList:Vector.<Role>;
		
		public function FightHandler()
		{
			if(m_instance) throw new Error("Single instance");
		}
		
		public static function get instance():FightHandler
		{
			return m_instance;
		}
		
		public function init(panel:Sprite):void
		{
			m_panel = panel;
			
			m_roleList = new Vector.<Role>;
			m_roleList[0] = new Role(0, "monster_pa_enemy030", 100, 20, 500, 500, 50, 50);
			m_panel.addChild(m_roleList[0]);
			m_roleList[1] = new Role(1, "monster_pa_enemy030", 170, 80, 500, 500, 50, 50);
			m_panel.addChild(m_roleList[1]);
			m_roleList[2] = new Role(2, "monster_pa_enemy030", 100, 140, 500, 500, 50, 50);
			m_panel.addChild(m_roleList[2]);
			m_roleList[3] = new Role(3, "monster_pa_enemy030", 400, 20, 500, 500, 50, 50);
			m_panel.addChild(m_roleList[3]);
			m_roleList[4] = new Role(4, "monster_pa_enemy030", 470, 80, 500, 500, 50, 50);
			m_panel.addChild(m_roleList[4]);
			m_roleList[5] = new Role(5, "monster_pa_enemy030", 400, 140, 500, 500, 50, 50);
			m_panel.addChild(m_roleList[5]);
		}
	}
}