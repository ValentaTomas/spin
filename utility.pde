ArrayList<PVector> getPolygon(int n) {
    float angleStep = TWO_PI / float(n);
    ArrayList<PVector> ngon = new ArrayList();
    for (int step = 0; step < n; step++) {
        float angle = step * angleStep;
        //uncomenting random (next line) makes whole web bounce in time
        PVector vertex = PVector.fromAngle(angle /* + random(0, 100) / 2000 */);
        ngon.add(vertex);
    }
    return ngon;
}

PVector getLineIntersection(PVector start1, PVector end1, PVector start2, PVector end2) {
    float x1 = start1.x;
    float y1 = start1.y;
    float x2 = end1.x;
    float y2 = end1.y;

    float x3 = start2.x;
    float y3 = start2.y;
    float x4 = end2.x;
    float y4 = end2.y;

    float bx = x2 - x1;
    float by = y2 - y1;
    float dx = x4 - x3;
    float dy = y4 - y3;

    float b_dot_d_perp = bx * dy - by * dx;

    if (b_dot_d_perp == 0) {
        return null;
    }

    float cx = x3 - x1;
    float cy = y3 - y1;

    float t = (cx * dy - cy * dx) / b_dot_d_perp;
    return new PVector(x1 + t * bx, y1 + t * by);
  }
