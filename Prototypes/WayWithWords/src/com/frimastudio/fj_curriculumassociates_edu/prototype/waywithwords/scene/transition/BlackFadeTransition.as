package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.transition
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.Scene;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BlackFadeTransition extends Transition
	{
		private var mBlackFade:Sprite;
		
		public function BlackFadeTransition(aSceneIn:Scene, aSceneOut:Scene, aDuration:Number)
		{
			mBlackFade = new Sprite();
			mBlackFade.graphics.beginFill(0x000000);
			mBlackFade.graphics.moveTo(0, 0);
			mBlackFade.graphics.lineTo(800, 0);
			mBlackFade.graphics.lineTo(800, 600);
			mBlackFade.graphics.lineTo(0, 600);
			mBlackFade.graphics.lineTo(0, 0);
			mBlackFade.graphics.endFill();
			mBlackFade.alpha = 0;
			
			super(aSceneIn, aSceneOut, aDuration);
			
			addChild(mBlackFade);
		}
		
		override protected function OnEnterFrame(aEvent:Event):void
		{
			if (!mChanged)
			{
				mBlackFade.alpha = (ElapsedTime / mDuration) * 2;
				if (mBlackFade.alpha >= 1)
				{
					ChangeScene();
				}
			}
			else
			{
				mBlackFade.alpha = (1 - (ElapsedTime / mDuration)) * 2;
				if (mBlackFade.alpha <= 0)
				{
					Stop();
				}
			}
		}
	}
}