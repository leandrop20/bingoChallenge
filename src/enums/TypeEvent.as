package enums {
	
	public class TypeEvent {

		public static var ADD:TypeEvent = new TypeEvent("add");
		public static var REMOVE:TypeEvent = new TypeEvent("remove");
		
		public var name:String;
		
		public function TypeEvent(_name:String) {
			name = _name;
		}

	}
	
}
