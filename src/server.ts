import config  from './config';          // ← port をここから取る
import logger  from './config/logger';
import app     from './app';             // ← default import で Router 問題も解消
import swagger from './docs/swagger';    // ← export default にしておくと楽
import { initializeDatabase } from './db/initDb'; // DB 初期化用の関数


(async () => {
  // --- DB 初期化 -----------------------------------------------------------
  if (process.env.NODE_ENV !== 'production' && process.env.RUN_INIT === 'true') {
    try {
      await initializeDatabase();                     // ★ 実行は await で
      logger.info('✅ DB initialized');
    } catch (e) {
      logger.error('❌ DB init failed:', (e as Error).message);
      process.exit(1);
    }
  }

  // --- Swagger -------------------------------------------------------------
  swagger(app);

  // --- HTTP サーバ起動 ------------------------------------------------------
  app.listen(config.port, '0.0.0.0', () => {
    logger.info(`✔ Server running → http://localhost:${config.port}`);
  });
})();