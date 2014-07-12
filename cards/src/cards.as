package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.media.AudioPlaybackMode;
	import flash.media.SoundMixer;
	
	import engine.StarlingEngine;
	
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
			
			StarlingEngine.instance.initStarling(this.stage);
		}
	}
}