/* ---------- 基本 ---------- */
export type Level = 'hard' | 'normal' | 'easy';

export interface QuizRow {
  id: number;            // DB カラム
  level: Level;
  level_id: number;
  quiz: string;
  option1: string;
  option2: string;
  option3: string;
  option4: string;
  answer: string;
  explanation: string;
}

export interface Quiz {
  questionId: number;
  question: string;
  option1: string;
  option2: string;
  option3: string;
  option4: string;
  answer?: string;
  explanation?: string;
  level?: Level;
}

export interface QuizWithLevel extends Quiz {
  level: Level;
  explanation: string;
  answer: string;
}

export interface QuizDetails extends Quiz {
  level: Level;
  explanation: string;
}
