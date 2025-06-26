import * as model from '../models/quizzesModel';
import { Level } from '../types/quiz';
import { pool } from '../config/db';

/* ---------- 取得系 ---------- */
export const list = () => model.randomList();
export const get = (id: number) => model.findById(id);
export const getByLevel = (level: Level, levelId: number) =>
  model.findByLevel(level, levelId);
export const getRandomQuiz = () => model.getRandomQuiz();
export const getQuizById = (quizId: number) => model.getQuizById(quizId);

/* ---------- 正誤登録ロジック ---------- */
export const answer = async ({
  userId,
  questionLevel,
  isCorrect,
}: {
  userId: string;
  questionLevel: Level;
  isCorrect: boolean;
}) => {
  const incClear = isCorrect ? 1 : 0;

  const clearCol = `${questionLevel}_clear_num`;
  const correctCol = `${questionLevel}_correct_num`;

  const sql = `
    UPDATE trx_user
    SET ${clearCol}   = ${clearCol} + $1,
        ${correctCol} = ${correctCol} + 1
    WHERE u_id = $2
  `;

  await pool.query(sql, [incClear, userId]);
};
