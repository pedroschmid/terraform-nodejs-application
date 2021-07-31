const { DataTypes } = require("sequelize");
const { sequelize } = require("../sequelize.js");

const Post = sequelize.define("Post", {
  title: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  description: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
});

module.exports = { Post };
