// Mr Kapptie | 18 Sept 2025 | SpaceGame
Spaceship s1;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
Timer rockTimer;
int score, rocksPassed;

void setup() {
  size(500, 500);
  background(22);
  s1 = new Spaceship();
  rockTimer = new Timer(2000);
  rockTimer.start();
  score = 0;
  rocksPassed = 0;
}

void draw() {
  background(22);

  // Distributes a rock on a timer
  if (rockTimer.isFinished()) {
    rocks.add(new Rock());
    rockTimer.start();
  }

  // Display and moves all rocks
  for (int i = 0; i < rocks.size(); i++) {
    Rock rock = rocks.get(i);
    rock.move();
    rock.display();

    if (s1.intersect(rock)) {
      rocks.remove(rock);
      score+=rock.diam;
      s1.health-=10;
    }

    if (rock.reachedBottom()) {
      rocks.remove(rock);
      i--;
    }
    println(rocks.size());
  }

  // Display and move lasers
  for (int i = 0; i < lasers.size(); i++) {
    Laser laser = lasers.get(i);
    for (int j = 0; j<rocks.size(); j++) {
      Rock r = rocks.get(j);
      if (laser.intersect(r)) {
        
        //2. eradicate laser
        lasers.remove(laser);
        // 3. rocks should have health based on size
        r.diam -= 50;
        // 4. laser does less hp if rock is bigger
        if(r.diam<5) {
          rocks.remove(r);
        }
        score+=r.diam;
        // 5. laser will do less damage if spammed
        // 6. tapeworm takes over!!!!!!
        // 7. points go towards spaceship DEPENDING on size of rock destroyed w/ laser
      }
    }
    laser.display();
    laser.move();
  }

  s1.display();
  s1.move(mouseX, mouseY);
  infoPanel();
}

void mousePressed() {
  lasers.add(new Laser(s1.x, s1.y));
}

void infoPanel() {
  rectMode(CENTER);
  fill(127, 127);
  rect(width/2, 475, width, 50);
  fill(220);
  textSize(25);
  text("Score: " + score, 20, 475);
  text("Health: " + s1.health, 200, 475);
  text("Passed Rocks: ", width-180, 475);
}
