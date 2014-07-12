package engine
{
	import starling.display.Sprite;

	public class LayerView extends Sprite
	{
		private var scene:Sprite;
		private var ui:Sprite;
		
		public function LayerView()
		{
			scene = new Sprite();
			addChild(scene);
			ui = new Sprite();
			addChild(ui);
		}
		
		public function init():void
		{
			
		}
		
		public function get sceneLayer():Sprite
		{
			return scene;
		}
		
		public function get uiLayer():Sprite
		{
			return ui;
		}
	}
}