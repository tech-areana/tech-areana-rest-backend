import { Router } from 'express';
import auth from '../middlewares/auth';
import * as ctrl from '../controllers/quizzesController';

const router = Router();

router.get('/', ctrl.list);
router.get('/:level/:levelId', ctrl.get);
router.post('/isCorrect', auth, ctrl.answer);
router.get('/random', ctrl.random);

export default router;
