import { prismaClient } from '@prismaClient'

const prisma = new prismaClient();

const createBooking = async (req, res) => {
    const { seatId, userId } = req.body;
    try {
        const seat = await prisma.Seat.findUnique({
            where: {
                id: seatId,
            }
        })
        if (seat.is_booked) {
            return res.status(400).json({ error: 'Seat already booked' });
        }
        const activeBooking = await prisma.Active_Bookings.findUnique({
            where: {
                userId: userId
            }
        });
        if (activeBooking) {
            return res.status(400).json({ error: 'User already has an active booking' });
        }
        const booking = await prisma.Active_Bookings.create({
            data: {
                seatId: seatId,
                userId: userId
            }
        });

        await prisma.Seat.update({
            where: {
                id: booking.seatId
            },
            data: {
                is_booked: true
            }
        });
        res.status(201).json(booking);
    } catch (error) {
        res.status(500).json({ error: 'Error creating booking' });
    }
};

const cancelBooking = async (req, res) => {
    const { bookingId } = req.body;
    try {
        const booking = await prisma.Active_Bookings.delete({
            where: {
                id: bookingId
            }
        });

        await prisma.Seat.update({
            where: {
                id: booking.seatId
            },
            data: {
                is_booked: false
            }
        });

        await prisma.Past_Bookings.create({
            data: {
                seatId: booking.seatId,
                userId: booking.userId,
                seat_booked_at: booking.created_at
            }
        });

        res.status(200).json({ message: 'Booking cancelled' });
    } catch (error) {
        res.status(500).json({ error: 'Error cancelling booking' });
    }
}

const getActiveBookings = async (req, res) => {
    try {
        const activeBookings = await prisma.Active_Bookings.findMany();
        res.status(200).json(activeBookings);
    } catch (error) {
        res.status(500).json({ error: 'Error fetching active bookings' });
    }
}

export {
    createBooking,
    cancelBooking,
    getActiveBookings
}