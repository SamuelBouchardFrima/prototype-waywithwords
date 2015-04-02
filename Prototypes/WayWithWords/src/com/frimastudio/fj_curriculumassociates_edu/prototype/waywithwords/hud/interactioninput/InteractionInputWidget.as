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
		private var mSelectedLetterList:Vector.<SelectableLetter>;
		private var mSelectableLetterList:Vector.<SelectableLetter>;
		private var mRewindButton:WidgetButton;
		private var mSubmitButton:WidgetButton;
		private var mEraseButton:WidgetButton;
		private var mCurrentWord:String;
		
		public function InteractionInputWidget(aRetractedAnchor:Point, aDeployedAnchor:Point, aLetterSelection:String = "")
		{
			super(aRetractedAnchor, aDeployedAnchor);
			
			mSelectedLetterList = new Vector.<SelectableLetter>();
			mSelectableLetterList = new Vector.<SelectableLetter>();
			SetLetterSelection(aLetterSelection);
			
			var buttonRect:Rectangle = new Rectangle( -20, -20, 40, 40);
			
			mRewindButton = new WidgetButton("<", buttonRect, 0xCCCC00);
			mRewindButton.x = 15;
			mRewindButton.y = -90;
			mRewindButton.addEventListener(MouseEvent.CLICK, OnRewind);
			addChild(mRewindButton);
			
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
			
			var remainingLetters:String = aLetterSelection;
			var i:int;
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
			
			for (i = 0, end = mSelectedLetterList.length; i < end; ++i)
			{
				RemoveSelectedLetter(mSelectedLetterList[i], false);
			}
			for (i = 0, end = mSelectableLetterList.length; i < end; ++i)
			{
				RemoveSelectableLetter(mSelectableLetterList[i], false);
			}
			
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
			selectableLetter.x = (selectableLetter.width + 5) * mSelectableLetterList.length + 100;
			selectableLetter.y = 10;
			selectableLetter.addEventListener(SelectableLetterEvent.SELECTED, OnLetterSelected);
			mSelectableLetterList.push(selectableLetter);
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
		
		private function RemoveSelectableLetter(aLetter:SelectableLetter, aAdjustList:Boolean = true):void
		{
			aLetter.removeEventListener(SelectableLetterEvent.SELECTED, OnLetterSelected);
			removeChild(aLetter);
			
			if (!aAdjustList)
			{
				return;
			}
			
			var i:int = mSelectableLetterList.indexOf(aLetter);
			mSelectableLetterList.splice(i, 1);
			for (var end:int = mSelectableLetterList.length; i < end; ++i)
			{
				mSelectableLetterList[i].x -= mSelectableLetterList[i].width + 5;
			}
		}
		
		private function RefreshCurrentWord():void
		{
			mCurrentWord = "";
			for (var i:int = 0, end:int = mSelectedLetterList.length; i < end; ++i)
			{
				mCurrentWord += mSelectedLetterList[i].Character;
			}
		}
		
		private function OnRewind(aEvent:MouseEvent):void
		{
			dispatchEvent(new InteractionInputEvent(InteractionInputEvent.REWIND));
		}
		
		private function OnSubmit(aEvent:MouseEvent):void
		{
			var event:InteractionInputEvent = new InteractionInputEvent(InteractionInputEvent.SUBMIT);
			event.Input = mCurrentWord;
			dispatchEvent(event);
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
			AddSelectedLetter(selectableLetter.Character);
			RemoveSelectableLetter(selectableLetter);
			
			RefreshCurrentWord();
		}
		
		private function OnLetterUnselected(aEvent:SelectableLetterEvent):void
		{
			var selectedLetter:SelectableLetter = aEvent.currentTarget as SelectableLetter;
			AddSelectableLetter(selectedLetter.Character);
			RemoveSelectedLetter(selectedLetter);
			
			RefreshCurrentWord();
		}
	}
}