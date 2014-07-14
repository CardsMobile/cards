package scene
{
	import flash.utils.getTimer;
	
	import animation.MovieClipStarling;
	import animation.TextureAtlasStarling;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Role extends Sprite
	{
		private var m_mc:MovieClipStarling;
		
		public static const STAND:int = 1;
		public static const FIGHT:int = 2;
		public static const DIE:int = 3;
		
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
			
			doStand();
		}
		
		public function doStand():void
		{
			if(m_state == STAND) return;
			if(m_mc)
			{
				m_mc.removeFromParent(false);
				m_mc.stop();
				m_mc.removeEventListeners();
			}
			if(m_standMc == null)
			{
				var atlas:TextureAtlasStarling = new TextureAtlasStarling(PreLoad.instance.getBitmap(m_res).bitmapData, PreLoad.instance.getXml(m_res));
				m_standMc = new MovieClipStarling(atlas, m_res+"_stand_3", 6);
			}
			m_mc = m_standMc;
			if(m_direct > 5) m_mc.scaleX = -1;
			else m_mc.scaleX = 1;
			m_mc.play();
			Starling.juggler.add(m_mc);
			addChild(m_mc);
			m_state = STAND;
		}
		
		public function doFight():void
		{
			if(m_state == FIGHT) return;
			m_lastFight = getTimer();
			m_state = FIGHT;
			if(m_mc)
			{
				m_mc.removeFromParent(false);
				m_mc.stop();
				m_mc.removeEventListeners();
			}
			if(m_fightMc == null)
			{
				var atlas:TextureAtlasStarling = new TextureAtlasStarling(PreLoad.instance.getBitmap(m_res).bitmapData, PreLoad.instance.getXml(m_res));
				m_fightMc = new MovieClipStarling(atlas, m_res+"_attack_3", 6);
			}
			m_mc = m_fightMc;
			if(m_direct > 5) m_mc.scaleX = -1;
			else m_mc.scaleX = 1;
			m_mc.currentFrame = 1;
			m_mc.loop = false;
			m_mc.play();
			m_mc.addEventListener(Event.COMPLETE, fightComplete);
			Starling.juggler.add(m_mc);
			addChild(m_mc);
			
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
			m_hp = hp;
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
			if(m_mc) m_mc.removeFromParent(true);
			m_mc = null;
			if(parent) this.removeFromParent(true);
		}
	}
}