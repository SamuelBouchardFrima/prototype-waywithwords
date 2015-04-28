package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.level1
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.animation.Shaker;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.InventoryEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Item;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.LevelScene;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.SceneManager;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class Level1Scene extends LevelScene
	{
		private var mSam:Sprite;
		private var mSamMouseOver:Sprite;
		private var mSamQuestIcon:Sprite;
		private var mSamWiggleTimer:Timer;
		
		private var mMat:Sprite;
		private var mMatMouseOver:Sprite;
		private var mMatGrabIcon:Sprite;
		
		private var mFan:Sprite;
		private var mFanMouseOver:Sprite;
		private var mFanGrabIcon:Sprite;
		
		public function Level1Scene()
		{
			super();
			
			AddSam();
			AddMat();
			AddFan();
			
			Inventory.Instance.addEventListener(InventoryEvent.ITEM_ADDED, OnItemAdded);
		}
		
		override public function Dispose():void
		{
			mSamWiggleTimer.stop();
			mSamWiggleTimer.removeEventListener(TimerEvent.TIMER, OnSamWiggleTimer);
			
			mSam.removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOverSam);
			mSam.removeEventListener(MouseEvent.MOUSE_OUT, OnMouseOutSam);
			mSam.removeEventListener(MouseEvent.CLICK, OnClickSam);
			
			mMat.removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOverMat);
			mMat.removeEventListener(MouseEvent.MOUSE_OUT, OnMouseOutMat);
			mMat.removeEventListener(MouseEvent.CLICK, OnClickMat);
			
			mFan.removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOverFan);
			mFan.removeEventListener(MouseEvent.MOUSE_OUT, OnMouseOutFan);
			mFan.removeEventListener(MouseEvent.CLICK, OnClickFan);
			
			super.Dispose();
		}
		
		override public function ShowScene():void
		{
			if (!Level1.Instance.SamScene)
			{
				return;
			}
			
			while (mSam.numChildren > 0)
			{
				mSam.removeChildAt(0);
			}
			
			mSam.addChild(new Bitmap(Level1.Instance.SamScene.MainObject.State.Picture.bitmapData));
			
			super.ShowScene();
		}
		
		private function AddSam():void
		{
			mSam = new Sprite();
			mSam.addChild(new Asset.Sam00Bitmap());
			mSam.x = 150;
			mSam.y = 200;
			mSam.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOverSam);
			mSam.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOutSam);
			mSam.addEventListener(MouseEvent.CLICK, OnClickSam);
			addChild(mSam);
			
			mSamMouseOver = new Sprite();
			mSamMouseOver.addChild(new Asset.SpeechBubbleIconBitmap());
			mSamMouseOver.scaleX = mSamMouseOver.scaleY = 0.3;
			mSamMouseOver.x = mSam.x + (mSam.width * 0.8);
			mSamMouseOver.y = mSam.y - (mSam.height * 0.2);
			
			mSamQuestIcon = new Sprite();
			mSamQuestIcon.addChild(new Asset.QuestIconBitmap());
			mSamQuestIcon.scaleX = mSamQuestIcon.scaleY = 0.3;
			mSamQuestIcon.x = mSam.x + (mSam.width * 0.9);
			mSamQuestIcon.y = mSam.y - (mSam.height * 0.1);
			addChild(mSamQuestIcon);
			
			mSamWiggleTimer = new Timer(5000);
			mSamWiggleTimer.addEventListener(TimerEvent.TIMER, OnSamWiggleTimer);
			mSamWiggleTimer.start();
		}
		
		private function OnSamWiggleTimer(aEvent:TimerEvent):void
		{
			new Shaker(mSam, 800, new Point(2, 0));
		}
		
		private function AddMat():void
		{
			mMat = new Sprite();
			mMat.addChild(new Asset.MatObjectBitmap());
			mMat.x = 500;
			mMat.y = 300;
			mMat.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOverMat);
			mMat.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOutMat);
			mMat.addEventListener(MouseEvent.CLICK, OnClickMat);
			addChild(mMat);
			
			var backpack:Bitmap = new Asset.InventoryIconBitmap();
			backpack.scaleX = backpack.scaleY = 0.6;
			backpack.x = 75;
			var arrow:Bitmap = new Asset.ArrowIconBitmap();
			arrow.x = -30;
			mMatMouseOver = new Sprite();
			mMatMouseOver.addChild(backpack);
			mMatMouseOver.addChild(arrow);
			mMatMouseOver.scaleX = mMatMouseOver.scaleY = 0.3;
			mMatMouseOver.x = mMat.x + (mMat.width * 0.8);
			mMatMouseOver.y = mMat.y - (mMat.height * -0.2);
			
			mMatGrabIcon = new Sprite();
			mMatGrabIcon.addChild(new Asset.GrabIconBitmap());
			mMatGrabIcon.scaleX = mMatGrabIcon.scaleY = 0.3;
			mMatGrabIcon.x = mMat.x + (mMat.width * 0.8);
			mMatGrabIcon.y = mMat.y - (mMat.height * -0.2);
			addChild(mMatGrabIcon);
		}
		
		private function AddFan():void
		{
			mFan = new Sprite();
			mFan.addChild(new Asset.FanObjectBitmap());
			mFan.x = 400;
			mFan.y = 100;
			mFan.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOverFan);
			mFan.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOutFan);
			mFan.addEventListener(MouseEvent.CLICK, OnClickFan);
			addChild(mFan);
			
			var backpack:Bitmap = new Asset.InventoryIconBitmap();
			backpack.scaleX = backpack.scaleY = 0.6;
			backpack.x = 75;
			var arrow:Bitmap = new Asset.ArrowIconBitmap();
			arrow.x = -30;
			mFanMouseOver = new Sprite();
			mFanMouseOver.addChild(backpack);
			mFanMouseOver.addChild(arrow);
			mFanMouseOver.scaleX = mFanMouseOver.scaleY = 0.3;
			mFanMouseOver.x = mFan.x + (mFan.width * 0.9);
			mFanMouseOver.y = mFan.y - (mFan.height * -0.1);
			
			mFanGrabIcon = new Sprite();
			mFanGrabIcon.addChild(new Asset.GrabIconBitmap());
			mFanGrabIcon.scaleX = mFanGrabIcon.scaleY = 0.3;
			mFanGrabIcon.x = mFan.x + (mFan.width * 0.9);
			mFanGrabIcon.y = mFan.y - (mFan.height * -0.1);
			addChild(mFanGrabIcon);
		}
		
		private function OnMouseOverSam(aEvent:MouseEvent):void
		{
			addChild(mSamMouseOver);
			if (contains(mSamQuestIcon))
			{
				removeChild(mSamQuestIcon);
			}
		}
		
		private function OnMouseOutSam(aEvent:MouseEvent):void
		{
			if (contains(mSamMouseOver))
			{
				removeChild(mSamMouseOver);
			}
			addChild(mSamQuestIcon);
		}
		
		private function OnClickSam(aEvent:MouseEvent):void
		{
			SceneManager.Instance.ShowScene(Level1.Instance.SamScene);
		}
		
		private function OnMouseOverMat(aEvent:MouseEvent):void
		{
			addChild(mMatMouseOver);
			if (contains(mMatGrabIcon))
			{
				removeChild(mMatGrabIcon);
			}
		}
		
		private function OnMouseOutMat(aEvent:MouseEvent):void
		{
			if (contains(mMatMouseOver))
			{
				removeChild(mMatMouseOver);
			}
			addChild(mMatGrabIcon);
		}
		
		private function OnClickMat(aEvent:MouseEvent):void
		{
			SceneManager.Instance.ShowScene(Level1.Instance.MatScene);
		}
		
		private function OnMouseOverFan(aEvent:MouseEvent):void
		{
			addChild(mFanMouseOver);
			if (contains(mFanGrabIcon))
			{
				removeChild(mFanGrabIcon);
			}
		}
		
		private function OnMouseOutFan(aEvent:MouseEvent):void
		{
			if (contains(mFanMouseOver))
			{
				removeChild(mFanMouseOver);
			}
			addChild(mFanGrabIcon);
		}
		
		private function OnClickFan(aEvent:MouseEvent):void
		{
			SceneManager.Instance.ShowScene(Level1.Instance.FanScene);
		}
		
		private function OnItemAdded(aEvent:InventoryEvent):void
		{
			switch (aEvent.EventItem)
			{
				case Item.MAT:
					mMat.removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOverMat);
					mMat.removeEventListener(MouseEvent.MOUSE_OUT, OnMouseOutMat);
					mMat.removeEventListener(MouseEvent.CLICK, OnClickMat);
					if (contains(mMat))
					{
						removeChild(mMat);
					}
					if (contains(mMatMouseOver))
					{
						removeChild(mMatMouseOver);
					}
					if (contains(mMatGrabIcon))
					{
						removeChild(mMatGrabIcon);
					}
					break;
				case Item.FAN:
					mFan.removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOverFan);
					mFan.removeEventListener(MouseEvent.MOUSE_OUT, OnMouseOutFan);
					mFan.removeEventListener(MouseEvent.CLICK, OnClickFan);
					if (contains(mFan))
					{
						removeChild(mFan);
					}
					if (contains(mFanMouseOver))
					{
						removeChild(mFanMouseOver);
					}
					if (contains(mFanGrabIcon))
					{
						removeChild(mFanGrabIcon);
					}
					break;
				default:
					break;
			}
		}
	}
}