import dotenv from 'dotenv';
dotenv.config();

/* ---------- 型 ---------- */
export interface DbConfig {
  host: string;
  port: number;
  user: string;
  password: string;
  database: string;
  ssl: boolean;
}

export interface AppConfig {
  port: number;
  jwtSecret: string;
  db: DbConfig;
}

/* ---------- 値 ---------- */
const config: AppConfig = {
  port: Number(process.env.PORT) || 8000,
  jwtSecret: process.env.JWT_SECRET ?? 'dummy-secret',
  db: {
    host: process.env.DB_HOST ?? 'localhost',
    port: Number(process.env.DB_PORT) || 5432,
    user: process.env.DB_USER ?? 'postgres',
    password: process.env.DB_PASSWORD ?? '',
    database: process.env.DB_NAME ?? 'postgres',
    ssl: false,
  },
};

export default config;
