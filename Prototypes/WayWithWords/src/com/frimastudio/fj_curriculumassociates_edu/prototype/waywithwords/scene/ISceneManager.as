package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.transition.Transition;
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	
	public interface ISceneManager extends IEventDispatcher
	{
		function get SceneContainer():Sprite;
		function get TransitionContainer():Sprite;
		function get CurrentScene():Scene;
		
		function ShowTransition(aTransition:Transition):void;
		function ShowScene(aScene:Scene):void;
		function LeaveScene(aScene:Scene):void;
	}
}