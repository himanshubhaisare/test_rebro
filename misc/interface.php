<?php

// create an interface called Shape with one method getArea
interface Shape {
    public function getArea();
    public function draw($x, $y, GraphicsLibrary $library);
}

interface GraphicsLibrary {
    public function drawLine($x1, $y1, $x2, $y2);
    public function drawCircle($x, $y, $radius);
    ..
}

class GDGraphicsLibrary implements GraphicsLibrary {
    public function drawCircle($x, $y, $radius) {
        $gd->circle($x, $y, $radius);
    }
    ...
}

class IMGraphicsLibrary implements GraphicsLibrary {
    public function drawCircle($x, $y, $radius) {
        $im->arc($x, $y, $radius, 360);
    }
    ..
}

// write a Circle class that implements your interface
// area = M_PI * radius * radius
class Circle implements Shape {
    
    private $rad;
    private $lib;
    
    public __construct($rad, $lib) {
        if($rad>0) {
            $this->rad = $rad;
            $this->lib = $lib;
        } else {
            throw new Exception("Circle requires positive rad");
        }
        
    }
    
    public function getArea() {
        return 3.14*$this->rad*$this->rad;
    }
    
    public function setRadius($rad) {
        $this->rad = $rad;
    }

    public function draw($x, $y, GraphicsLibrary $library) {
        $library->drawCircle($x, $y, $this->rad);
    }
}

$circle = new Circle(1);
$gd = new GD(); // $gd->circle($x, $y, $radius)
$circle->draw(100, 100, $gd);
$im = new ImageMagick(); // $im->arc($x, $y, $radius, $degrees)
$circle->draw(1600, 1200, $im);
