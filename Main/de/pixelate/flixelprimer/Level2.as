package de.pixelate.flixelprimer
{
import org.flixelPP.*

import org.flixel.*;

public class Level2 extends Level1
{
    override protected  function spawnPlane():void
    {
        var y_cord:Number = Math.random()  * (FlxG.height /2) + 50;
        var plane:Plane = new Plane(0,y_cord);
        if (Math.random() < 2/5)
            plane.velocity.x=300;
        else
            plane.velocity.x=200
        planes.add(plane);
    }

   override protected function checkIfSwitchToNextLevel():void
    {
    }


    }
}