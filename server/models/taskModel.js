const mongoose = require('mongoose');

const TaskSchema = new mongoose.Schema(
    {
        urn: { type: String, unique: true, index: true }, 
        taskName: { type: String, required: true, trim: true },
        assignedBy: { type: String, required: true, trim: true },
        assignedTo: { type: String, required: true, trim: true },
        commencementDate: { type: Date, required: true },
        dueDate: { type: Date, required: true },
        clientName: { type: String, required: true, trim: true },
        status: { type: Boolean, default: true }, 
        taskStatus: {
            type: String,
            required: true,
            enum: ["Scheduled", "In Progress", "Completed", "With-held"], 
            default: "Scheduled"
        }
    },
    { timestamps: true } 
);


TaskSchema.pre("save", async function (next) {
    if (!this.urn) {
        const lastTask = await mongoose.model("tasks").findOne().sort({ createdAt: -1 });
        const lastUrn = lastTask ? parseInt(lastTask.urn.replace("TASK", ""), 10) : 0;
        this.urn = `TASK${(lastUrn + 1).toString().padStart(3, '0')}`;
    }
    next();
});

module.exports = mongoose.model("tasks", TaskSchema);
