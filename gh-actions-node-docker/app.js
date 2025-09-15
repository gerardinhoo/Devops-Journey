import express from 'express';
const app = express();

app.get('/', (_, res) => res.json({ ok: true, service: 'gh-actions-demo' }));
app.get('/health', (_, res) => res.send('OK'));

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`API running on :${port}`));
