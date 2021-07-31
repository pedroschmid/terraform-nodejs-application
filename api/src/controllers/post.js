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
