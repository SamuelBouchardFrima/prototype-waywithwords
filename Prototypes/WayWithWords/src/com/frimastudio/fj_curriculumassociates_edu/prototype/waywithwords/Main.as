package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.Composition;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.HUD;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput.InteractionInputEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.inventory.InventoryWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.navigation.NavigationEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.navigation.NavigationWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.Widget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput.InteractionInputWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectState;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.level1.Level1;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.level1.SamInteractiveObject;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.SceneManager;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Main extends Sprite
	{
		public function Main():void
		{
			stage != null ? Init() : addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(aEvent:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			// entry point
			
			addChild(SceneManager.Instance.SceneContainer);
			addChild(HUD.Instance as DisplayObject);
			
			SceneManager.Instance.ShowScene(Level1.LevelScene);
		}
		
		private function Dispose():void
		{
		}
	}
}