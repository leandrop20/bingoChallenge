package elements {
	import flash.display.Sprite;
	import enums.TypeEvent;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import screens.Game;
	import enums.GameType;
	
	public class Card extends Sprite {
		
		private var checkNumber:Function;
		private var callbackBingo:Function;
		
		private var bingoPopup:Bingo;
		
		private const SIZE:Point = new Point(5, 5);
		private const POSITION_INIT:Point = new Point(-164, -138);
		private const SPACE:int = 5;
		private const INTERVAL:int = 15;
		
		private var tfs:Array;

		public function Card(_checkNumber:Function, _callbackBingo:Function) {
			checkNumber = _checkNumber;
			callbackBingo = _callbackBingo;
			
			tfs = [];
			
			var bg:CardMc = new CardMc();
			bg.mouseEnabled = false;
			addChild(bg);
			
			x = Main.SIZE.x * 0.5;
			y = Main.SIZE.y * 0.5;
		}
		
		public function create():void {
			var numbers:Array = getNumbers();
			
			var tf:Tf;
			for (var i:int = 0; i < SIZE.x; i++) {
				tfs.push([]);
				for (var j:int = 0; j < SIZE.y; j++) {
					if (!(i === 2 && j === 2)) {
						tf = new Tf();
						tf.tf.text = numbers[i][j].toString();
						tf.x = POSITION_INIT.x + ((tf.width + SPACE) * i);
						tf.y = POSITION_INIT.y + ((tf.height + SPACE) * j);
						tf.mark.visible = false;
						addChild(tf);
						tfs[i][tfs[i].length] = tf;
					} else {
						tfs[i][tfs[i].length] = null;
					}
				}
			}
		}
		
		public function getNumbers():Array {
			var numbers:Array = new Array();
			var numbersTemp:Array = new Array();
			for (var i:int = 0; i < SIZE.x; i++) {
				numbersTemp.push([]);
				for (var j:int = 0; j < INTERVAL; j++) {
					numbersTemp[i][j] = (j + 1) + (INTERVAL * i);
				}
			}
			
			var rand:int;
			for (i = 0; i < SIZE.x; i ++) {
				numbers.push([]);
				for (j = 0; j < SIZE.y; j++) {
					rand = Math.random() * numbersTemp[i].length;
					numbers[i][j] = numbersTemp[i][rand];
					numbersTemp[i].splice(rand, 1);
				}
			}
			return numbers;
		}
		
		private function onClick(e:MouseEvent):void {
			if (e.target is TextField) {
				checkAndMark(TextField(e.target));
			}
		}
		
		private function checkAndMark(tf:TextField):void {
			if (checkNumber(int(tf.text))) {
				Tf(tf.parent).mark.visible = true;
				checkBingo();
			}
		}
		
		public function autoCheck():void {
			for (var i:int = 0; i < SIZE.x; i++) {
				for (var j:int = 0; j < SIZE.y; j++) {
					if (!(i == 2 && j == 2)) {
						checkAndMark(tfs[i][j].tf);
					}
				}
			}
		}
		
		private function checkBingo():void {
			var markeds:int = 0;
			var verticalsMarked:int;
			var horizontalsMarked:int;
			var diagonalLMarked:int = 0;
			var diagonalRMarked:int = 0;
			
			for (var i:int = 0; i < SIZE.x; i++) {
				verticalsMarked = 0;
				horizontalsMarked = 0;
				for (var j:int = 0; j < SIZE.y; j++) {
					if (i == 2 && j == 2) {
						verticalsMarked++;
						horizontalsMarked++;
					} else {
						if (tfs[i][j].mark.visible) {
							verticalsMarked++;
						}
						
						if (tfs[j][i].mark.visible) {
							horizontalsMarked++;
						}
						
						if (tfs[i][j].mark.visible) {
							markeds++;
						}
					}
				}
				
				if (i == 2) {
					diagonalLMarked++;
					diagonalRMarked++;
					markeds++;
				} else {
					if (tfs[i][i].mark.visible) {
						diagonalLMarked++;
					}
					
					if (tfs[i][SIZE.x - i - 1].mark.visible) {
						diagonalRMarked++;
					}
				}
				
				if (Game.checkType == GameType.PARTIAL) {
					if (verticalsMarked == SIZE.y) {//BINGO VERTICAL
						showBingo();
						break;
					}
					
					if (horizontalsMarked == SIZE.x) {//BINGO HORIZONTAL
						showBingo();
						break;
					}
				}
			}
			
			if (Game.checkType == GameType.PARTIAL) {
				if (diagonalLMarked == SIZE.x) {//BINGO DIAGONAL LEFT
					showBingo();
				}
				
				if (diagonalRMarked == SIZE.x) {//BINGO DIAGONAL RIGHT
					showBingo();
				}
			}
			
			if (markeds == Math.pow(SIZE.x, 2)) {//BINGO FULL
				showBingo();
			}
		}
		
		public function showBingo():void {
			bingoPopup = new Bingo();
			bingoPopup.x = width * 0.5;
			bingoPopup.y = (height * 0.5) - 100;
			addChild(bingoPopup);
			
			callbackBingo();
		}
		
		public function events(_type:TypeEvent):void {
			this[_type.name + "EventListener"](MouseEvent.CLICK, onClick);
		}
		
		public function reset():void {
			for (var i:int = numChildren - 1; i > -1; i--) {
				if (getChildAt(i) is Tf) {
					removeChildAt(i);
				}
				
				if (getChildAt(i) is Bingo) {
					removeChildAt(i);
				}
			}
			tfs = [];
		}

	}
	
}