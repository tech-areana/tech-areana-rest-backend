import pool from '../config/db';
import {
  UserRow,
  CreateUserParams,
  UpdateUserParams,
} from '../types/user';

export const findById = async (userId: string): Promise<UserRow | null> => {
  const { rows } = await pool.query<UserRow>(
    'SELECT * FROM trx_user WHERE u_id = $1 AND deleted_at IS NULL',
    [userId],
  );
  return rows[0] ?? null;
};

export const create = async ({ u_id, email, user_name }: CreateUserParams) => {
  await pool.query(
    `
      INSERT INTO trx_user (u_id, email, user_name)
      VALUES ($1, $2, $3)
    `,
    [u_id, email, user_name],
  );
};

export const updateMe = async (
  userId: string,
  { userName, iconPath }: UpdateUserParams,
): Promise<boolean> => {
  const { rowCount } = await pool.query(
    `
      UPDATE trx_user
      SET user_name = $1,
          icon_path = $2,
          updated_at = NOW()
      WHERE u_id = $3 AND deleted_at IS NULL
    `,
    [userName, iconPath ?? null, userId],
  );
  return (rowCount ?? 0) > 0;
};
