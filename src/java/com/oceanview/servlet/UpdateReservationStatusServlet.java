package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/update-reservation-status")
public class UpdateReservationStatusServlet extends HttpServlet {

    private ReservationDAO reservationDAO;
    private RoomDAO roomDAO;

    @Override
    public void init() {
        reservationDAO = ReservationDAO.getInstance();
        roomDAO = RoomDAO.getInstance();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null ||
                (!"admin".equals(session.getAttribute("role")) && !"staff".equals(session.getAttribute("role")))) {
            response.sendRedirect("staff-login");
            return;
        }

        String reservationNo = request.getParameter("reservationNo");
        String status = request.getParameter("status");

        if (reservationNo != null && status != null) {
            // Update the reservation status
            if (reservationDAO.updateReservationStatus(reservationNo, status)) {
                com.oceanview.model.Reservation res = reservationDAO.getReservation(reservationNo);
                if (res != null) {
                    int roomId = res.getRoomId();

                    if ("cancelled".equalsIgnoreCase(status) || "completed".equalsIgnoreCase(status)) {
                        // Release room back to available
                        roomDAO.updateRoomStatus(roomId, "available");
                    } else if ("active".equalsIgnoreCase(status)) {
                        // Guest checked in, room is now occupied
                        roomDAO.updateRoomStatus(roomId, "occupied");
                    } else if ("confirmed".equalsIgnoreCase(status) || "booked".equalsIgnoreCase(status)) {
                        // Room is locked/booked
                        roomDAO.updateRoomStatus(roomId, "booked");
                    }
                }
            }
        }

        response.sendRedirect("staff-dashboard");
    }
}
