import { Pool } from 'pg';
import config from './index';

export const pool = new Pool(config.db);

export default pool;
