import { prismaClient } from '@prismaClient';

const prisma = new prismaClient();

const createHallBooking = async (req, res) => {
    const { hall, booked_by, agenda, description, date, start_time, end_time } = req.body;
    try {
        const overlappingBookings = await prisma.Hall_Bookings.findMany({
            where: {
                hall,
                date,
            }
        });

        for (const booking of overlappingBookings) {
            if (
                (start_time >= booking.start_time && start_time <= booking.end_time) ||
                (end_time >= booking.start_time && end_time <= booking.end_time)
            ) {
                return res.status(400).json({ error: 'Time slot is already booked' });
            }
        }

        const newBooking = await prisma.Hall_Bookings.create({
            data: {
                hall,
                booked_by,
                agenda,
                description,
                date,
                start_time,
                end_time
            }
        });

        res.status(201).json(newBooking);
    } catch (error) {
        console.error('Error creating hall booking:', error);
        res.status(500).json({ error: 'Error creating hall booking' });
    }
};

const cancelHallBooking = async (req, res) => {
    const { bookingId } = req.body;
    try {
        await prisma.Hall_Bookings.delete({
            where: {
                id: bookingId
            }
        });

        res.status(200).json({ message: 'Hall booking cancelled' });
    } catch (error) {
        console.error('Error cancelling hall booking:', error);
        res.status(500).json({ error: 'Error cancelling hall booking' });
    }
};

const getActiveHallBookings = async (req, res) => {
    try {
        const activeBookings = await prisma.Hall_Bookings.findMany();
        res.status(200).json(activeBookings);
    } catch (error) {
        console.error('Error fetching active hall bookings:', error);
        res.status(500).json({ error: 'Error fetching active hall bookings' });
    }
};

const updateHallBooking = async (req, res) => {
    const { bookingId, booked_by, agenda, description, date, start_time, end_time } = req.body;
    try {
        const updatedBooking = await prisma.Hall_Bookings.update({
            where: {
                id: bookingId
            },
            data: {
                booked_by,
                agenda,
                description,
                date,
                start_time,
                end_time
            }
        });

        res.status(200).json(updatedBooking);
    } catch (error) {
        console.error('Error updating hall booking:', error);
        res.status(500).json({ error: 'Error updating hall booking' });
    }
};

export {
    createHallBooking,
    cancelHallBooking,
    getActiveHallBookings,
    updateHallBooking
};
