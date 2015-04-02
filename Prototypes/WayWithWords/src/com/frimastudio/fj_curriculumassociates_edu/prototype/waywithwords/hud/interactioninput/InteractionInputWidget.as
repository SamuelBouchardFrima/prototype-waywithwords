package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.RetractableWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.WidgetButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.util.Random;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class InteractionInputWidget extends RetractableWidget
	{
		private var mSelectedLetterSlots:Vector.<Point>;
		private var mSelectableLetterSlots:Vector.<Point>;
		private var mSelectableLetterSlotTiles:Vector.<Sprite>;
		private var mSelectedLetterList:Vector.<SelectableLetter>;
		private var mSelectableLetterList:Vector.<SelectableLetter>;
		private var mSubmitButton:WidgetButton;
		private var mEraseButton:WidgetButton;
		private var mCurrentWord:String;
		
		public function InteractionInputWidget(aRetractedAnchor:Point, aDeployedAnchor:Point)
		{
			super(aRetractedAnchor, aDeployedAnchor);
			
			mSelectedLetterSlots = new Vector.<Point>();
			mSelectableLetterSlots = new Vector.<Point>();
			mSelectableLetterSlotTiles = new Vector.<Sprite>();
			mSelectedLetterList = new Vector.<SelectableLetter>();
			mSelectableLetterList = new Vector.<SelectableLetter>();
			mCurrentWord = "";
			
			var buttonRect:Rectangle = new Rectangle( -20, -20, 40, 40);
			
			mSubmitButton = new WidgetButton(">", buttonRect, 0x00CC00);
			mSubmitButton.x = 535;
			mSubmitButton.y = -90;
			mSubmitButton.addEventListener(MouseEvent.CLICK, OnSubmit);
			addChild(mSubmitButton);
			
			mEraseButton = new WidgetButton("X", buttonRect, 0xCC0000);
			mEraseButton.x = 585;
			mEraseButton.y = -90;
			mEraseButton.addEventListener(MouseEvent.CLICK, OnErase);
			addChild(mEraseButton);
		}
		
		public function Dispose():void
		{
			ClearLetterLists();
			
			mSubmitButton.removeEventListener(MouseEvent.CLICK, OnSubmit);
			mEraseButton.removeEventListener(MouseEvent.CLICK, OnErase);
		}
		
		public function SetLetterSelection(aLetterSelection:String):void
		{
			ClearLetterLists();
			
			var slotX:int;
			var tile:Sprite;
			var i:int, end:int;
			for (i = 0, end = aLetterSelection.length; i < end; ++i)
			{
				slotX = (85 * i) + 100;
				
				mSelectedLetterSlots.push(new Point(slotX, -90));
				mSelectableLetterSlots.push(new Point(slotX, 10));
				
				tile = new Sprite();
				tile.x = slotX;
				tile.y = 10;
				
				tile.graphics.lineStyle(0, 0x000000, 0);
				tile.graphics.beginFill(0xCCCCCC);
				tile.graphics.moveTo(-35, -35);
				tile.graphics.lineTo(35, -35);
				tile.graphics.lineTo(35, 35);
				tile.graphics.lineTo(-35, 35);
				tile.graphics.lineTo( -35, -35);
				tile.graphics.endFill();
				
				mSelectableLetterSlotTiles.push(tile);
				addChild(tile);
			}
			
			var remainingLetters:String = aLetterSelection;
			while (remainingLetters.length > 0)
			{
				i = Random.RangeInt(0, remainingLetters.length - 1);
				AddSelectableLetter(remainingLetters.charAt(i));
				remainingLetters = remainingLetters.substring(0, i) + remainingLetters.substr(i + 1);
			}
			
			RefreshCurrentWord();
		}
		
		private function ClearLetterLists():void 
		{
			var i:int, end:int;
			
			for (i = 0, end = mSelectableLetterSlotTiles.length; i < end; ++i)
			{
				removeChild(mSelectableLetterSlotTiles[i]);
			}
			for (i = 0, end = mSelectedLetterList.length; i < end; ++i)
			{
				RemoveSelectedLetter(mSelectedLetterList[i], false);
			}
			for (i = 0, end = mSelectableLetterList.length; i < end; ++i)
			{
				if (mSelectableLetterList[i] != null)
				{
					RemoveSelectableLetter(mSelectableLetterList[i]);
				}
			}
			
			mSelectedLetterSlots.splice(0, mSelectedLetterSlots.length);
			mSelectableLetterSlots.splice(0, mSelectableLetterSlots.length);
			mSelectableLetterSlotTiles.splice(0, mSelectableLetterSlotTiles.length);
			mSelectedLetterList.splice(0, mSelectedLetterList.length);
			mSelectableLetterList.splice(0, mSelectableLetterList.length);
		}
		
		private function AddSelectedLetter(aCharacter:String):void
		{
			var selectedLetter:SelectableLetter = new SelectableLetter(aCharacter);
			selectedLetter.x = (selectedLetter.width + 5) * mSelectedLetterList.length + 100;
			selectedLetter.y = -90;
			selectedLetter.addEventListener(SelectableLetterEvent.SELECTED, OnLetterUnselected);
			mSelectedLetterList.push(selectedLetter);
			addChild(selectedLetter);
		}
		
		private function AddSelectableLetter(aCharacter:String):void
		{
			var selectableLetter:SelectableLetter = new SelectableLetter(aCharacter);
			
			var emptySlot:Boolean;
			for (var i:int = 0, end:int = mSelectableLetterList.length; i < end && !emptySlot; ++i)
			{
				if (mSelectableLetterList[i] == null)
				{
					mSelectableLetterList[i] = selectableLetter;
					emptySlot = true;
				}
			}
			if (!emptySlot)
			{
				mSelectableLetterList.push(selectableLetter);
			}
			
			var slot:int = mSelectableLetterList.indexOf(selectableLetter);
			selectableLetter.x = ((selectableLetter.width + 5) * slot) + 100;
			selectableLetter.y = 10;
			selectableLetter.addEventListener(SelectableLetterEvent.SELECTED, OnLetterSelected);
			addChild(selectableLetter);
		}
		
		private function RemoveSelectedLetter(aLetter:SelectableLetter, aAdjustList:Boolean = true):void
		{
			aLetter.removeEventListener(SelectableLetterEvent.SELECTED, OnLetterUnselected);
			removeChild(aLetter);
			
			if (!aAdjustList)
			{
				return;
			}
			
			var i:int = mSelectedLetterList.indexOf(aLetter);
			mSelectedLetterList.splice(i, 1);
			for (var end:int = mSelectedLetterList.length; i < end; ++i)
			{
				mSelectedLetterList[i].x -= mSelectedLetterList[i].width + 5;
			}
		}
		
		private function RemoveSelectableLetter(aLetter:SelectableLetter):void
		{
			aLetter.removeEventListener(SelectableLetterEvent.SELECTED, OnLetterSelected);
			removeChild(aLetter);
			mSelectableLetterList[mSelectableLetterList.indexOf(aLetter)] = null;
		}
		
		private function RefreshCurrentWord():void
		{
			mCurrentWord = "";
			for (var i:int = 0, end:int = mSelectedLetterList.length; i < end; ++i)
			{
				mCurrentWord += mSelectedLetterList[i].Character;
			}
		}
		
		private function OnSubmit(aEvent:MouseEvent):void
		{
			dispatchEvent(new InteractionInputEvent(InteractionInputEvent.SUBMIT, mCurrentWord));
		}
		
		private function OnErase(aEvent:MouseEvent):void
		{
			for (var i:int = 0, end:int = mSelectedLetterList.length; i < end; ++i)
			{
				AddSelectableLetter(mSelectedLetterList[i].Character);
				RemoveSelectedLetter(mSelectedLetterList[i], false);
			}
			mSelectedLetterList.splice(0, mSelectedLetterList.length);
			RefreshCurrentWord();
		}
		
		private function OnLetterSelected(aEvent:SelectableLetterEvent):void
		{
			var selectableLetter:SelectableLetter = aEvent.currentTarget as SelectableLetter;
			var character:String = selectableLetter.Character;
			RemoveSelectableLetter(selectableLetter);
			AddSelectedLetter(character);
			RefreshCurrentWord();
		}
		
		private function OnLetterUnselected(aEvent:SelectableLetterEvent):void
		{
			var selectedLetter:SelectableLetter = aEvent.currentTarget as SelectableLetter;
			var character:String = selectedLetter.Character;
			RemoveSelectedLetter(selectedLetter);
			AddSelectableLetter(character);
			RefreshCurrentWord();
		}
	}
}