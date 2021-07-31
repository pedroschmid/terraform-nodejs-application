require('dotenv').config();

const express = require("express");
const cors = require("cors");
const morgan = require("morgan");

const server = express();

server.use(cors());
server.use(morgan("combined"));
server.use(express.json());
server.use(express.urlencoded({ extended: true }));

server.get("/health_check", (_, res) => res.json({ message: "Application its healthy =)" } ));

server.listen(process.env.PORT || 3000, () => console.log("Server running"));
