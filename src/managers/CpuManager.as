package managers {
	import flash.display.Sprite;
	import elements.Card;
	
	public class CpuManager extends Sprite {
		
		public static var amountPlayers:int = 3;
		
		private var checkNumber:Function;
		private var callbackBingo:Function;

		public function CpuManager(_checkNumber:Function, _callbackBingo:Function) {
			checkNumber = _checkNumber;
			callbackBingo = _callbackBingo;
		}
		
		public function create():void {
			var card:Card;
			for (var i:int = 0; i < CpuManager.amountPlayers; i++) {
				card = new Card(checkNumber, callbackBingo);
				card.scaleX = card.scaleY = 0.28;
				card.x = (card.width + 20) * i;
				addChild(card);
				
				card.create();
			}
			
			x = (Main.SIZE.x * 0.5) - (width * 0.5) + (card.width * 0.5);
			y = 313;
		}
		
		public function fillCards():void {
			for (var i:int = 0; i < numChildren; i++) {
				Card(getChildAt(i)).create();
			}
		}
		
		public function checkAndMark():void {
			for (var i = 0; i < numChildren; i++) {
				Card(getChildAt(i)).autoCheck();
			}
		}
		
		public function reset():void {
			for (var i = 0; i < numChildren; i++) {
				Card(getChildAt(i)).reset();
			}
		}

	}
	
}
