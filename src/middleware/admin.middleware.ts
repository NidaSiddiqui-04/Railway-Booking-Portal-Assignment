import  type { Response, NextFunction } from "express";
import { Role } from "@prisma/client";
import type { AuthRequest } from "./auth.middleware.js"; // 👈 import this
 // 👈 import this

export const authorizeAdmin = (
  req: AuthRequest,
  res: Response,
  next: NextFunction
) => {
  if (!req.user || req.user.role !== Role.ADMIN) {
    return res.status(403).json({ message: "Admin access only" });
  }

  next();
};
