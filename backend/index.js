const express = require("express");
const pg = require("pg");
const jwt = require("jsonwebtoken");
require("dotenv").config();

const pool = new pg.Pool({
  user: process.env.PG_USER,
  password: process.env.PG_PASSWORD,
  database: process.env.PG_DATABASE,
});

const port = process.env.PORT || 5000;
const app = express();

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// MIDDLEWARE BOILERPLATE
// TODO [2021-12-03]: Move to separate middleware folder
function isNotAuthenticated(req, res, next) {
  const authHeader = req.headers["Authorization"];

  if (authHeader) {
    const token = authHeader.slice("Bearer ".length);
    return token.length ? null : next();
  }

  return next();
}

function isAuthenticated(req, res, next) {
  const authHeader = req.headers["Authorization"];

  if (authHeader) {
    const token = authHeader.slice("Bearer ".length);
    if (token.length) {
      try {
        // check if access token is valid
        const valid = jwt.verify(token, process.env.JWT_ACCESS_TOKEN_SECRET);
        req.userId = valid.userId;
        return next();
      } catch (error) {
        return null;
      }
    }
  }

  return res.status(401).json({message: "Insufficient permissions."});
}

// ROUTE PROPER
// TODO [graphql]: Reorganize server routes and DB connection on GraphQL integration
pool.connect((error, client) => {
  if (error) {
    console.log("Could not connect to database.");
    process.exit(1);
  }

  //   GraphQL endpoint for future transition from REST to GraphQL
  app.get("/graphql", (req, res) => {});
  app.get("/", (req, res) =>
    res.json({
      data: {
        content: "Hello welcome to the test run!",
        timestamp: new Date().toDateString(),
      },
    })
  );
  app.get("/people", async (req, res) => {
    const result = await client.query('SELECT * FROM practice.person');
    return res.json(result.rows);
  });

  app.post("/login", isNotAuthenticated, (req, res) => {});
  app.post("/register", isNotAuthenticated, (req, res) => {});
  app.post("/product", isAuthenticated, (req, res) => {});
  app.post("/variant", isAuthenticated, (req, res) => {
    // takes user_id and product_id
    // check if product belongs to the currently logged in user
  });

  app.listen(port, () => {
    console.log(`Server is listening on http://localhost:${port}`);
  });
});
