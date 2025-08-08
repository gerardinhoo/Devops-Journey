const express = require('express');
const client = require('prom-client');

const app = express();
const register = new client.Registry();

// Collect default metrics
client.collectDefaultMetrics({ register });

// Optional: Define custom metrics
const httpRequestDurationMicroseconds = new client.Histogram({
  name: 'http_request_duration_ms',
  help: 'Duration of HTTP requests in ms',
  labelNames: ['method', 'route', 'code'],
  buckets: [50, 100, 200, 300, 400, 500] // in ms
});
register.registerMetric(httpRequestDurationMicroseconds);

// Middleware to measure request duration
app.use((req, res, next) => {
  const end = httpRequestDurationMicroseconds.startTimer();
  res.on('finish', () => {
    end({ method: req.method, route: req.path, code: res.statusCode });
  });
  next();
});

const PORT = process.env.PORT || 8080;

// Define app routes
app.get('/', (req, res) => {
  res.send(`🚀 Hello from Gerard's Simple Node API!`);
});

// Expose metrics
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});

// Start the server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
