import admin from 'firebase-admin';
import { readFileSync } from 'fs';
import path from 'path';

/* ---------- Service Account 取得 ---------- */
const serviceAccountPath =
  process.env.GOOGLE_APPLICATION_CREDENTIALS ??
  path.resolve(__dirname, '../../service-account.json');

admin.initializeApp({
  credential: admin.credential.cert(
    JSON.parse(readFileSync(serviceAccountPath, 'utf8')),
  ),
});

console.log('[INFO] Firebase Admin Initialized');

export default admin;
