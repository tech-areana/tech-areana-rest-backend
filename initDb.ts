// scripts/initDb.ts
import fs from 'fs';
import path from 'path';
import { Pool } from 'pg';

const pool = new Pool();

(async () => {
  try {
    const sql = fs.readFileSync(path.resolve(__dirname, 'init.sql'), 'utf8');
    await pool.query(sql);
    console.log('✅ DB初期化完了');
    process.exit(0);
  } catch (err) {
    console.error('❌ 初期化エラー:', (err as Error).message);
    process.exit(1);
  }
})();
