const request = require('supertest');
const app = require('../server');

describe('API Endpoints', () => {
  describe('GET /', () => {
    it('should return HTTP 200 and expected message', async () => {
      const res = await request(app).get('/');
      expect(res.statusCode).toBe(200);
      expect(res.body).toEqual({
        message: 'CI/CD Demo Application is running'
      });
    });
  });

  describe('GET /health', () => {
    it('should return HTTP 200 and status UP', async () => {
      const res = await request(app).get('/health');
      expect(res.statusCode).toBe(200);
      expect(res.body).toEqual({
        status: 'UP'
      });
    });
  });
});
