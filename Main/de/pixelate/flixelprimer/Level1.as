package de.pixelate.flixelprimer
{
import org.flixel.data.FlxKeyboard;
import org.flixelPP.*

import org.flixel.*;

public class Level1 extends FlxState
{
    [Embed(source="../../../assets/mp3/ExplosionShip.mp3")] private var SoundExplosionShip:Class;
    [Embed(source="../../../assets/mp3/ExplosionAlien.mp3")] private var SoundExplosionAlien:Class;
    [Embed(source="../../../assets/mp3/Bullet.mp3")] private var SoundBullet:Class;
    [Embed(source="../../../assets/png/bar.png")] private var ImgBar:Class;



    public static var _trees:FlxGroup;
    public var bandar:Bandar;
    public static var _textBox:FlxText;
    public var comboText:FlxText;
    public var planes:FlxGroup;
    public var spawnTimer:Number = 2;
    public var birdBombs:FlxGroup;
    public static var scoreUnit:Number=100;
    public static var comboCount:Number=0;
    public static var progressBar:FlxSprite;
    public static var progressBarWidth:Number=78;
    public static var totalNumberofLives:Number=5;
    public static var currentNumberofLives:Number=5;


    override public function create():void
    {
        FlxG.score = 0;
        bgColor = 0x000000;


        _trees = new FlxGroup();
        var  _tree:GreenTree = new GreenTree(FlxG.width/3 - GreenTree._imageWidth/2);
        _trees.add(_tree);
        _tree = new GreenTree(FlxG.width * 2/3 - GreenTree._imageWidth/2);
        _trees.add(_tree);
        add(_trees);


        bandar = new Bandar(GreenTree._imageWidth - Bandar._imageWidth/2,
                FlxG.height - Bandar._imageHeight);
        add(bandar);

        progressBar = new FlxSprite(0, 10, ImgBar);
        add(progressBar);


        planes = new FlxGroup();
        add(planes);

        _textBox = new FlxText(FlxG.width - 150,0, 300, "");
        _textBox.text  = "Score " + FlxG.score;
        _textBox.size = 20;

        comboText = new FlxText(FlxG.width-100, 20,200, "");
        comboText.size = 20;
        comboText.color = 255;

        comboText.alpha = 0.05;
        add(comboText);

        add(_textBox)
        super.create();


    }

    override public function update():void
    {
        var treeOverlap:Boolean = false;
        // Bandar should stay on tree
        for each(var tree:FlxObject in (_trees as FlxGroup).members)
            if(FlxUPP.overlapPP(bandar,_trees))
            {
                overlapBandarTrees(bandar,tree as GreenTree);
                treeOverlap = true;
                break;
            }
        if (!treeOverlap)
        {
            if (bandar.y < FlxG.height - Bandar._imageHeight)
                bandar.acceleration.y = Bandar._gravity;
        }

        FlxU.overlap(bandar,planes, overlapPlaneBandar);
        fadeOutComboText();

        if (!currentNumberofLives)
        {
            destroy();
            FlxG.state = new GameOver();
        }


        spawnTimer-=FlxG.elapsed;
        if(spawnTimer < 0)
        {
            spawnPlane();
            spawnTimer= 2;
        }
        super.update();
    }

    private function overlapBandarTrees(bandar: Bandar, tree:GreenTree):void
    {
        // We need to bring the bandar to rest
        bandar.velocity.x=0;
        bandar.velocity.y=0;
        bandar.acceleration.x=0;
        bandar.acceleration.y=0;
        bandar.angle=0;
        bandar.angularVelocity=0;
        FlxG.score+=scoreUnit/2*comboCount;
        comboCount=0;
        updateScore();
    }




    private function overlapPlaneBandar(bandar: FlxSprite, plane:FlxSprite):void
    {
        // Bounce the bandar
        if (FlxG.keys.LEFT)
            bandar.velocity.x=-Bandar._x_speed;
        else if (FlxG.keys.RIGHT)
            bandar.velocity.x = Bandar ._x_speed;
        bandar.velocity.y=-Bandar._y_speed;
        plane.kill();
        FlxG.score+=scoreUnit;
        updateScore();


        ++comboCount;

        comboText.text = comboCount + "x";
        comboText.x = bandar.x
        comboText.y = bandar.y + 10;
        comboText.alpha = 1;


        var emitter1:FlxEmitter = createEmitter();
        emitter1.at(plane);
    }


    public static function updateScore(): void
    {
        _textBox.text  = "Score " + FlxG.score;
    }
    public function fadeOutComboText():void
    {
        if(comboText.alpha > 0.1)
        {
            comboText.alpha*=0.95;
        }
        else
            comboText.alpha = 0;
    }

    private function createEmitter():FlxEmitter
    {
        var emitter:FlxEmitter = new FlxEmitter();
        emitter.delay = 1;
        emitter.gravity = 0;
        emitter.maxRotation = 0;
        emitter.setXSpeed(-500, 500);
        emitter.setYSpeed(-500, 500);
        var particles: int = 20;
        for(var i: int = 0; i < particles; i++)
        {
            var particle:FlxSprite = new FlxSprite();
            particle.createGraphic(4, 4, 0xFFcccccc);
            particle.exists = false;
            emitter.add(particle);
        }
        emitter.start();
        add(emitter);
        return emitter;
    }

    private function spawnPlane():void
    {
        var y_cord:Number = Math.random()  * (FlxG.height /2) + 50;
        var plane:Plane = new Plane(0,y_cord);
        if (Math.random() < 1/5)
            plane.velocity.x=300;
        else
            plane.velocity.x=100
        planes.add(plane);
    }

}
}