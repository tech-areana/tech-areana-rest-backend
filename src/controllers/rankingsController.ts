import { Request, Response } from 'express';
import * as rankingService from '../services/rankingService';
import { RankingList } from '../types/rank';

export const getRankingList = async (
  _req: Request,
  res: Response<RankingList>,
): Promise<void> => {
  const rankingList = await rankingService.getRankingList();

  const isAllEmpty = Object.values(rankingList).every(
    (list) => list.length === 0,
  );
  if (isAllEmpty) {
    res.status(404).json({ message: 'ランキングが見つかりません' } as any);
    return;
  }

  res.json(rankingList);
};
