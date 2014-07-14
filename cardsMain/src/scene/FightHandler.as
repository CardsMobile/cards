package scene
{
	import flash.utils.getTimer;
	
	import common.TickManager;
	
	import starling.display.Sprite;

	public class FightHandler
	{
		private static var m_instance:FightHandler = new FightHandler;
		private var m_panel:Sprite;
		private var m_leftList:Vector.<Role>;
		private var m_rightList:Vector.<Role>;
		
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
			
			m_leftList = new Vector.<Role>;
			m_rightList = new Vector.<Role>;
			
			m_leftList[0] = new Role(0, 7, "monster_pa_enemy030", 500, 0, 500, 500, 50, 2000, fightOverHandle);
			m_panel.addChild(m_leftList[0]);
			m_leftList[1] = new Role(1, 7, "monster_pa_enemy026", 600, 70, 500, 500, 50, 2200, fightOverHandle);
			m_panel.addChild(m_leftList[1]);
			m_leftList[2] = new Role(2, 7, "monster_pa_enemy014", 500, 140, 500, 500, 50, 1800, fightOverHandle);
			m_panel.addChild(m_leftList[2]);
			m_rightList[0] = new Role(3, 3, "monster_pa_enemy030", 500, 0, 500, 500, 50, 2000, fightOverHandle);
			m_panel.addChild(m_rightList[0]);
			m_rightList[1] = new Role(4, 3, "monster_pa_enemy026", 400, 70, 500, 500, 50, 2200, fightOverHandle);
			m_panel.addChild(m_rightList[1]);
			m_rightList[2] = new Role(5, 3, "monster_pa_enemy014", 500, 140, 500, 500, 50, 1800, fightOverHandle);
			m_panel.addChild(m_rightList[2]);
			
			TickManager.instance.doFrameLoop(1, fightLoop);
		}
		
		private function fightOverHandle(role:Role):void
		{
			
		}
		
		private function fightLoop():void
		{
			var now:Number = getTimer();
			var len:int = m_leftList.length;
			var role:Role;
			var i:int;
			for(i=0; i < len; ++i)
			{
				role = m_leftList[i];
				if(role.isDie()) role.die();
				
				if(role.state == Role.STAND)
				{
					if(now - role.lastFight >= role.fightRate)
					{
						role.doFight();
					}
				}
			}
			len = m_rightList.length;
			for(i=0; i < len; ++i)
			{
				role = m_rightList[i];
				if(role.isDie()) role.die();
				
				if(role.state == Role.STAND)
				{
					if(now - role.lastFight >= role.fightRate)
					{
						role.doFight();
					}
				}
			}
		}
		
		private function randomFight(fight:int):int
		{
			var value:int;
			value = fight + (Math.random()+0.5)*200;
			return value;
		}
	}
}