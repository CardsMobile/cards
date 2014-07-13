package scene
{
	import animation.MovieClipStarling;
	import animation.TextureAtlasStarling;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	
	public class Role extends Sprite
	{
		private var m_mc:MovieClipStarling;
		
		public static const STAND:int = 1;
		public static const FIGHT:int = 2;
		public static const DIE:int = 3;
		
		private var m_res:String = "";
		private var m_state:int = 0;
		private var m_id:int;
		
		private var m_hp:int = 0;
		private var m_maxhp:int = 0;
		
		private var m_fight:int = 0;
		private var m_fightRate:int = 0;
		
		public function Role(id:int, res:String, lx:Number, ly:Number, hp:int, maxhp:int, fight:int, fightrate:int)
		{
			super();
			
			m_id = id;
			m_res = res;
			m_hp = hp;
			m_maxhp = maxhp;
			m_fight = fight;
			m_fightRate = fightrate;
			this.x = lx;
			this.y = ly;
			
			doStand();
		}
		
		public function doStand():void
		{
			if(m_state == STAND) return;
			if(m_mc)
			{
				m_mc.removeFromParent(true);
			}
			var atlas:TextureAtlasStarling = new TextureAtlasStarling(PreLoad.instance.getBitmap(m_res).bitmapData, PreLoad.instance.getXml(m_res));
			m_mc = new MovieClipStarling(atlas, m_res+"_stand_3", 6);
			Starling.juggler.add(m_mc);
			addChild(m_mc);
		}
		
		public function doFight():void
		{
			if(m_state == STAND) return;
			if(m_mc)
			{
				m_mc.removeFromParent(true);
			}
			var atlas:TextureAtlasStarling = new TextureAtlasStarling(PreLoad.instance.getBitmap(m_res).bitmapData, PreLoad.instance.getXml(m_res));
			m_mc = new MovieClipStarling(atlas, m_res+"_attack_3", 6);
			Starling.juggler.add(m_mc);
			addChild(m_mc);
		}
		
		public function get HP():int
		{
			return m_hp;
		}
		
		public function set HP(hp:int):void
		{
			m_hp = hp;
		}
		
		public function get state():int
		{
			return m_state;
		}
		
		public function get id():int
		{
			return m_id;
		}
	}
}