package de.pixelate.flixelprimer
{
import org.flixelPP.*

import org.flixel.*;

	public class PlayState extends FlxState
	{		
		[Embed(source="../../../assets/mp3/ExplosionShip.mp3")] private var SoundExplosionShip:Class;
		[Embed(source="../../../assets/mp3/ExplosionAlien.mp3")] private var SoundExplosionAlien:Class;
		[Embed(source="../../../assets/mp3/Bullet.mp3")] private var SoundBullet:Class;



         public static var _trees:FlxGroup;
         public var frog:Frog;
         public static var _textBox:FlxText;
         public var bombs:FlxGroup;
         public var spawnTimer:Number = 2;
         public var redBirdTimer:Number=10;
         public var redBirdFrequency:Number=10;
         public var redBirds:FlxGroup;
        public var birdBombs:FlxGroup;

		override public function create():void
		{
			FlxG.score = 0;

			bgColor = 0x000000;

          //  floor = new Floor;
          //  add(floor);

/*            _trees = new FlxGroup();
            var  _tree:GreenTree = new GreenTree(GreenTree._imageWidth/2);
            _trees.add(_tree);
           // _tree = new GreenTree((FlxG.width - GreenTree._imageWidth)/2);
           // _trees.add(_tree);
            _tree = new GreenTree(FlxG.width - GreenTree._imageWidth*3/2);
            _trees.add(_tree);
            add(_trees);*/


            frog = new Frog(GreenTree._imageWidth - Frog._imageWidth/2,
                    FlxG.height - Frog._imageHeight);
            add(frog);

            // These are actually blue birds
            bombs = new FlxGroup();
            add(bombs);

            // Bombs dropped by red birds
            birdBombs = new FlxGroup;
            add(birdBombs);


            redBirds = new FlxGroup;
            add(redBirds);

            _textBox = new FlxText(100,100, 300, "");
            _textBox.x = 100;
            _textBox.y = 100;
            add(_textBox)
            super.create();


		}

		override public function update():void
		{
/*
            var treeOverlap:Boolean = false;
            for each(var tree:FlxObject in (_trees as FlxGroup).members)
                if(FlxUPP.overlapPP(frog,_trees))
                {
                    overlapFrogTrees(frog,tree as GreenTree);
                    treeOverlap = true;
                    break;
                }
            if (!treeOverlap)
                frog.acceleration.y = Frog._gravity;
*/




            FlxU.overlap(frog,bombs, overlapBirdBandar);
            FlxU.overlap(frog,redBirds, overlapBirdBandar);
            FlxU.overlap(frog,birdBombs, overlapBandarBomb);

//            FlxU.overlap(birdBombs, _trees, overlapBirdBombTree);

            spawnTimer-=FlxG.elapsed;
            if(spawnTimer < 0)
            {
                spawnBomb();
                spawnTimer= 2;
            }
            redBirdTimer-=FlxG.elapsed;
            if (redBirdTimer < 0)
            {
                spawnRedBird();
                redBirdTimer=redBirdFrequency;
            }
            super.update();
		}

        private function spawnRedBird():void
        {
           var y_cord:Number = Math.random()  * (FlxG.height/3) + 20;
           var birdinstance:RedBird = new RedBird(0, y_cord, birdBombs);
           birdinstance.velocity.x=200;
           redBirds.add(birdinstance);
        }

		private function overlapFrogTrees(frog: Frog, tree:GreenTree):void
        {
            // We need to bring the frog to rest
            frog.velocity.x=0;
            frog.velocity.y=0;
            frog.acceleration.x=0;
            frog.acceleration.y=0;
            frog.angle=0;
            frog.angularVelocity=0;
        }

        private function overlapBirdBombTree(birdBomb: FlxSprite, tree:FlxSprite):void
        {
            birdBomb.kill();
            _trees.remove(tree, true);
            tree.kill();
            var emitter1:FlxEmitter = createEmitter();
            emitter1.at(tree);
        }

        private function overlapBandarBomb(bandar: FlxSprite, birdBomb:FlxSprite):void
        {
            birdBomb.kill();
            var emitter1:FlxEmitter = createEmitter();
            emitter1.at(birdBomb);
        }


        private function overlapBirdBandar(bandar: FlxSprite, bird:FlxSprite):void
        {
            // Bounce the frog
            if (FlxG.keys.LEFT)
                bandar.velocity.x=-Frog._x_speed;
            else if (FlxG.keys.RIGHT)
                bandar.velocity.x = Frog ._x_speed;
            bandar.velocity.y=-Frog._y_speed;
            bird.kill();
            var emitter1:FlxEmitter = createEmitter();
            emitter1.at(bird);
        }

        /*	private function overlapAlienShip(alien: Alien, ship: Ship):void
          {
              var emitter:FlxEmitter = createEmitter();
              emitter.at(ship);
              ship.kill();
              alien.kill();
              FlxG.quake.start(0.02);
              FlxG.play(SoundExplosionShip);
      _gameOverText = new FlxText(0, FlxG.height / 2, FlxG.width, "GAME OVER\nPRESS ENTER TO PLAY AGAIN");
              _gameOverText.setFormat(null, 16, 0xFF597137, "center");
              add(_gameOverText);            *      		}              */
				
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

        private function spawnBomb():void
        {
           var y_cord:Number = Math.random()  * (FlxG.height - 200) + 50;
           var bomb:Sphere = new Sphere(0,y_cord);
           bomb.velocity.x=100;
           bombs.add(bomb);
        }


	}
}