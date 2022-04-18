#version 400

uniform vec2 worldAnchorPointX;
uniform vec2 worldAnchorPointY;
uniform vec2 worldAnchorPoint;
uniform float unitToPixelRatio;
uniform int maxIterations;
uniform bool cardioidCheck;
uniform bool precisionMode;

layout(origin_upper_left) in vec4 gl_FragCoord;

void main() {
  int iterCount = 0;
  dvec2 z = dvec2(0.0, 0.0);
  dvec2 z2 = dvec2(0.0, 0.0);
  dvec2 worldCameraPoint = dvec2(0.0, 0.0);

  if (precisionMode) {
    double m_worldAnchorPointX = double(worldAnchorPointX.x + worldAnchorPointX.y);
    double m_worldAnchorPointY = double(worldAnchorPointY.x + worldAnchorPointY.y);

    worldCameraPoint = dvec2(double(gl_FragCoord.x / unitToPixelRatio + m_worldAnchorPointX),
     double(gl_FragCoord.y / unitToPixelRatio + m_worldAnchorPointY));
  } else {
    worldCameraPoint = dvec2(double(gl_FragCoord.x / unitToPixelRatio + worldAnchorPoint.x),
      double(gl_FragCoord.y / unitToPixelRatio + worldAnchorPoint.y));
  }

  if (cardioidCheck) {
    // https://en.wikipedia.org/wiki/Plotting_algorithms_for_the_Mandelbrot_set#Cardioid_/_bulb_checking
    double x = double(worldCameraPoint.x);
    double y = double(worldCameraPoint.y);
    double q = (x - 0.25) * (x - 0.25) + y * y;

    if (q * (q + (x - 0.25)) <= (y * y) * 0.25) {
      iterCount = maxIterations;
    }
  }

  // https://en.wikipedia.org/wiki/Plotting_algorithms_for_the_Mandelbrot_set#Optimized_escape_time_algorithms
  if (iterCount == 0) {
    while (z2.x + z2.y <= 4.0 && iterCount < maxIterations) {
      z.y = (z.x + z.x) * z.y + worldCameraPoint.y;
      z.x = z2.x - z2.y + worldCameraPoint.x;

      z2.x = z.x * z.x;
      z2.y = z.y * z.y;

      iterCount++;
    }
  }

  int adjustedCount = iterCount % maxIterations;

  gl_FragColor = vec4((adjustedCount % 16) / 16.0, (adjustedCount % 170) / 170.0, (adjustedCount % 85) / 85.0, 1.0);
}
