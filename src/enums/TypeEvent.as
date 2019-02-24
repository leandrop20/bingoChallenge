package enums {
	
	public class TypeEvent {

		public static const ADD:TypeEvent = new TypeEvent("add");
		public static const REMOVE:TypeEvent = new TypeEvent("remove");
		
		public var name:String;
		
		public function TypeEvent(_name:String) {
			name = _name;
		}

	}
	
}
