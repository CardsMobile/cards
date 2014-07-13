package common
{
	public class TimeHandler
	{
		/**执行间隔*/
		public var delay:int;
		/**是否重复执行*/
		public var repeat:Boolean;
		/**是否使用帧*/
		public var useFrame:Boolean;
		/**执行时间*/
		public var exeTime:int;
		/**处理方法*/
		public var method:Function;
		/**参数*/
		public var args:Array;
		
		public function TimeHandler()
		{
		}
		
		/**清理*/
		public function clear():void
		{
			method = null;
			args = null;
		}
	}
}