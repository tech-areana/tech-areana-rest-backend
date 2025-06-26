import * as model from '../models/rankingModel';
import {
  AllowedColumn,
  RankingItem,
  RankingList,
  RankingRow,
} from '../types/rank';

const columns: Record<'hard' | 'normal' | 'easy', AllowedColumn> = {
  hard: 'hard_clear_num',
  normal: 'normal_clear_num',
  easy: 'easy_clear_num',
};

const toRankingItems = (rows: RankingRow[]): RankingItem[] =>
  rows.map((r, i) => ({ ...r, rank: i + 1 }));

export const getRankingList = async (): Promise<RankingList> => {
  const [hard, normal, easy] = await Promise.all(
    (Object.values(columns) as AllowedColumn[]).map((col) =>
      model.getTop10ByColumn(col),
    ),
  );

  return {
    hard: toRankingItems(hard),
    normal: toRankingItems(normal),
    easy: toRankingItems(easy),
  };
};
