package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.transition.Transition;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.transition.TransitionEvent;
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
		private var mTransitionContainer:Sprite;
		private var mSceneStack:Vector.<Scene>;
		
		public function get SceneContainer():Sprite
		{
			return mSceneContainer;
		}
		
		public function get TransitionContainer():Sprite
		{
			return mTransitionContainer;
		}
		
		public function get CurrentScene():Scene
		{
			if (mSceneStack.length <= 0)
			{
				return null;
			}
			
			return mSceneStack[mSceneStack.length - 1];
		}
		
		public function SceneManager(target:IEventDispatcher = null)
		{
			super(target);
			
			mSceneContainer = new Sprite();
			mTransitionContainer = new Sprite();
			mSceneStack = new Vector.<Scene>();
		}
		
		public function ShowTransition(aTransition:Transition):void
		{
			aTransition.addEventListener(TransitionEvent.SCENE_CHANGE, OnTransitionSceneChange);
			aTransition.addEventListener(TransitionEvent.TRANSITION_END, OnTransitionEnd);
			mTransitionContainer.addChild(aTransition);
			
			aTransition.Play();
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
		
		private function OnTransitionSceneChange(aEvent:TransitionEvent):void
		{
			if (!aEvent.SceneOut)
			{
				LeaveScene(mSceneStack[mSceneStack.length - 1]);
			}
			else if (mSceneStack.indexOf(aEvent.SceneOut) != -1)
			{
				LeaveScene(mSceneStack[mSceneStack.indexOf(aEvent.SceneOut) + 1]);
			}
			else
			{
				ShowScene(aEvent.SceneOut);
			}
		}
		
		private function OnTransitionEnd(aEvent:TransitionEvent):void
		{
			var transition:Transition = aEvent.currentTarget as Transition;
			transition.removeEventListener(TransitionEvent.SCENE_CHANGE, OnTransitionSceneChange);
			transition.removeEventListener(TransitionEvent.TRANSITION_END, OnTransitionEnd);
			
			mTransitionContainer.removeChild(transition);
		}
	}
}