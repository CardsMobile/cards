/**
 * 简单Hash结构
 * @author bb
 */
package common{
	import flash.utils.Dictionary;
	
	public class HashMap {
		
		private var _map:Dictionary;
		private var _count:int = 0;
		
		/**
		 * 通过Key值来存储对象
		 */
		public function HashMap(bool:Boolean=false):void
		{
			_map = new Dictionary(bool);//false,强引用， true弱引用
		}
		
		/**
		 * put
		 */
		public function put(key:*, mapValue:*):void  {
			if (_map[key] == null) {
				_count++;
			}
			_map[key] = mapValue;
		}
		
		/**
		 * remove
		 */
		public function remove(key:*):void
		{
			if(_map[key] != null)
			{
				try {
					delete _map[key];
					_count--;
				} catch(e:Error){}
			}			
		}
		
		/**
		 * 清理所有项目
		 */
		public function clear():void {
			
			//清理Object内存
			for (var key:* in _map) {
				try {
					delete _map[key];
				} catch(e:Error){}
			}
			_count = 0;
		}
		
		/**
		 * 得到value
		 */
		public function getValue(key:*):* {
			return _map[key];
		}
		
		/**
		 * 得到keys
		 */
		public function getKeys():Array{
			var temp : Array = new Array(_count);
			var index : int = 0;
			for(var i:* in _map) {
				temp[index] = i;
				index++;
			}
			return temp;
		}
		
		/**
		 * 是否存在某项
		 */
		public function containsKey(key:*):Boolean {
			if (_map[key] == null) {
				return false;
			} else {
				return true;
			}
		}
		
		/**
		 * 得到节点数目
		 */
		public function size():int {
			return _count;
		}
		
		public function getMap():Dictionary
		{
			return _map;
		}
	}
}