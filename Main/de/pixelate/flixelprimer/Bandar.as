package de.pixelate.flixelprimer
{
import org.flixel.*;
import org.flixelPP.FlxSpritePP;

public class Bandar extends FlxSpritePP
{
    [Embed(source="../../../assets/png/monkey.png")] private var ImgShip:Class;

    public static var _x_speed:Number = 200;
    public static var _y_speed:Number = 400;
    public static var _gravity:Number = 400;
    public var _angular_speed:Number =  180 * _gravity / _y_speed;
    public var _ground_friction:Number = 100;
    public static var _imageHeight:Number = 52;
    public static var _imageWidth:Number = 55;


    public function Bandar(x:Number, y:Number):void
    {
        super(x, y, ImgShip);
    }

    override public function update():void
    {
        if (velocity.y != 0)
        {

            if(FlxG.keys.LEFT)
            {
                velocity.x-=5;
            }
            else if(FlxG.keys.RIGHT)
            {
                velocity.x+=5;
            }
        }
        else if (velocity.x > 0 && acceleration.x > 0)
        {
            // Stop the object
            velocity.x=0;
            acceleration.x=0;
        }
        else if(velocity.x < 0 && acceleration.x < 0)
        {
            // Stop the object
            velocity.x=0;
            acceleration.x=0;
        }
        else
        {
            if(FlxG.keys.LEFT)
            {
                velocity.x=-_x_speed;
                // on ground add friction
                acceleration.x = _ground_friction;
            }
            else if(FlxG.keys.RIGHT)
            {
                velocity.x=_x_speed;
                //  on ground add friction
                acceleration.x = -_ground_friction;
            }
            if(FlxG.keys.UP)
            {
                velocity.y=-_y_speed;
                acceleration.y = _gravity;
                acceleration.x = 0;
                if (velocity.x <0)
                    angularVelocity = -_angular_speed;
                else
                    angularVelocity = _angular_speed;
            }
        }

        if(x > FlxG.width-width-16)
        {
            // Wall rebound
            x= FlxG.width-width-16;
            velocity.x = -_x_speed
            velocity.y = -_y_speed;
            acceleration.y = _gravity;
        }
        else if(x < 16)
        {
            //Wall rebound
            x = 16;
            velocity.x = _x_speed;
            velocity.y = -_y_speed;
            acceleration.y = _gravity;
        }
        else if(y < 0)
        {
            //Wall rebound
            y = 0;
            velocity.y = 0;
            acceleration.y = _gravity;
        }
        else if (y >FlxG.height - Bandar._imageHeight)
        {
            FlxG.score+=Globals.scoreUnit/10*Globals.comboCount*Globals.comboCount;
            Globals.comboCount=0;
            Globals.comboCount=0;
            // Monkey should  come to rest on floor
            acceleration.y=0;
            velocity.x=0;
            velocity.y=0;
            acceleration.x=0;
            angle=0;
            angularVelocity=0;
            y=FlxG.height - Bandar._imageHeight;
        }

        super.update();
    }

}
}