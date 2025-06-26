import * as model from '../models/userModel';
import { User, UserRow, UpdateUserParams } from '../types/user';

const toUser = (u: UserRow): User => ({
  userId: u.u_id,
  email: u.email,
  userName: u.user_name,
  iconPath: u.icon_path,
  role: u.role,
  stats: {
    hardClearNum: u.hard_clear_num,
    normalClearNum: u.normal_clear_num,
    easyClearNum: u.easy_clear_num,
    hardCorrectNum: u.hard_correct_num,
    normalCorrectNum: u.normal_correct_num,
    easyCorrectNum: u.easy_correct_num,
  },
  createdAt: u.created_at,
  updatedAt: u.updated_at,
});

export const getMe = async (userId: string): Promise<User | null> => {
  const row = await model.findById(userId);
  return row ? toUser(row) : null;
};

export const updateMe = async (
  userId: string,
  params: UpdateUserParams,
): Promise<User | null> => {
  const ok = await model.updateMe(userId, params);
  if (!ok) return null;
  return getMe(userId); // 更新後の最新情報を返す
};
