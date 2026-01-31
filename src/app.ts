import express from "express";
import cors from "cors";
import prisma from "./config/prisma.js";
import authRoutes from "./routes/auth.routes.js";
import { authenticate } from "./middleware/auth.middleware.js";
import stationRoutes from './routes/station.routes.js'
import trainRoutes from "./routes/train.routes.js";


const app = express();

app.use(cors());
app.use(express.json());

app.get("/health", (_req, res) => {
  res.json({ status: "OK", message: "Railway API running 🚆" });
});


app.get("/db-test", async (_req, res) => {
  const users = await prisma.user.findMany();
  res.json(users);
});

app.use("/api/stations", stationRoutes);
app.use("/api/auth", authRoutes);



app.get("/protected", authenticate, (req, res) => {
  res.json({ message: "You are authorized 🎉" });
});


app.use("/api/trains", trainRoutes);


export default app;