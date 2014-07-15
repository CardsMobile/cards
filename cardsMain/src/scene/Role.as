package scene
{
	import com.greensock.TweenLite;
	
	import flash.utils.getTimer;
	
	import animation.MovieClipStarling;
	import animation.TextureAtlasStarling;
	
	import common.BloodFly;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Role extends Sprite
	{
		private var m_mc:MovieClipStarling;
		
		public static const STAND:int = 1;
		public static const WALK:int = 2;
		public static const FIGHT:int = 3;
		public static const DIE:int = 4;
		
		private var m_res:String = "";
		private var m_state:int = 0;
		private var m_id:int;
		private var m_direct:int;
		
		private var m_hp:int = 0;
		private var m_maxhp:int = 0;
		
		private var m_fight:int = 0;
		private var m_fightRate:int = 0;
		
		private var m_lastFight:Number=0;
		private var m_fightOver:Function;
		
		private var m_mcVec:Vector.<MovieClipStarling>;
		private var m_standMc:MovieClipStarling;
		private var m_fightMc:MovieClipStarling;
		
		public function Role(id:int, direct:int, res:String, lx:Number, ly:Number, hp:int, maxhp:int, fight:int, fightrate:int, fightOver:Function)
		{
			super();
			
			m_id = id;
			m_direct = direct;
			m_res = res;
			m_hp = hp;
			m_maxhp = maxhp;
			m_fight = fight;
			m_fightRate = fightrate;
			m_lastFight = getTimer();
			this.x = lx;
			this.y = ly;
			m_fightOver = fightOver;
			m_mcVec = new Vector.<MovieClipStarling>(5);
			
			doStand();
		}
		
		public function doStand():void
		{
			changeAct(STAND, true);
		}
		
		public function doFight():void
		{
			changeAct(FIGHT, false);
		}
		
		public function doWalk():void
		{
			changeAct(WALK, true);
		}
		
		private function getRes(st:int):String
		{
			var str:String = m_res;
			switch(st)
			{
				case STAND:
					str += "_stand_3";
					break;
				case WALK:
					str += "_walk_3";
					break;
				case FIGHT:
					str += "_attack_3";
					break;
			}
			return str;
		}
		
		private function changeAct(st:int, loop:Boolean):void
		{
			if(m_state == st) return;
			m_state = st;
			if(m_state == FIGHT) m_lastFight = getTimer();
			if(m_mc)
			{
				m_mc.removeFromParent(false);
				m_mc.stop();
				m_mc.removeEventListeners();
			}
			m_mc = m_mcVec[m_state];
			if(m_mc == null)
			{
				var atlas:TextureAtlasStarling = PreLoad.instance.getAtlas(m_res);
				m_mc = new MovieClipStarling(atlas, getRes(m_state), 6);
				m_mc.pivotX = m_mc.width/2;
				m_mc.x = 0;
				m_mcVec[m_state] = m_mc;
			}
			if(m_direct > 5) m_mc.scaleX = -1;
			else m_mc.scaleX = 1;
			m_mc.currentFrame = 1;
			m_mc.loop = loop;
			m_mc.play();
			if(!loop) m_mc.addEventListener(Event.COMPLETE, fightComplete);
			Starling.juggler.add(m_mc);
			addChildAt(m_mc, 0);
		}
		
		private function fightComplete(e:Event):void
		{
			doStand();
			if(m_fightOver) m_fightOver(this);
		}
		
		public function get HP():int
		{
			return m_hp;
		}
		
		public function set HP(hp:int):void
		{
			if(hp >= m_hp)
			{
				m_hp = hp;
			}else{
				var blood:BloodFly = new BloodFly(hp - m_hp);
				m_hp = hp;
				blood.x = - blood.width/2;
				blood.y = this.height/2;
				addChild(blood);
				blood.start();
			}
		}
		
		public function get maxHP():int
		{
			return m_maxhp;
		}
		
		public function get state():int
		{
			return m_state;
		}
		
		public function get id():int
		{
			return m_id;
		}
		
		public function get lastFight():Number
		{
			return m_lastFight;
		}
		
		public function get fightRate():int
		{
			return m_fightRate;
		}
		
		public function get fight():int
		{
			return m_fight;
		}
		
		public function isDie():Boolean
		{
			var b:Boolean = (m_hp <= 0);
			return b;
		}
		
		public function die():void
		{
			m_state = DIE;
			if(m_mc) m_mc.stop();
			
			TweenLite.to(this, 2, {alpha:0, onComplete:dispose});
		}
		
		public override function dispose():void
		{
			if(m_mc) m_mc.removeFromParent(true);
			m_mc = null;
			if(parent) this.removeFromParent(true);
		}
	}
}