require("dotenv").config();
const express = require("express");
const mysql = require("mysql2");

const app = express();

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME
});

db.connect(err => {
  if (err) {
    console.error("❌ DB connection failed:", err.message);
    process.exit(1);
  }
  console.log("✅ Connected to RDS MySQL");
});

app.get("/", (req, res) => {
  db.query("SELECT NOW() AS time", (err, results) => {
    if (err) return res.status(500).send("DB query failed");
    res.send(`Hello from Amazon Linux + RDS! 🐬 Current time: ${results[0].time}`);
  });
});

app.get("/messages", (req, res) => {
  db.query("SELECT id, text, created_at FROM messages ORDER BY id DESC", (err, rows) => {
    if (err) return res.status(500).json({ error: "DB query failed" });
    res.json(rows);
  });
});

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`🚀 Server running on port ${port}`));
