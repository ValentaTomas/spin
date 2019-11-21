import controlP5.*;

ControlP5 cp5;

int saveScale = 2;

boolean guiVisible = true;

RadioButton vertexType;
boolean curve = false;

Slider zoomSlider;

Slider coreSlider;
int coreStart = 5;
int coreEnd = 35;

Slider larpSlider;
float larpStart = 0.01;
float larpEnd = 0.99;

Slider sizeSlider;
int sizeStart = 4;
int sizeEnd = 1800;

Slider strokeSlider;
float strokeStart = 1;
float strokeEnd = 10;

ColorPicker backgroundColor;
ColorPicker fromColor;
ColorPicker toColor;

boolean isCurve() {
    return vertexType.getValue() > 0;
}

int getCoreVar() {
    return int(coreSlider.getValue());
}

float getLarpVar() {
    return larpSlider.getValue();
}

int getSizeVar() {
    return int(sizeSlider.getValue());
}

float getZoomVar() {
    return pow(zoomSlider.getValue(), 2);
}

color getFromVar() {
    return color(fromColor.getArrayValue(0), fromColor.getArrayValue(1), fromColor.getArrayValue(2));
}

color getToVar() {
    return color(toColor.getArrayValue(0), toColor.getArrayValue(1), toColor.getArrayValue(2));
}

color getBackgroundVar() {
    return color(backgroundColor.getArrayValue(0), backgroundColor.getArrayValue(1), backgroundColor.getArrayValue(2));
}

float getStrokeVar() {
    return strokeSlider.getValue();
}

color randomColor() {
    return color(random(0, 255), random(0, 255), random(0, 255));
}

void randomizeColors() {
    fromColor.setColorValue(randomColor());
    toColor.setColorValue(randomColor());
    backgroundColor.setColorValue(randomColor());
}

void randomizeLarp() {
    larpSlider.setValue(random(larpStart, larpEnd));
}

void randomizeCore() {
    coreSlider.setValue(random(coreStart, coreEnd));
}

void randomizeSize() {
    sizeSlider.setValue(random(sizeStart, sizeEnd));
}

void randomizeStroke() {
    strokeSlider.setValue(random(strokeStart, strokeEnd));
}

void createGUI() {
    cp5 = new ControlP5(this);

    strokeSlider = cp5.addSlider("stroke")
        .setPosition(width - 135, 270)
        .setSize(80, 15)
        .setRange(strokeStart, strokeEnd)
        .setValue(1)
        ;

    coreSlider = cp5.addSlider("core")
        .setPosition(20, 20)
        .setSize(150, 20)
        .setRange(coreStart, coreEnd)
        .setValue(random(5, 35))
        ;

    larpSlider = cp5.addSlider("larp")
        .setPosition(20, 50)
        .setSize(200, 20)
        .setRange(larpStart, larpEnd)
        .setValue(0.5)
        ;

    sizeSlider = cp5.addSlider("size")
        .setPosition(20, height - 40)
        .setSize(width / 2, 30)
        .setRange(sizeStart, sizeEnd)
        .setValue(random(4, 500))
        ;

    zoomSlider = cp5.addSlider("zoom")
        .setPosition(width - 40, height / 2 - 20)
        .setSize(20, height / 2)
        .setRange(1, 40)
        .setValue(2)
        ;

    vertexType = cp5.addRadioButton("vertex type")
        .setPosition(20, height - 70)
        .setSize(20, 20)
        .setColorForeground(color(120))
        .setColorActive(color(255))
        .setColorLabel(color(255))
        .setSpacingColumn(50)
        .addItem("curve vertex", 1)
        ;

    backgroundColor = cp5.addColorPicker("background picker")
        .setPosition(width - 280, 20)
        .setColorValue(randomColor())
        ;
    fromColor = cp5.addColorPicker("from picker")
        .setPosition(width - 280, 100)
        .setColorValue(randomColor())
        ;
    toColor = cp5.addColorPicker("to picker")
        .setPosition(width - 280, 180)
        .setColorValue(randomColor())
        ;
}

// does not work with opengl (PD2) so it cannot render curve vertex
void saveHighRes(int scaleFactor) {
  PGraphics hires = createGraphics(
                        width * scaleFactor,
                        height * scaleFactor,
                        JAVA2D);

  beginRecord(hires);
  hires.scale(scaleFactor);
  render();
  endRecord();
  hires.save("screen-" + frameCount + ".png");
}

void keyPressed() {
    if (keyCode == ENTER || keyCode == RETURN) {
        saveFrame("screen-####.png");
        //saveHighRes(saveScale);
        return;
    }
    if (keyCode == TAB) {
        if (guiVisible) {
            cp5.hide();
        } else {
            cp5.show();
        }
        guiVisible = !guiVisible;
        return;
    }
    if (keyCode == SHIFT) {
        randomizeColors();
    }
    if (keyCode == ALT) {
        randomizeLarp();
        randomizeCore();
    }
    if (keyCode == CONTROL) {
        randomizeSize();
        randomizeStroke();
    }
    if (keyCode == UP) {
        randomizeLarp();
        randomizeCore();
        randomizeSize();
        randomizeStroke();
        randomizeColors();
    }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoomSlider.setValue(zoomSlider.getValue() + e / 25);
}