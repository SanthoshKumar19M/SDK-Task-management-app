const mongoose = require('mongoose');
const Task = require('../models/taskModel');

// Get All Tasks
const getAll = async (req, res) => {
    try {
        const tasks = await Task.find();

        if (!tasks.length) {
            return res.status(404).json({ message: "No tasks found" });
        }

        const formattedTasks = tasks.map(task => ({
            _id: task._id,
            urn: task.urn,
            taskName: task.taskName,
            assignedBy: task.assignedBy,
            assignedTo: task.assignedTo,
            commencementDate: task.commencementDate,
            dueDate: task.dueDate,
            clientName: task.clientName,
            status: task.status
        }));

        res.status(200).json({
            message: "Tasks retrieved successfully",
            totalCount: tasks.length,
            tasks: formattedTasks
        });

    } catch (error) {
        console.error("Error fetching tasks:", error);
        res.status(500).json({ message: "Internal Server Error" });
    }
};

// Create a Task 
const create = async (req, res) => {
    try {
        const newTask = new Task(req.body);

        await newTask.validate();
        await newTask.save();

        res.status(201).json({
            message: "Task created successfully",
            task: newTask
        });
        console.log(newTask);


    } catch (error) {
        console.error("Error creating task:", error);

        if (error.name === "ValidationError") {
            return res.status(400).json({ message: error.message });
        }

        res.status(500).json({ message: "Internal Server Error" });
    }
};

// Update a Task
const update = async (req, res) => {
    try {
        const { id } = req.params;
        const {
            taskName,
            assignedBy,
            assignedTo,
            commencementDate,
            dueDate,
            clientName,
            status,
            taskStatus
        } = req.body;

        if (!id || !mongoose.Types.ObjectId.isValid(id)) {
            return res.status(400).json({ message: "Invalid task ID" });
        }

        const existingTask = await Task.findById(id);
        if (!existingTask) {
            return res.status(404).json({ message: "Task not found" });
        }

        existingTask.taskName = taskName || existingTask.taskName;
        existingTask.assignedBy = assignedBy || existingTask.assignedBy;
        existingTask.assignedTo = assignedTo || existingTask.assignedTo;
        existingTask.commencementDate = commencementDate || existingTask.commencementDate;
        existingTask.dueDate = dueDate || existingTask.dueDate;
        existingTask.clientName = clientName || existingTask.clientName;
        existingTask.status = status !== undefined ? status : existingTask.status;
        existingTask.taskStatus = taskStatus || existingTask.taskStatus;

        const updatedTask = await existingTask.save();

        console.log(updatedTask)
        res.status(200).json({
            message: "Task updated successfully",
            task: updatedTask
        },

        );

    } catch (error) {
        console.error("Error updating task:", error);
        res.status(500).json({ message: "Internal Server Error" });
    }
};

const softDelete = async (req, res) => {
    try {
        const { id } = req.params;

        if (!id || !mongoose.Types.ObjectId.isValid(id)) {
            return res.status(400).json({ message: "Invalid task ID" });
        }

        const task = await Task.findById(id);
        if (!task) {
            return res.status(404).json({ message: "Task not found" });
        }

        task.status = false;
        task.taskStatus = "With-held";
        await task.save();

        res.status(200).json({
            message: "Task moved to With-held",
            task
        });

    } catch (error) {
        console.error("Error deleting task:", error);
        res.status(500).json({ message: "Internal Server Error" });
    }
};


module.exports = {
    create,
    getAll,
    update,
    softDelete
};