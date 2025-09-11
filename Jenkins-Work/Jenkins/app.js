import express from 'express';

const app = express();
app.use(express.json());

app.get('/health', (_req, res) => res.json({ ok: true })); // boolean true

app.get('/', (_req, res) => res.json({ message: 'Helloooo from Jenkins' }));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`App listening on http://0.0.0.0:${PORT}`));
