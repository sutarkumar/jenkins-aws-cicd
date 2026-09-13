const express = require('express');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

// Root Endpoint
app.get('/', (req, res) => {
  res.status(200).json({
    message: 'CI/CD Demo Application is running'
  });
});

// Health Check Endpoint
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'UP'
  });
});

// Export app for testing without starting server
module.exports = app;

// Start server only when executed directly
if (require.main === module) {
  app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });
}
