import { Request } from "express";

// RequestInterface extends the Request interface from express to include additional properties specific to the user session.
export interface RequestInterface extends Request {
  apiKey: string;
  isAnonymous: boolean;
  isAuthenticated: boolean;
}
