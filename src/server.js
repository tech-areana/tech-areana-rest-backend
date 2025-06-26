const { port } = require('./config');
const logger = require('./config/logger');
const app = require('./app');

// require('../initDb');  

// Swagger セットアップを追加！
require('./docs/swagger')(app);

app.listen(port, '0.0.0.0', () => {
    logger.info(`✔ Server running → http://localhost:${port}`);
});

