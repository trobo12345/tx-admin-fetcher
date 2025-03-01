# tx-admin-fetcher

## Description

**tx-admin-fetcher** is a Node.js-based application that serves the content of the `playersDB.json` file used by txAdmin through an HTTP endpoint. This solution allows FiveM server-side scripts (e.g., Lua or JavaScript) to easily retrieve player data, such as play time (playTime). The repository also includes an example FiveM resource demonstrating how to integrate the playersDB data into your server-side code.

## Contents

- **Node.js Application**
  - `server.js`: An Express.js-based server that reads the `playersDB.json` file and serves its content via an HTTP endpoint.
  - `package.json`: Contains the Node.js project configuration and dependencies.
- **FiveM Resource**
  - `fivem/fxmanifest.lua`: The FiveM resource configuration file.
  - `fivem/server.lua`: An example server-side Lua script that retrieves the playersDB data from the tx-admin-fetcher endpoint using `PerformHttpRequest`.

## Requirements

- [Node.js](https://nodejs.org/en/) (minimum version 12.x)
- npm (Node Package Manager)
- A FiveM server if you wish to use the example resource

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/trobo12345/tx-admin-fetcher.git
   cd tx-admin-fetcher
   ```

2. **Install Node.js Dependencies**

   ```bash
   npm install
   ```

3. **Configuration**

   Open the `server.js` file and update the `PLAYERS_DB_PATH` variable to point to the exact location of the `playersDB.json` file used by txAdmin.

   Example:

   ```js
   const PLAYERS_DB_PATH = '/path/to/txAdmin/txData/playersDB.json';
   ```

## Running the Application

1. **Start the Node.js Server**

   ```bash
   node server.js
   ```

   The server will listen on port 3000 by default. The playersDB content is available at: [http://127.0.0.1:3000/playersdb](http://127.0.0.1:3000/playersdb).

2. **Using the FiveM Resource**

   - Copy the `fivem/` folder to your FiveM server's `resources` directory.
   - In your `server.cfg` file, add the resource startup line:

     ```cfg
     ensure txadmin_reader
     ```

   - Restart your FiveM server and, for example, use the `/getplaytime` command to retrieve a player's play time.


## License

This project is licensed under the **MIT License**.

## Contact

If you have any questions or suggestions, feel free to open an issue or submit a pull request!
