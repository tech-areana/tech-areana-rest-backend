import config  from './config';          // ← port をここから取る
import logger  from './config/logger';
import app     from './app';             // ← default import で Router 問題も解消
import swagger from './docs/swagger';    // ← export default にしておくと楽

// Swagger セットアップ
swagger(app);

app.listen(config.port, '0.0.0.0', () => {
  logger.info(`✔ Server running → http://localhost:${config.port}`);
});
