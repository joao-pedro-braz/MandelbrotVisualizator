uniform vec2 worldAnchorPoint;
uniform float unitToPixelRatio;
uniform int maxIterations;

void main() {
  int iterCount = 0;
  vec2 z = vec2(0.0, 0.0);
  vec2 z2 = vec2(0.0, 0.0);

  while (z2.x + z2.y <= 4.0 && iterCount < maxIterations) {
    z.y = (z.x + z.x) * z.y + (gl_TexCoord[0].y / unitToPixelRatio + worldAnchorPoint.y);
    z.x = z2.x - z2.y + (gl_TexCoord[0].x / unitToPixelRatio + worldAnchorPoint.x);

    z2.x = z.x * z.x;
    z2.y = z.y * z.y;

    iterCount++;
  }

  gl_FragColor = vec3(iterCount / maxIterations, iterCount / maxIterations, iterCount / maxIterations)
}
