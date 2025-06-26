import { pool } from '../config/db';
import {
  Quiz,
  QuizWithLevel,
  QuizDetails,
  Level,
} from '../types/quiz';

/* ---------- 共通 SELECT 句 ---------- */
const BASE_FIELDS = `
  id          AS "questionId",
  quiz        AS "question",
  option1,
  option2,
  option3,
  option4
`;

export const randomList = async (): Promise<Quiz[]> => {
  const { rows } = await pool.query<Quiz>(
    `
      SELECT ${BASE_FIELDS}
      FROM quizzes
      WHERE deleted_at IS NULL
      ORDER BY RANDOM()
      LIMIT 10
    `,
  );
  return rows;
};

export const findById = async (id: number): Promise<Quiz | undefined> => {
  const { rows } = await pool.query<Quiz>(
    `
      SELECT ${BASE_FIELDS}, answer, explanation, level
      FROM quizzes
      WHERE id = $1 AND deleted_at IS NULL
    `,
    [id],
  );
  return rows[0];
};

export const findByLevel = async (
  level: Level,
  levelId: number,
): Promise<QuizWithLevel | undefined> => {
  const { rows } = await pool.query<QuizWithLevel>(
    `
      SELECT ${BASE_FIELDS}, answer, explanation, level
      FROM quizzes
      WHERE level = $1 AND level_id = $2 AND deleted_at IS NULL
    `,
    [level, levelId],
  );
  return rows[0];
};

export const getRandomQuiz = async (): Promise<QuizWithLevel[]> => {
  const { rows } = await pool.query<QuizWithLevel>(
    `
      SELECT ${BASE_FIELDS}, level, explanation, answer
      FROM quizzes
      WHERE deleted_at IS NULL
      ORDER BY RANDOM()
      LIMIT 10
    `,
  );
  return rows;
};

export const getQuizById = async (
  quizId: number,
): Promise<QuizDetails | undefined> => {
  const { rows } = await pool.query<QuizDetails>(
    `
      SELECT ${BASE_FIELDS}, level, explanation
      FROM quizzes
      WHERE id = $1 AND deleted_at IS NULL
    `,
    [quizId],
  );
  return rows[0];
};
