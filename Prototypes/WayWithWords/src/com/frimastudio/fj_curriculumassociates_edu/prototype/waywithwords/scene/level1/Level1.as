package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.level1
{
	public class Level1
	{
		private static var sInstance:Level1 = new Level1();
		
		public static function get Instance():Level1
		{
			return sInstance;
		}
		
		private var mLevelScene:Level1Scene;
		private var mSamScene:SamInteractiveObjectScene;
		private var mMatScene:MatInteractiveObjectScene;
		private var mFanScene:FanInteractiveObjectScene;
		
		public function get LevelScene():Level1Scene
		{
			return mLevelScene;
		}
		
		public function get SamScene():SamInteractiveObjectScene
		{
			return mSamScene;
		}
		
		public function get MatScene():MatInteractiveObjectScene
		{
			return mMatScene;
		}
		
		public function get FanScene():FanInteractiveObjectScene
		{
			return mFanScene;
		}
		
		public function Level1()
		{
			mLevelScene = new Level1Scene();
			mSamScene = new SamInteractiveObjectScene();
			mMatScene = new MatInteractiveObjectScene();
			mFanScene = new FanInteractiveObjectScene();
		}
		
		public function Reset():void
		{
			mLevelScene.Dispose();
			mSamScene.Dispose();
			mMatScene.Dispose();
			mFanScene.Dispose();
			
			mLevelScene = new Level1Scene();
			mSamScene = new SamInteractiveObjectScene();
			mMatScene = new MatInteractiveObjectScene();
			mFanScene = new FanInteractiveObjectScene();
		}
	}
}