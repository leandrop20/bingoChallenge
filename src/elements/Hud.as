package elements {
	import flash.display.Sprite;
	
	public class Hud extends Sprite {

		private const BALLS_LIMIT:int = 3;
		
		private var balls:Vector.<Ball>;
		
		public function Hud() {
			balls = new Vector.<Ball>();
		}
		
		public function showBall(number:int):void {
			var ball:Ball = new Ball();
			ball.tf.text = number.toString();
			addChild(ball);
			balls.unshift(ball);
			
			positionBalls();
		}

		private function positionBalls():void {
			if (balls.length > BALLS_LIMIT) {
				removeChild(balls[balls.length - 1]);
				balls.pop();
			}
			
			var ball:Ball;
			for (var i:int = balls.length - 1; i > -1; i--) {
				ball = balls[i];
				ball.y = 60;
				if (i == 0) {
					ball.scaleX = ball.scaleY = 1.0;
					ball.x = Main.SIZE.x * 0.5;
				} else {
					ball.scaleX = ball.scaleY = 0.5;
					ball.x = 250 + (i * 40);
				}
			}
		}

	}
	
}
