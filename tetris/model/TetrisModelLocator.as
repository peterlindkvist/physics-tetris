package tetris.model
{
	public class TetrisModelLocator
	{
		private static var instance:TetrisModelLocator;
		public var physic:PhysicModel;
		public var settings:SettingsModel;
		
		public static function getInstance():TetrisModelLocator
		{
			if(instance == null) instance = new TetrisModelLocator();
			return instance;
		}
		
		public function TetrisModelLocator()
		{
			settings = new SettingsModel();
		}
	}
}