package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	
	public interface ISceneManager extends IEventDispatcher
	{
		function get SceneContainer():Sprite;
		
		function ShowScene(aScene:Scene):void;
		function LeaveScene(aScene:Scene):void;
	}
}