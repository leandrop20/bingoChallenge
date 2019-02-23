﻿package elements {
	import flash.display.Sprite;
	import enums.TypeEvent;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class Card extends Sprite {
		
		private var checkNumber:Function;
		private var callBingo:Function;
		
		private const SIZE:Point = new Point(5, 5);
		private const POSITION_INIT:Point = new Point(-164, -138);
		private const SPACE:int = 5;
		private const INTERVAL:int = 15;
		
		private var tfs:Array;

		public function Card(_checkNumber:Function, _callBingo) {
			checkNumber = _checkNumber;
			callBingo = _callBingo
			
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
						tfs[i][j] = tf;
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
				if (checkNumber(int(e.target.text))) {
					e.target.parent.mark.visible = true;
					checkBingo();
				}
			}
		}
		
		private function checkBingo():void {
			var verticalsNeed:int;
			var verticalsMarked:int;
			for (var i:int = 0; i < SIZE.x; i++) {
				verticalsNeed = tfs[i].length;
				verticalsMarked = 0;
				
				for (var j:int = 0; j < SIZE.y; j++) {
					if (!(i === 2 && j === 2)) {
						if (tfs[i][j].mark.visible) {
							verticalsMarked++;
						}
					}
				}
				
				if (verticalsNeed === verticalsMarked) {//VERTICAL BINGO
					callBingo();
					trace("BINGO VERTICAL");
					break;
				}
			}
		}
		
		public function events(_type:TypeEvent):void {
			this[_type.name + "EventListener"](MouseEvent.CLICK, onClick);
		}
		
		public function reset():void {
			tfs = [];
			removeChildren();
		}

	}
	
}