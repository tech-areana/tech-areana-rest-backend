export interface LoginBody {
  /** Firebase UID をそのまま渡す */
  userId: string;
  userName: string;
  email: string;
}

export interface LoginRes {
  userId: string;
}
