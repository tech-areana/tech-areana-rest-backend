import { Request, Response } from 'express';
import * as authService from '../services/authService';
import { LoginBody, LoginRes } from '../types/auth';

export const login = async (
  req: Request<{}, {}, LoginBody>,
  res: Response<LoginRes>,
): Promise<void> => {
  try {
    const result = await authService.loginOrRegister(req.body);
    res.json(result);
  } catch (e) {
    if (
      typeof e === 'object' &&
      e !== null &&
      'code' in e &&
      (e as any).code === 'ER_ACCESS_DENIED_ERROR'
    ) {
      res.status(500).json({ message: 'DB connection failed' } as any);
      return;
    }

    const msg = e instanceof Error ? e.message : String(e);
    res.status(401).json({ message: msg } as any);
  }
};
