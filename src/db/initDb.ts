import fs from 'fs';
import path from 'path';
import { Pool } from 'pg';
import config from '../config';


const pool = new Pool({
  host:     config.db.host,              // 'db'
  port:     config.db.port,
  user:     config.db.user,
  password: config.db.password,
  database: config.db.database,
  ssl:      config.db.ssl,
});

export async function initializeDatabase() {
  try {
    const sql = fs.readFileSync(path.resolve(__dirname, 'init.sql'), 'utf8');
    await pool.query(sql);
    console.log('✅ DB初期化完了');
  } catch (err) {
    console.error('❌ 初期化エラー:', (err as Error).message);
    throw err;
  }
}

// スクリプトとして直接実行された場合
if (require.main === module) {
  (async () => {
    try {
      await initializeDatabase();
      process.exit(0);
    } catch {
      process.exit(1);
    }
  })();
}