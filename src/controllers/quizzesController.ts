import { Request, Response } from 'express';
import * as quizzesService from "../services/quizzesService";
import { Level, QuizWithLevel, Quiz } from '../types/quiz';

export const list = async (_req: Request, res: Response<Quiz[]>) => {
  const quizzes = await quizzesService.list();
  res.json(quizzes);
};

export const get = async (
  req: Request<{ level: Level; levelId: string }>,
  res: Response<QuizWithLevel>,
) => {
  const { level, levelId } = req.params;
  const quiz = await quizzesService.getByLevel(level, Number(levelId));
  if (!quiz) {
    res.status(404).json({ message: 'Not found' } as any);
    return;
  }
  res.json(quiz);
};

export const random = async (
  _req: Request,
  res: Response<QuizWithLevel[] | { message: string }>,
): Promise<void> => {
  const quizzes = await quizzesService.getRandomQuiz();

  if (!quizzes.length) {
    res.status(404).json({ message: 'No quiz found' });
    return;
  }

  res.json(quizzes);
};


export const answer = async (req: Request, res: Response) => {
  const { userId, questionLevel, isCorrect } = req.body;

  if (!userId || !['hard', 'normal', 'easy'].includes(questionLevel) || typeof isCorrect !== 'boolean') {
    res.status(400).json({ message: 'Invalid request' });
    return;
  }

  await quizzesService.answer({ userId, questionLevel, isCorrect });
  res.json({ message: '正誤登録完了' });
};
