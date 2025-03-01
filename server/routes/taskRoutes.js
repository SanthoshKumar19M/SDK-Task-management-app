const express = require('express');
const router = express.Router();
const taskController = require('../controllers/taskController');

router.get('/', taskController.getAll);
router.post('/', taskController.create);
router.post('/:id', taskController.update);
router.patch('/:id', taskController.softDelete);

module.exports = router;
