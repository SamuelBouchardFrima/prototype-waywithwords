package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class SceneManager extends EventDispatcher implements ISceneManager
	{
		private static var sInstance:SceneManager = new SceneManager();
		
		public static function get Instance():ISceneManager
		{
			return sInstance;
		}
		
		private var mSceneContainer:Sprite;
		private var mSceneStack:Vector.<Scene>;
		
		public function get SceneContainer():Sprite
		{
			return mSceneContainer;
		}
		
		public function SceneManager(target:IEventDispatcher = null)
		{
			super(target);
			
			mSceneContainer = new Sprite();
			mSceneStack = new Vector.<Scene>();
		}
		
		public function ShowScene(aScene:Scene):void
		{
			if (mSceneStack.length >= 1)
			{
				mSceneStack[mSceneStack.length - 1].HideScene();
			}
			
			var index:int = mSceneStack.indexOf(aScene);
			if (index == -1)
			{
				mSceneStack.push(aScene);
			}
			else
			{
				for (var i:int = mSceneStack.length - 1; i > index; --i)
				{
					mSceneStack.pop().LeaveScene();
				}
			}
			aScene.ShowScene();
		}
		
		public function LeaveScene(aScene:Scene):void
		{
			for (var i:int = mSceneStack.length - 1, end:int = mSceneStack.indexOf(aScene); i >= end; --i)
			{
				mSceneStack.pop().LeaveScene();
			}
			if (mSceneStack.length > 0)
			{
				mSceneStack[mSceneStack.length - 1].ShowScene();
			}
		}
	}
}