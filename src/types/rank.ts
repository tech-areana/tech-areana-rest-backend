export type AllowedColumn =
  | 'hard_clear_num'
  | 'normal_clear_num'
  | 'easy_clear_num';

export interface RankingRow {
  userId: string;
  userName: string;
  clearNum: number;
}

export interface RankingItem extends RankingRow {
  rank: number;
}

export interface RankingList {
  hard: RankingItem[];
  normal: RankingItem[];
  easy: RankingItem[];
}
