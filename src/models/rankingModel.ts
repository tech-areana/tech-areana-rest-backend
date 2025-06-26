import pool from '../config/db';
import { AllowedColumn, RankingRow } from '../types/rank';

const allowed: readonly AllowedColumn[] = [
  'hard_clear_num',
  'normal_clear_num',
  'easy_clear_num',
] as const;

/** 上位 10 件を生 SQL で取得 */
export const getTop10ByColumn = async (
  column: AllowedColumn,
): Promise<RankingRow[]> => {
  if (!allowed.includes(column)) throw new Error('Invalid column name');

  const { rows } = await pool.query<RankingRow>(
    `
      SELECT
        u_id       AS "userId",
        user_name  AS "userName",
        ${column}  AS "clearNum"
      FROM trx_user
      WHERE deleted_at IS NULL
      ORDER BY ${column} DESC
      LIMIT 10
    `,
  );
  return rows;
};
