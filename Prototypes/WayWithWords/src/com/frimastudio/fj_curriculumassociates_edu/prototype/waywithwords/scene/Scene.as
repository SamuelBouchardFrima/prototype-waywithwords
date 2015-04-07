package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.Composition;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.HUD;
	import flash.display.Sprite;
	
	public class Scene extends Sprite
	{
		protected var mHudComposition:Composition
		
		public function Scene()
		{
			super();
		}
		
		public function Dispose():void
		{
		}
		
		public function ShowScene():void
		{
			HUD.Instance.ChangeComposition(mHudComposition);
			SceneManager.Instance.SceneContainer.addChild(this);
		}
		
		public function HideScene():void
		{
			if (SceneManager.Instance.SceneContainer.contains(this))
			{
				SceneManager.Instance.SceneContainer.removeChild(this);
			}
		}
		
		public function LeaveScene():void
		{
			HideScene()
		}
	}
}