function httpResponse(response, status, message, data) {
  return response.status(status).json({ message, data });
}

module.exports = { httpResponse };
