import express from 'express';
import morgan from 'morgan';

const app = express();
app.use(express.json());
app.use(morgan(process.env.NODE_ENV === 'production' ? 'combined' : 'dev'));

const orders = [
  { id: 'o100', userId: 'u1', item: 'Laptop', total: 2000 },
  { id: 'o101', userId: 'u2', item: 'Backpack', total: 150 },
  { id: 'o102', userId: 'u3', item: 'Flight Tickets', total: 1500 },
];

const USERS_BASE_URL = process.env.USERS_BASE_URL || 'http://localhost:3001';

// tiny timeout helper (Node 20 has global fetch)
async function fetchWithTimeout(url, ms = 2000) {
  const controller = new AbortController();
  const t = setTimeout(() => controller.abort(), ms);
  try {
    return await fetch(url, { signal: controller.signal });
  } finally {
    clearTimeout(t);
  }
}

app.get('/healthz', (_req, res) => res.json({ ok: true }));

// list orders, enriched with user info from users-svc
app.get('/orders', async (_req, res) => {
  try {
    const enriched = await Promise.all(
      orders.map(async (o) => {
        try {
          const r = await fetchWithTimeout(
            `${USERS_BASE_URL}/users/${o.userId}`
          );
          const user = r.ok ? await r.json() : { fullName: 'Unknown' };
          return { ...o, user };
        } catch {
          return { ...o, user: { fullName: 'Unknown' } };
        }
      })
    );
    res.json(enriched);
  } catch (e) {
    res.status(502).json({ error: 'users-svc unavailable', detail: String(e) });
  }
});

app.get('/orders/:id', (req, res) => {
  const order = orders.find((o) => o.id === req.params.id) || null;
  if (!order) return res.status(404).json({ error: 'Order not found' });
  return res.json(order);
});

app.post('/orders', (req, res) => {
  const { userId, item, total } = req.body ?? {};
  const parsedTotal = Number(total);
  if (!userId || !item || !Number.isFinite(parsedTotal)) {
    return res
      .status(400)
      .json({ error: 'userId, item, total(number) required' });
  }
  const id = 'o' + (100 + orders.length);
  const order = { id, userId, item, total: parsedTotal };
  orders.push(order);
  res.status(201).json(order);
});

const port = Number(process.env.PORT || 3002);
const server = app.listen(port, () => console.log(`orders-svc on ${port}`));
const shutdown = () => server.close(() => process.exit(0));
process.on('SIGTERM', shutdown);
process.on('SIGINT', shutdown);
