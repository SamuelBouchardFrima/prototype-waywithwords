package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class WidgetButton extends Sprite
	{
		private var mRect:Rectangle;
		
		public function set ButtonColor(aValue:int):void
		{
			graphics.beginFill(aValue);
			graphics.lineStyle(2);
			graphics.drawRect(mRect.x, mRect.y, mRect.width, mRect.height);
			graphics.endFill();
		}
		
		public function WidgetButton(aLabel:String, aRect:Rectangle, aColor:int = 0xFFFFFF)
		{
			super();
			
			mRect = aRect;
			
			ButtonColor = aColor;
			
			var format:TextFormat = new TextFormat();
			format.size = aRect.height * 0.75;
			format.bold = true;
			format.align = "center";
			
			var field:TextField = new TextField();
			field.width = aRect.width;
			field.height = aRect.height;
			field.x = aRect.x;
			field.y = aRect.y;
			field.text = aLabel;
			field.setTextFormat(format);
			field.selectable = false;
			addChild(field);
		}
	}
}