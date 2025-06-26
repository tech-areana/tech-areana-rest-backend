import { Router } from 'express';
import auth from '../middlewares/auth';
import * as ctrl from '../controllers/rankingsController';

const router = Router();

router.get('/', auth, ctrl.getRankingList);

export default router;
