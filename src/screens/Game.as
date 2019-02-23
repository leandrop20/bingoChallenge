package screens {
	import flash.display.Sprite;
	import elements.Card;
	import enums.TypeEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import elements.Hud;
	
	public class Game extends Sprite {

		private const TIME_TO_RAFFLE:int = 1000;
		private const TOTAL_BALLS:int = 75;
			
		private var card:Card;
		private var hud:Hud;
		private var timer:Timer;
		
		private var availableBalls:Vector.<int>;
		private var raffledBalls:Vector.<int>;
		
		public function Game() {
			var bg:Bg = new Bg();
			bg.x = Main.SIZE.x * 0.5;
			bg.y = Main.SIZE.y * 0.5;
			addChild(bg);
			
			card = new Card(checkNumber, callBingo);
			addChild(card);
			
			hud = new Hud();
			addChild(hud);
			
			timer = new Timer(TIME_TO_RAFFLE, 75);
			timer.addEventListener(TimerEvent.TIMER, raffle);
			
			availableBalls = new Vector.<int>();
			raffledBalls = new Vector.<int>();
			
			card.create();
			start();
		}
		
		private function start():void {
			card.events(TypeEvent.ADD);
			timer.start();
		}
		
		private function reset():void {
			card.reset();
			raffledBalls.splice(0, raffledBalls.length);
			availableBalls.splice(0, availableBalls.length);
		}
		
		private function raffle(e:TimerEvent):void {
			if (availableBalls.length == 0) {
				for (var i:int = 0; i < TOTAL_BALLS; i++) {
					availableBalls.push(i + 1);
				}
			}
			var rand:int = Math.random() * availableBalls.length;
			raffledBalls.push(availableBalls[rand]);
			hud.showBall(raffledBalls[raffledBalls.length - 1]);
			availableBalls.splice(rand, 1);
		}
		
		public function checkNumber(number:int):Boolean {
			for (var i:int = 0; i < raffledBalls.length; i++) {
				if (raffledBalls[i] === number) {
					return true;
				}
			}
			return false;
		}
		
		public function callBingo():void  {
			timer.stop();
			card.events(TypeEvent.REMOVE);
		}

	}
	
} 
