import type { Request, Response } from "express";
import  prisma  from "../config/prisma.js";

export const createStation = async (req: Request, res: Response) => {
  const { stationCode, stationName, city } = req.body;

  const station = await prisma.station.create({
    data: { stationCode,stationName, city },
  });

  res.status(201).json(station);
};

export const getAllStations = async (_req: Request, res: Response) => {
  const stations = await prisma.station.findMany();
  res.json(stations);
};
