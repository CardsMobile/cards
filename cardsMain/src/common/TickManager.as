package common
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	/**
	 * 心跳管理器
	 */
	public class TickManager
	{
		
		private var i:int;
		
		private var lastSysTime:Number=0;
		private var mcount:int=0;
		private var mcurFrame:int=0;
		
		private var mcurTimer:Number=getTimer();
		private var mhandlers:Dictionary=new Dictionary;
		private var mpool:Vector.<TimeHandler>=new Vector.<TimeHandler>;
		
		private var ms120:Boolean;
		private var ms200:Boolean;
		private var ms400:Boolean;
		private var ms800:Boolean;

		/**
		 * 
		 * @default 
		 */
		public static var time:Number=0;
		private static var myinstance:TickManager=new TickManager();

		/**
		 * 
		 * @return 
		 */
		public static function get instance():TickManager
		{
			return myinstance;
		}

		/**
		 * 
		 * @throws Error
		 */
		public function TickManager()
		{
			if (myinstance != null)
				throw new Error("single instance");
		}

		/**
		 * 
		 * @param method
		 */
		public function clearHandler(method:Function):void
		{
			var handler:TimeHandler=mhandlers[method];
			if (handler != null)
			{
				//trace("删除了一个"+handler.useFrame + "," + handler.repeat + "," + handler.delay + "," + handler.method + "," + handler.args);
				delete mhandlers[method];
				handler.clear();
				mpool.push(handler);
				--mcount;
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get count():int
		{
			return mcount;
		}

		/**定时重复执行(基于帧率)*/
		public function doFrameLoop(delay:int, method:Function, args:Array=null):void
		{
			create(true, true, delay, method, args);
		}

		/**定时执行一次(基于帧率)*/
		public function doFrameOnce(delay:int, method:Function, args:Array=null):void
		{
			create(true, false, delay, method, args);
		}

		/**定时重复执行*/
		public function doLoop(delay:int, method:Function, args:Array=null):void
		{
			create(false, true, delay, method, args);
		}

		/**定时执行一次*/
		public function doOnce(delay:int, method:Function, args:Array=null):void
		{
			create(false, false, delay, method, args);
		}

		/**
		 * 
		 * @param stage
		 */
		public function init(stage:Stage):void
		{
			time=getTimer();
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);

		}

		private function create(useFrame:Boolean, repeat:Boolean, delay:int, method:Function, args:Array=null):void
		{
			//trace("添加了一个"+useFrame + "," + repeat + "," + delay + "," + method + "," + args);
			clearHandler(method);
			//执行时间小于1直接执行
			if (delay < 1)
			{
				method.apply(null, args);
				return;
			}

			var handler:TimeHandler=mpool.length > 0 ? mpool.pop() : new TimeHandler();
			handler.useFrame=useFrame;
			handler.repeat=repeat;
			handler.delay=delay;
			handler.method=method;
			handler.args=args;
			handler.exeTime=delay + (useFrame ? mcurFrame : mcurTimer);
			mhandlers[method]=handler;
			++mcount;
		}

		private function onEnterFrame(e:Event):void
		{
			var t:int;
			var handler:TimeHandler;
			var method:Function;
			var args:Array;

			time=getTimer();
			++mcurFrame;
			mcurTimer=getTimer();
			for each (handler in mhandlers)
			{
				t=handler.useFrame ? mcurFrame : mcurTimer;
				if (t >= handler.exeTime)
				{
					//trace("执行了一个"+handler.useFrame + "," + handler.repeat + "," + handler.delay + "," + handler.method + "," + handler.args);
					method=handler.method;
					args=handler.args;
					handler.repeat ? handler.exeTime+=handler.delay : clearHandler(method);
					if (args)
						method(args);
					else
						method();
				}
			}
		}
	}
}
