void setup() {
    //size(800, 600, P2D);
    fullScreen(P2D, 1);
    createGUI();
    frameRate(24);
    smooth(4);
}

void render() {
    background(getBackgroundVar());
    Web web = new Web(getCoreVar());
    web.createWeb(getSizeVar(), getLarpVar());
    PShape webShape = web.getWebShape(width / getZoomVar(), getFromVar(), getToVar(), isCurve(), getStrokeVar());
    webShape.translate(width / 2, height / 2);
    shape(webShape);
}

void draw() {
    render();
}
