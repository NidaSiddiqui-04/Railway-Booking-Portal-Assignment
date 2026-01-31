import { Router } from "express";
import { authenticate } from "../middleware/auth.middleware.js";
import { authorizeAdmin } from "../middleware/admin.middleware.js";
import { createTrain, getAllTrains } from "../controllers/train.controller.js";

const router = Router();

// admin
router.post("/", authenticate, authorizeAdmin, createTrain);

// public
router.get("/", getAllTrains);

export default router;
