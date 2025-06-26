import { Request, Response, NextFunction } from 'express';
import admin from '../config/firebase'; // ← export default で初期化した Firebase Admin SDK

/**
 * Firebase 認証トークンを検証し、成功すれば req.user を設定。
 * 失敗時は 401 を返してレスポンスを終了する。
 */
const auth = async (req: Request, res: Response, next: NextFunction) => {
  const header = req.headers.authorization;

  // "Bearer xxx" 形式をチェック
  if (!header?.startsWith('Bearer ')) {
    res.status(401).json({ message: 'Unauthorized' });
    return;
  }

  const idToken = header.split(' ')[1];

  try {
    // Firebase で ID トークン検証
    const decoded = await admin.auth().verifyIdToken(idToken);

    // req.user にセット（型拡張済み）
    req.user = {
      userId: decoded.uid,
      email: decoded.email,
      name: decoded.name,
    };

    next();
  } catch (err) {
    console.error('Firebase token error:', err instanceof Error ? err.message : err);
    res.status(401).json({ message: 'Invalid token' });
    return;
  }
};

export default auth;
