import express from 'express';
import { createBooking, cancelBooking, getActiveBookings } from '../controllers/seatBookingController.js';
const seatRouter = express.Router();

seatRouter.route('/bookseat').post(createBooking);
seatRouter.route('/unbookseat').post(cancelBooking);
seatRouter.route('/activebookings').get(getActiveBookings);

export default seatRouter;