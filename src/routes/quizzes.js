const router = require('express').Router();
const auth = require('../middlewares/auth');
const ctrl = require('../controllers/quizzesController');

router.get('/',           ctrl.list);
router.get('/:level/:levelId',   ctrl.get);      
router.post('/isCorrect', auth, ctrl.answer);
router.get('/random', ctrl.random);

module.exports = router;
