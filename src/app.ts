import express from "express";
import cors from "cors";
import prisma from "./config/prisma.js";


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

export default app;