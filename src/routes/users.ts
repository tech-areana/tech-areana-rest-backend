import { Router } from 'express';
import auth from '../middlewares/auth';
import * as ctrl from '../controllers/usersController';

const router = Router();

router.get('/:id',  auth, ctrl.me);
router.put('/:id',  auth, ctrl.updateMe);

export default router;
