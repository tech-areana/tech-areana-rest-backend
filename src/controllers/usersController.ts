import { Request, Response } from 'express';
import * as userService from '../services/userService';
import { UpdateUserParams, User } from '../types/user';

/* GET /api/users/:id */
export const me = async (
  req: Request<{ id: string }>,
  res: Response<User>,
): Promise<void> => {
  const user = await userService.getMe(req.params.id);
  if (!user) {
    res.status(404).json({ message: 'ユーザーが存在しません' } as any);
    return;
  }
  res.json(user);
};

/* PUT /api/users/:id */
export const updateMe = async (
  req: Request<{ id: string }, {}, UpdateUserParams>,
  res: Response<User>,
): Promise<void> => {
  const { userName, iconPath } = req.body;
  if (!userName) {
    res.status(400).json({ message: 'userName は必須です' } as any);
    return;
  }

  const user = await userService.updateMe(req.params.id, { userName, iconPath });
  if (!user) {
    res.status(404).json({ message: 'ユーザーが存在しません' } as any);
    return;
  }
  res.json(user);
};
