const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 3000;

// Set the path to the playersDB.json file!
const PLAYERS_DB_PATH = '/path/to/txAdmin/txData/playersDB.json';

app.get('/playersdb', (req, res) => {
  try {
    // Read the contents of the file
    const rawData = fs.readFileSync(path.resolve(PLAYERS_DB_PATH), 'utf-8');
    const jsonData = JSON.parse(rawData);
    res.json(jsonData);
  } catch (error) {
    console.error('Error reading playersDB.json file:', error);
    // Error reading playersDB.json file
    res.status(500).json({ error: 'Could not read playersDB.json file.' });
  }
});

app.listen(PORT, () => {
  console.log(`tx-admin-fetcher is running on port ${PORT}.`);
});
