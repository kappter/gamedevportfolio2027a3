// Mr Kapptie | 16 Sept 2026 | SpaceGame
//import gifAnimation.*;

import processing.sound.*;
SoundFile laser1;

ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<PowerUp> powUps = new ArrayList<PowerUp>();
Ship ship01;
Boss boss01;
Timer rockDist, puDist;
int score, rockCount, rocksOffScreen, laserSpeed, level;
boolean play;

void setup() {
  size(800, 1000);
  boss01 = new Boss(-200,200,1);
  // rocks.add(new Rock(int(random(width)), -60));
  // powUps.add(new PowerUp(int(random(width)), -60));
  ship01 = new Ship(width/2, height/2);
  rockDist = new Timer(2000);
  rockDist.start();
  puDist = new Timer(3000);
  puDist.start();
  //bossFreq = new Timer(30000);
  //bossFreq.start();
  score = 0;
  rockCount = 0;
  rocksOffScreen = 0;
  laserSpeed = 5;
  play = false;
  level = 1;
  laser1 = new SoundFile(this, "laser1.mp3");
}

void draw() {
  noCursor();

  // check for start screen
  if (play == false) {
    startScreen();
  } else {
    background(20);

    // Add Rocks
    if (rockDist.isFinished() == true) {
      rockDist.start();
      rocks.add(new Rock(int(random(width)), -60));
      rockCount++;
    }

    // Add Power Ups
    if (puDist.isFinished() == true) {
      puDist.start();
      powUps.add(new PowerUp(int(random(width)), -60));
    }
    
    boss01.display();
    boss01.move();

    // Displays and moves power ups and compares ship
    for (int i = 0; i < powUps.size(); i++) {
      PowerUp pu = powUps.get(i);
      pu.display();
      pu.move();
      // add isHit()
      if (pu.isHit(ship01)) {
        // Find which power up is assigned
        if (pu.type == 'h') {
          // Increase health of ship
          ship01.health += 100;
          powUps.remove(pu);
        } else if (pu.type == 's') {
          laserSpeed = laserSpeed + 1;
          powUps.remove(pu);
        } else if (pu.type == 't') {
          ship01.turretCount += 1;
          powUps.remove(pu);
        }
      }
      // find if off screen
      if (pu.isOffScreen() == true) {
        powUps.remove(pu);
      }
      println("Power Ups: " + powUps.size());
    }

    // Player control
    ship01.display();
    ship01.move(mouseX, mouseY);

    // Display and move rocks and detect ship collision
    for (int i = 0; i < rocks.size(); i++) {
      Rock r = rocks.get(i);
      r.display();
      r.move();
      // add isHit()
      if (ship01.isHit(r)) {
        rocks.remove(r);
        score += 100;
      }
      if (r.isOffScreen() == true) {
        rocks.remove(r);
        rocksOffScreen++;
      }
      println(rocks.size());
    }

    // Display and move lasers and detect rock collision
    for (int i = 0; i < lasers.size(); i++) {
      Laser l = lasers.get(i);
      for (int j = 0; j < rocks.size(); j++) {
        Rock r = rocks.get(j);
        if (r.isHit(l)) {
          // increment score
          // remove rock and laser
        }
      }
      l.display();
      l.move();

      if (l.isOffScreen() == true) {
        lasers.remove(l);
      }
      println(lasers.size());
    }
    infoPanel();
    if (ship01.health<1 || rocksOffScreen>9) {
      gameOver();
    }
  }
}

void mousePressed() {
  if(ship01.turretCount == 1) {
    lasers.add(new Laser(ship01.x, ship01.y, laserSpeed));
  } else if(ship01.turretCount == 2) {
    lasers.add(new Laser(ship01.x-20, ship01.y, laserSpeed));
    lasers.add(new Laser(ship01.x+20, ship01.y, laserSpeed));
  } else  {
    lasers.add(new Laser(ship01.x, ship01.y, laserSpeed));
    lasers.add(new Laser(ship01.x-20, ship01.y, laserSpeed));
    lasers.add(new Laser(ship01.x+20, ship01.y, laserSpeed));
  }
}

// add infoPanel()
void infoPanel() {
  fill(127, 127);
  rectMode(CORNER);
  rect(0, 0, width, 40);
  fill(255);
  textSize(25);
  textAlign(CORNER, CORNER);
  text("Score:" + score, 20, 35);
  text("Rock Count:" + rockCount, 180, 35);
  text("Health:" + ship01.health, 380, 35);
  text("Rocks Passed:" + rocksOffScreen, 500, 35);
}

void startScreen() {
  background(0);
  // Add start screen graphic
  fill(255);
  text("Click mouse to start game...", width/2, height/2);
  if (mousePressed) {
    play = true;
  }
}

void gameOver() {
  background(0);
  // Add game over graphic
  fill(255);
  text("Game Over! Thanks for Playing!", width/2, height/2);
  noLoop();
}
