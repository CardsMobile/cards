package scene
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
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
			
			m_leftList[0] = new Role(1, 7, "monster_pa_enemy026", 600 - 200 - 460, 70, 500, 500, 65, 2400, fightOverHandle);
			m_panel.addChild(m_leftList[0]);
			m_leftList[1] = new Role(0, 7, "monster_pa_enemy030", 500 - 200 - 460, 0, 500, 500, 50, 2000, fightOverHandle);
			m_panel.addChild(m_leftList[1]);
			m_leftList[2] = new Role(2, 7, "monster_pa_enemy014", 500 - 200 - 460, 140, 500, 500, 45, 1800, fightOverHandle);
			m_panel.addChild(m_leftList[2]);
			m_rightList[0] = new Role(4, 3, "monster_pa_enemy026", 400 + 222 + 460, 70, 500, 500, 60, 2400, fightOverHandle);
			m_panel.addChild(m_rightList[0]);
			m_rightList[1] = new Role(3, 3, "monster_pa_enemy030", 500 + 222 + 460, 0, 500, 500, 50, 2000, fightOverHandle);
			m_panel.addChild(m_rightList[1]);
			m_rightList[2] = new Role(5, 3, "monster_pa_enemy014", 500 + 222 + 460, 140, 500, 500, 48, 1800, fightOverHandle);
			m_panel.addChild(m_rightList[2]);
			
			for(var i:int=0; i < 3; ++i)
			{
				m_leftList[i].doWalk();
				TweenLite.to(m_leftList[i], 3, {x:m_leftList[i].x+460, ease:Linear.easeNone, onComplete:walkComplete, onCompleteParams:[m_leftList[i]]});
				m_rightList[i].doWalk();
				TweenLite.to(m_rightList[i], 3, {x:m_rightList[i].x-460, ease:Linear.easeNone, onComplete:walkComplete, onCompleteParams:[m_rightList[i]]});
			}
			TickManager.instance.doFrameLoop(1, fightLoop);
		}
		
		private function walkComplete(role:Role):void
		{
			role.doStand();
		}
		
		private function fightOverHandle(role:Role):void
		{
			var target:Role = findTarget(role.id);
			if(target)
			{
				target.HP -= randomFight(role.fight);
				SceneManager.instance.head.setBlood(target.id, target.HP, target.maxHP);
			}
		}
		
		private function findTarget(roleid:int):Role
		{
			var target:Role;
			var list:Vector.<Role>;
			list = roleid > 2 ? m_rightList : m_leftList;
			var len:int = list.length;
			for(var i:int=0; i < len; ++i)
			{
				var role:Role = list[i];
				if(role && role.state != Role.DIE)
				{
					target = role;
					break;
				}
			}
			
			return target;
		}
		
		private function fightLoop():void
		{
			var leftleft:int = 0;
			var rightleft:int = 0;
			var now:Number = getTimer();
			var len:int = m_leftList.length;
			var role:Role;
			var i:int;
			for(i=0; i < len; ++i)
			{
				role = m_leftList[i];
				if(role.isDie()) role.die();
				else leftleft++;
				
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
				else rightleft++;
				
				if(role.state == Role.STAND)
				{
					if(now - role.lastFight >= role.fightRate)
					{
						role.doFight();
					}
				}
			}
			
			if(leftleft + rightleft == 1)
			{
				TickManager.instance.clearHandler(fightLoop);
				SceneManager.instance.showMainMap();
			}
		}
		
		private function randomFight(fight:int):int
		{
			var value:int;
			value = fight + (Math.random()+0.5)*20;
			return value;
		}
	}
}