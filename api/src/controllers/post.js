const { Post } = require("../models/post.js");
const { httpResponse } = require("../helpers.js");

async function list(request, response, next) {
  try {
    const data = await Post.findAll();
    return httpResponse(response, 200, "Listing posts", data);
  } catch (error) {
    return httpResponse(response, 500, error.message, {});
  }
}

async function create(request, response, next) {
  const { title, text } = request.body;

  try {
    await Post.create({ title, text });
    return httpResponse(response, 201, "Post created", { title, text });
  } catch (error) {
    return httpResponse(response, 500, error.message, {});
  }
}

async function destroy(request, response, next) {
  const { id } = request.params;

  try {
    await Post.destroy({ where: { id } });
    return httpResponse(response, 200, "Post destroyed", { id });
  } catch (error) {
    return httpResponse(response, 500, error.message, {});
  }
}

module.exports = { list, create, destroy }