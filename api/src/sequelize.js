const { Sequelize } = require("sequelize");

const {
  DATABASE_HOST,
  DATABASE_PORT,
  DATABASE_NAME,
  DATABASE_USER,
  DATABASE_PASSWORD,
} = process.env;

const sequelize = new Sequelize(
  DATABASE_NAME,
  DATABASE_USER,
  DATABASE_PASSWORD,
  {
    host: DATABASE_HOST,
    port: DATABASE_PORT,
    dialect: "mysql",
  }
);

try {
  sequelize.authenticate();
  sequelize.sync();
} catch (error) {
  throw new Error("Could not connect to database");
}

module.exports = { sequelize };
