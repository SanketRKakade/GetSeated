import express from 'express';
import { createHallBooking, cancelHallBooking, getActiveHallBookings, updateHallBooking } from '../controllers/hallController.js';
import jwtVerify from "../middlewares/authMiddleware.js";

const hallRouter = express.Router();

hallRouter.route('/bookhall').post(jwtVerify, createHallBooking);
hallRouter.route('/unbookhall').post(jwtVerify, cancelHallBooking);
hallRouter.route('/activehallbookings').get(jwtVerify, getActiveHallBookings);
hallRouter.route('/updatehallbooking').put(jwtVerify, updateHallBooking);

export default hallRouter;
