export interface UserStats {
  hardClearNum: number;
  normalClearNum: number;
  easyClearNum: number;
  hardCorrectNum: number;
  normalCorrectNum: number;
  easyCorrectNum: number;
}

export interface User {
  userId: string;
  email: string;
  userName: string;
  iconPath: string | null;
  role: 'admin' | 'user';
  stats: UserStats;
  createdAt: Date;
  updatedAt: Date;
}

/* ---------- DB 行マッピング ---------- */
export interface UserRow {
  u_id: string;
  email: string;
  user_name: string;
  icon_path: string | null;
  role: 'admin' | 'user';
  hard_clear_num: number;
  normal_clear_num: number;
  easy_clear_num: number;
  hard_correct_num: number;
  normal_correct_num: number;
  easy_correct_num: number;
  created_at: Date;
  updated_at: Date;
}

export interface CreateUserParams {
  u_id: string;
  email: string;
  user_name: string;
}

export interface UpdateUserParams {
  userName: string;
  iconPath?: string | null;
}
