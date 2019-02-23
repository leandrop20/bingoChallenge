package  {
	
	import flash.display.Sprite;
	import screens.Game;
	import flash.geom.Point;
	import flash.sampler.NewObjectSample;
	
	
	public class Main extends Sprite {
		
		public static const SIZE:Point = new Point(450, 768);
		
		public function Main() {
			addChild(new Game());
		}
	}
	
}