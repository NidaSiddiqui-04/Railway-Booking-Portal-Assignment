import type { Request, Response } from "express";
import  prisma  from "../config/prisma.js";

export const createTrain = async (req: Request, res: Response) => {
  const {
    trainNumber,
    trainName,
    sourceStationId,
    destinationStationId,
    runningDays,
  } = req.body;

  const train = await prisma.train.create({
    data: {
      trainNumber,
      trainName,
      sourceStationId,
      destinationStationId,
      runningDays,
    },
  });

  res.status(201).json(train);
};

export const getAllTrains = async (_req: Request, res: Response) => {
  const trains = await prisma.train.findMany({
    include: {
      sourceStation: true,
      destinationStation: true,
    },
  });

  res.json(trains);
};
