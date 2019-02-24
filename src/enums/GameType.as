package enums {
	
	public class GameType {
		
		public static const PARTIAL:GameType = new GameType("partial");
		public static const FULL:GameType = new GameType("full");

		public var name:String;
		
		public function GameType(_name:String) {
			name = _name;
		}

	}
	
}
