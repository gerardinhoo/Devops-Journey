import express from 'express';
import morgan from 'morgan';

const app = express();
app.use(express.json());
app.use(morgan(process.env.NODE_ENV === 'production' ? 'combined' : 'dev'));

const users = [
  { id: 'u1', fullName: 'Anastasia A' },
  { id: 'u2', fullName: 'Therese G' },
  { id: 'u3', fullName: 'Sanctus E' },
];

app.get('/health', (req, res) => {
  res.json({ ok: 'true' });
});

app.get('/users/:id', (req, res) => {
  const user = users.find((u) => u.id === req.params.id) || null;
  if (!user) return res.status(400).json({ error: 'No user not found' });
  return res.json(user);
});

app.get('/users', (req, res) => {
  return res.json(users);
});

const port = Number(process.env.PORT) || 3001;
const server = app.listen(port, () => console.log(`users-svc on ${port}`));
const shutdown = () => server.close(() => process.exit(0));
process.on('SIGTERM', shutdown);
process.on('SIGINT', shutdown);
