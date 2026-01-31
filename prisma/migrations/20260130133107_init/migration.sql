-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'CLIENT',
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "Station" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "stationCode" TEXT NOT NULL,
    "stationName" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "Train" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "trainNumber" TEXT NOT NULL,
    "trainName" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "sourceStationId" INTEGER NOT NULL,
    "destinationStationId" INTEGER NOT NULL,
    "runningDays" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Train_sourceStationId_fkey" FOREIGN KEY ("sourceStationId") REFERENCES "Station" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Train_destinationStationId_fkey" FOREIGN KEY ("destinationStationId") REFERENCES "Station" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Route" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "trainId" INTEGER NOT NULL,
    "stationId" INTEGER NOT NULL,
    "arrivalTime" TEXT NOT NULL,
    "departureTime" TEXT NOT NULL,
    "distance" INTEGER NOT NULL,
    CONSTRAINT "Route_trainId_fkey" FOREIGN KEY ("trainId") REFERENCES "Train" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Route_stationId_fkey" FOREIGN KEY ("stationId") REFERENCES "Station" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Coach" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "trainId" INTEGER NOT NULL,
    "classType" TEXT NOT NULL,
    "seatCapacity" INTEGER NOT NULL,
    CONSTRAINT "Coach_trainId_fkey" FOREIGN KEY ("trainId") REFERENCES "Train" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "SeatAvailability" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "trainId" INTEGER NOT NULL,
    "date" DATETIME NOT NULL,
    "classType" TEXT NOT NULL,
    "availableSeats" INTEGER NOT NULL,
    CONSTRAINT "SeatAvailability_trainId_fkey" FOREIGN KEY ("trainId") REFERENCES "Train" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Booking" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "pnr" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "trainId" INTEGER NOT NULL,
    "journeyDate" DATETIME NOT NULL,
    "classType" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'CONFIRMED',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Booking_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Booking_trainId_fkey" FOREIGN KEY ("trainId") REFERENCES "Train" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Passenger" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "bookingId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "gender" TEXT NOT NULL,
    "seatNo" TEXT NOT NULL,
    CONSTRAINT "Passenger_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "Booking" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Station_stationCode_key" ON "Station"("stationCode");

-- CreateIndex
CREATE UNIQUE INDEX "Train_trainNumber_key" ON "Train"("trainNumber");

-- CreateIndex
CREATE UNIQUE INDEX "Booking_pnr_key" ON "Booking"("pnr");
