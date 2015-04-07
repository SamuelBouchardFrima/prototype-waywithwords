package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords
{
	public class Asset
	{
		[Embed(source = "../../../../../../art/Sam00.png")]
		public static var Sam00Bitmap:Class;
		[Embed(source = "../../../../../../art/Sam01.png")]
		public static var Sam01Bitmap:Class;
		[Embed(source = "../../../../../../art/Sam02.png")]
		public static var Sam02Bitmap:Class;
		[Embed(source = "../../../../../../art/Sam03.png")]
		public static var Sam03Bitmap:Class;
		[Embed(source = "../../../../../../art/Sam04.png")]
		public static var Sam04Bitmap:Class;
		[Embed(source = "../../../../../../art/Sam05.png")]
		public static var Sam05Bitmap:Class;
		[Embed(source = "../../../../../../art/Sam06.png")]
		public static var Sam06Bitmap:Class;
		
		[Embed(source = "../../../../../../art/MatObject.png")]
		public static var MatObjectBitmap:Class;
		[Embed(source = "../../../../../../art/MatIcon.png")]
		public static var MatIconBitmap:Class;
		
		[Embed(source = "../../../../../../art/FanObject.png")]
		public static var FanObjectBitmap:Class;
		[Embed(source = "../../../../../../art/FanIcon.png")]
		public static var FanIconBitmap:Class;
		
		public function Asset()
		{
			throw new Error("Art is a static class not intended for instantiation.");
		}
	}
}