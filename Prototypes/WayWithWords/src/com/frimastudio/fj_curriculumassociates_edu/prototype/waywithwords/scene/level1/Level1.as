package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.level1
{
	public class Level1
	{
		public static var LevelScene:Level1Scene = new Level1Scene();
		public static var SamScene:SamInteractiveObjectScene = new SamInteractiveObjectScene();
		public static var MatScene:MatInteractiveObjectScene = new MatInteractiveObjectScene();
		public static var FanScene:FanInteractiveObjectScene = new FanInteractiveObjectScene();
		
		public function Level1()
		{
			throw new Error("Level1 is a static class not intended for instantiation.");
		}
	}
}