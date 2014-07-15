package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.media.AudioPlaybackMode;
	import flash.media.SoundMixer;
	
	import common.TickManager;
	
	import engine.StarlingEngine;
	
	import scene.PreLoad;
	
	import ui.Loading;
	
	[SWF(backgroundColor="#000000")]
	public class cards extends Sprite
	{
		public function cards()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			// 支持 autoOrient
			stage.frameRate = 60;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.MEDIUM;
			stage.autoOrients = false;
			SoundMixer.audioPlaybackMode = AudioPlaybackMode.AMBIENT;
			
			addEventListener(Event.ENTER_FRAME, starlingCheck);
			StarlingEngine.instance.initStarling(this.stage);
		}
		
		private function starlingCheck(e:Event):void
		{
			if(StarlingEngine.instance.starling.isStarted)
			{
				removeEventListener(Event.ENTER_FRAME, starlingCheck);
				TickManager.instance.init(this.stage);
				this.stage.addChild(Loading.instance);
				PreLoad.instance.load(null);
				TickManager.instance.doOnce(3000, startGame);
			}
		}
		
		private function startGame():void
		{
			Loading.instance.showStart();
		}
	}
}