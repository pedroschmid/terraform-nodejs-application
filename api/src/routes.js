const { Router } = require('express');
const { list, create, destroy } = require("./controllers/post.js")

const route = Router();

route.get("/posts", list);
route.post('/posts', create);
route.delete('/posts/:id', destroy);

module.exports = { route };