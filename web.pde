class Web {
    private ArrayList<PVector> core;
    private ArrayList<PVector> segments;
    private int n;

    public Web(int n) {
        this.n = n;
        this.core = getPolygon(n);
        this.segments = new ArrayList<PVector>(this.core);
    }

    private PVector getLimitedSegment(PVector start1, PVector end1, PVector intersection, float scaling) {
        if (intersection == null) {
            return PVector.lerp(start1, end1, scaling + 1);
        }
        PVector limit = PVector.lerp(start1, end1, 2);
        PVector limited = PVector.lerp(end1, intersection, scaling);
        if (end1.dist(limit) > end1.dist(limited)) {
            return limited;
        }
        return PVector.lerp(limit, limited, scaling);
    }

    private PVector createSegment(int i, int size, float scaling) {
        PVector start1 = this.segments.get(this.n + i - 1);
        PVector end1 = this.segments.get(i);
        PVector start2 = this.segments.get(i + 2);
        PVector end2 = this.segments.get(i + 1);
        PVector intersection = getLineIntersection(start1, end1, start2, end2);
        PVector segment = getLimitedSegment(start1, end1, intersection, scaling);
        return segment;
    }

    public void createWeb(int size, float scaling) {
        for (int i = 0; i < size; i++) {
            PVector segment = createSegment(i, size, scaling);
            this.segments.add(segment);
        }
    }

    public PShape getWebShape(float scale, color from, color to, boolean curve, float stroke) {
        PShape webShape = createShape();
        webShape.beginShape();
        int size = this.segments.size();
        color gradient;
        for (int i = 0; i < size; i++) {
            PVector segment = this.segments.get(i);
            gradient = lerpColor(from, to, float(i) / float(size));
            webShape.stroke(gradient);
            webShape.noFill();
            webShape.strokeWeight(stroke);
            PVector transformed = PVector.mult(segment, scale);
            if (curve) {
                webShape.curveVertex(transformed.x, transformed.y);
            } else {
                webShape.vertex(transformed.x, transformed.y);
            }
        }
        webShape.endShape();
        return webShape;
    }
}
