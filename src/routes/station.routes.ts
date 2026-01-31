import { Router } from "express";
import { authenticate } from "../middleware/auth.middleware.js";
import { authorizeAdmin } from "../middleware/admin.middleware.js";
import { createStation, getAllStations } from "../controllers/station.controller.js";

const router = Router();

// admin
router.post("/", authenticate, authorizeAdmin, createStation);

// public
router.get("/", getAllStations);

export default router;
