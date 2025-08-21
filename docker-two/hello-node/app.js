const express = require('express');

const app = express();

const PORT = process.env.PORT || 3000;


app.get('/', (req, res) => {
   res.send('A warming Greeting From EC2 Instance + Express');
})

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Listening server on Port ${PORT} `)
})