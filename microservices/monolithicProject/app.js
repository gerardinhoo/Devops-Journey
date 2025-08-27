import express from 'express';
import morgan from 'morgan';

const app = express();
app.use(express.json());
app.use(morgan(process.env.NODE_ENV === 'production' ? 'combined' : 'dev'));

// In memory Data
const users = [
  {
    id: 'u1',
    fullName: 'Anastasia A',
  },
  {
    id: 'u2',
    fullName: 'Therese G',
  },
  {
    id: 'u3',
    fullName: 'Sanctus E',
  },
];

const orders = [
  {
    id: 'o100',
    userId: 'u1',
    item: 'Laptop',
    total: 2000,
  },
  {
    id: 'o101',
    userId: 'u2',
    item: 'Backpack',
    total: 150,
  },
  {
    id: 'o102',
    userId: 'u3',
    item: 'Flight Tickets',
    total: 1500,
  },
];

// To Implement microservices later

const findUserById = (id) => {
  return users.find((u) => u.id === id) || null;
};

const findOrderById = (id) => {
  return orders.find((o) => o.id === id) || null;
};

app.get('/healthz', (req, res) => {
  res.json({ ok: true });
});

// Users

app.get('/api/users', (req, res) => {
  res.status(200).json(users);
});

app.get('/api/users/:id', (req, res) => {
  const user = findUserById(req.params.id);

  if (!user) {
    return res.status(404).json({ error: 'No User found' });
  }
  res.json(user);
});

// Orders
app.get('/api/orders', (req, res) => {
  const userOrder = orders.map((order) => ({
    ...order,
    user: findUserById(order.userId) || { fullName: 'unknown' },
  }));
  res.json(userOrder);
});

app.get('/api/orders/:id', (req, res) => {
  const individualOrder = findOrderById(req.params.id);

  if (!individualOrder) {
    return res.status(400).json({ error: 'No Order found' });
  }
  res.json(individualOrder);
});

app.post('/api/orders', (req, res) => {
  const { userId, item, total } = req.body || {};
  if (!userId || !item || typeof total !== 'number') {
    return res
      .status(400)
      .json({ error: 'User ID, Item, Total(number) are required' });
  }

  const id = 'o' + (100 + orders.length);
  const order = { id, userId, item, total };
  orders.push(order);
  res.status(201).json(order);
});

const port = Number(process.env.PORT || 3000);
const server = app.listen(port, () => {
  console.log(`Monolith App listening on http://localhost:${port}`);
});

// graceful shutdown
const shutdown = () => server.close(() => process.exit(0));
process.on('SIGTERM', shutdown);
process.on('SIGINT', shutdown);
