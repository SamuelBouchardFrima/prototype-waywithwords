package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class WidgetButton extends Sprite
	{
		public function WidgetButton(aLabel:String, aRect:Rectangle, aColor:int = 0xFFFFFF)
		{
			super();
			
			graphics.beginFill(aColor);
			graphics.lineStyle(2);
			graphics.drawRect(aRect.x, aRect.y, aRect.width, aRect.height);
			graphics.endFill();
			
			var format:TextFormat = new TextFormat();
			format.size = aRect.height;
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