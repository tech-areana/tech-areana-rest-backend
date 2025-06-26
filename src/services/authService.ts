import * as userModel from '../models/userModel';
import { LoginBody, LoginRes } from '../types/auth';

export const loginOrRegister = async ({
  userId,
  userName,
  email,
}: LoginBody): Promise<LoginRes> => {
  let user = await userModel.findById(userId);

  if (!user) {
    await userModel.create({
      u_id: userId,
      email,
      user_name: userName,
    });
    user = await userModel.findById(userId);
  }

  return { userId: user!.u_id };
};
