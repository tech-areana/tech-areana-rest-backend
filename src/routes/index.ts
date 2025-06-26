import { Router } from 'express';

/* 子ルーターをすべて ES Modules で import する */
import authRouter      from './auth';
import usersRouter     from './users';
import quizzesRouter   from './quizzes';
import rankingsRouter  from './rankings';

const router = Router();

/* ---------- mount ---------- */
router.use('/api/auth',     authRouter);
router.use('/api/users',    usersRouter);
router.use('/api/questions',  quizzesRouter);   
router.use('/api/rankings', rankingsRouter);

export default router;
