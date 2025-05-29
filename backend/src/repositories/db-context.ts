// Import PrismaClient for database access
import { PrismaClient } from "@prisma/client";

// Create a new instance of PrismaClient
const prisma = new PrismaClient();

// Export the PrismaClient instance
export const dbContext = {
  prisma,
};
