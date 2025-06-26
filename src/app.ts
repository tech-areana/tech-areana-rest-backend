import { NextFunction, Request, Response } from "express";
import express from 'express';
import cors from 'cors';
import routes from './routes'; // ルーティングのインポート
import logger from "./config/logger";

const app = express();

// ✅ CORSミドルウェア（必ず最初の方に）
app.use(cors({
  origin: '*', // ← 本番は 'https://your-site.com' などに制限
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));

app.use(express.json());

// ルート統合
app.use(routes);

// エラーハンドラ
app.use((err:unknown, _req:Request, res:Response, _next:NextFunction) => {
  logger.error(err);
  res.status(500).json({ message: 'Internal Server Error' });
});

export default app;
