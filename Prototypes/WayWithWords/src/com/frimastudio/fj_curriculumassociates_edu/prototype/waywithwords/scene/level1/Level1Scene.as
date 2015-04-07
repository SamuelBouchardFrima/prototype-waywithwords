package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.level1
{
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
	
	public class Level1Scene extends LevelScene
	{
		private var mSam:Sprite;
		private var mMat:Sprite;
		private var mFan:Sprite;
		
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
			mSam.removeEventListener(MouseEvent.CLICK, OnClickSam);
			mMat.removeEventListener(MouseEvent.CLICK, OnClickMat);
			mFan.removeEventListener(MouseEvent.CLICK, OnClickFan);
			
			super.Dispose();
		}
		
		override public function ShowScene():void
		{
			if (!Level1.SamScene)
			{
				return;
			}
			
			while (mSam.numChildren > 0)
			{
				mSam.removeChildAt(0);
			}
			
			mSam.addChild(new Bitmap(Level1.SamScene.MainObject.State.Picture.bitmapData));
			
			super.ShowScene();
		}
		
		private function AddSam():void
		{
			mSam = new Sprite();
			mSam.addChild(new Asset.Sam00Bitmap());
			mSam.x = 150;
			mSam.y = 200;
			mSam.addEventListener(MouseEvent.CLICK, OnClickSam);
			addChild(mSam);
		}
		
		private function AddMat():void
		{
			mMat = new Sprite();
			mMat.addChild(new Asset.MatObjectBitmap());
			mMat.x = 500;
			mMat.y = 300;
			mMat.addEventListener(MouseEvent.CLICK, OnClickMat);
			addChild(mMat);
		}
		
		private function AddFan():void
		{
			mFan = new Sprite();
			mFan.addChild(new Asset.FanObjectBitmap());
			mFan.x = 400;
			mFan.y = 100;
			mFan.addEventListener(MouseEvent.CLICK, OnClickFan);
			addChild(mFan);
		}
		
		private function OnClickSam(aEvent:MouseEvent):void
		{
			SceneManager.Instance.ShowScene(Level1.SamScene);
		}
		
		private function OnClickMat(aEvent:MouseEvent):void
		{
			SceneManager.Instance.ShowScene(Level1.MatScene);
		}
		
		private function OnClickFan(aEvent:MouseEvent):void
		{
			SceneManager.Instance.ShowScene(Level1.FanScene);
		}
		
		private function OnItemAdded(aEvent:InventoryEvent):void
		{
			switch (aEvent.EventItem)
			{
				case Item.MAT:
					mMat.removeEventListener(MouseEvent.CLICK, OnClickMat);
					removeChild(mMat);
					break;
				case Item.FAN:
					mFan.removeEventListener(MouseEvent.CLICK, OnClickFan);
					removeChild(mFan);
					break;
				default:
					break;
			}
		}
	}
}