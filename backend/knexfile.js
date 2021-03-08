// Update with your config settings.
require("dotenv").config();

module.exports = {
  development: {
    client: 'postgresql',
    connection: {
      database: process.env.PG_DATABASE,
      user:     process.env.PG_USER,
      password: process.env.PG_PASSWORD
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations'
    }
  },

  production: {
    client: 'postgresql',
    connection: {
      database: process.env.NODE_ENV === "production" ? process.env.PG_DATABASE : process.env.PG_DATABASE_DEV,
      user:     process.env.PG_USER,
      password: process.env.PG_PASSWORD
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations'
    }
  }

};
