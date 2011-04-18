package de.pixelate.flixelprimer
{
import org.flixel.*;
import org.flixelPP.FlxSpritePP;

	public class GreenTree extends FlxSpritePP
	{
        [Embed(source="../../../assets/png/tree.png")] private var ImgTree:Class;

        public static var _imageHeight:Number = 148;
        public static var _imageWidth:Number = 118;
		public function GreenTree(x:Number):void
		{
     		super(x,FlxG.height - _imageHeight, ImgTree);
       }
   }
}