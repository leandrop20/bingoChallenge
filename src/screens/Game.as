package screens {
	import flash.display.Sprite;
	import elements.Card;
	import enums.TypeEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import elements.Hud;
	import enums.GameType;
	import flash.events.MouseEvent;
	
	public class Game extends Sprite {
		
		public static var checkType:GameType = GameType.PARTIAL;
		
		private const TIME_TO_RAFFLE:int = 4000;
		private const TOTAL_BALLS:int = 75;
			
		private var card:Card;
		private var hud:Hud;
		private var btStart:BtStart;
		private var btRestart:BtRestart;
		private var bingoPopup:Bingo;
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
			createBtStart();
		}
		
		private function createBtStart():void {
			btStart = new BtStart();
			btStart.x = Main.SIZE.x * 0.5;
			btStart.y = Main.SIZE.y * 0.5;
			addChild(btStart);
			btStart.addEventListener(MouseEvent.CLICK, onStart);
		}
		
		private function removeBtStart():void {
			if (btStart) {
				btStart.removeEventListener(MouseEvent.CLICK, onStart);
				removeChild(btStart);
				btStart = null;
			}
		}
		
		private function createBtRestart():void {
			btRestart = new BtRestart();
			btRestart.x = Main.SIZE.x * 0.5;
			btRestart.y = 680;
			addChild(btRestart);
			btRestart.addEventListener(MouseEvent.CLICK, onRestart);
		}
		
		private function removeBtRestart():void {
			if (btRestart) {
				btRestart.removeEventListener(MouseEvent.CLICK, onRestart);
				removeChild(btRestart);
				btRestart = null;
			}
		}
		
		private function onStart(e):void {
			removeBtStart();
			card.events(TypeEvent.ADD);
			timer.start();
		}
		
		private function onRestart(e):void {
			removeBtRestart();
			hud.reset();
			
			card.reset();
			raffledBalls.splice(0, raffledBalls.length);
			availableBalls.splice(0, availableBalls.length);
			removeChild(bingoPopup);
			
			card.create();
			onStart(null);
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
			
			bingoPopup = new Bingo();
			bingoPopup.x = Main.SIZE.x * 0.5;
			bingoPopup.y = Main.SIZE.y * 0.5;
			addChild(bingoPopup);
			
			createBtRestart();
		}

	}
	
} 
