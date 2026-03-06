/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
// File: com/oceanview/servlet/ReservationServlet.java
package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Reservation;
import com.oceanview.pattern.ReservationBuilder;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {

    private ReservationDAO reservationDAO;
    private RoomDAO roomDAO;

    @Override
    public void init() {
        reservationDAO = ReservationDAO.getInstance();
        roomDAO = RoomDAO.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedIn") == null) {
            response.sendRedirect("login");
            return;
        }

        // Provide room rates for dynamic calculation
        request.setAttribute("roomRates", roomDAO.getRoomRatesMap());

        String action = request.getParameter("action");

        if ("view".equals(action)) {
            String reservationNo = request.getParameter("reservationNo");
            Reservation reservation = reservationDAO.getReservation(reservationNo);
            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/viewReservation.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/newReservation.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("calculate".equals(action)) {
            calculateBill(request, response);
        } else {
            saveReservation(request, response);
        }
    }

    private void calculateBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String roomType = request.getParameter("roomType");
            String checkInStr = request.getParameter("checkInDate");
            String checkOutStr = request.getParameter("checkOutDate");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date checkIn = sdf.parse(checkInStr);
            Date checkOut = sdf.parse(checkOutStr);

            Reservation temp = new Reservation();
            temp.setCheckInDate(checkIn);
            temp.setCheckOutDate(checkOut);
            int nights = temp.calculateNights();

            double rate = roomDAO.getRoomRate(roomType);
            double total = rate * nights;

            request.setAttribute("roomRates", roomDAO.getRoomRatesMap());
            request.setAttribute("nights", nights);
            request.setAttribute("rate", rate);
            request.setAttribute("total", total);
            request.setAttribute("roomType", roomType);
            request.setAttribute("checkInDate", checkInStr);
            request.setAttribute("checkOutDate", checkOutStr);

            request.getRequestDispatcher("/newReservation.jsp").forward(request, response);

        } catch (ParseException e) {
            request.setAttribute("roomRates", roomDAO.getRoomRatesMap());
            request.setAttribute("error", "Invalid date format");
            request.getRequestDispatcher("/newReservation.jsp").forward(request, response);
        }
    }

    private void saveReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String guestName = request.getParameter("guestName");
            String address = request.getParameter("address");
            String contactNo = request.getParameter("contactNo");
            String roomType = request.getParameter("roomType");
            String checkInStr = request.getParameter("checkInDate");
            String checkOutStr = request.getParameter("checkOutDate");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date checkIn = sdf.parse(checkInStr);
            Date checkOut = sdf.parse(checkOutStr);

            // Calculate total server-side for accuracy and safety
            double rate = roomDAO.getRoomRate(roomType);
            Reservation temp = new Reservation();
            temp.setCheckInDate(checkIn);
            temp.setCheckOutDate(checkOut);
            int nights = temp.calculateNights();
            double totalAmount = rate * nights;

            // Proper Validation: Check dates
            Date now = new Date();
            if (checkIn.before(new Date(now.getTime() - 86400000))) { // Allow today
                request.setAttribute("roomRates", roomDAO.getRoomRatesMap());
                request.setAttribute("error", "Check-in date cannot be in the past.");
                request.getRequestDispatcher("/newReservation.jsp").forward(request, response);
                return;
            }
            if (checkOut.before(checkIn) || checkOut.equals(checkIn)) {
                request.setAttribute("roomRates", roomDAO.getRoomRatesMap());
                request.setAttribute("error", "Check-out date must be after check-in date.");
                request.getRequestDispatcher("/newReservation.jsp").forward(request, response);
                return;
            }

            // Find an available room ID for this type
            int roomId = roomDAO.getAvailableRoomIdByType(roomType);
            if (roomId == 0) {
                request.setAttribute("roomRates", roomDAO.getRoomRatesMap());
                request.setAttribute("error", "No available rooms for the selected type: " + roomType);
                request.getRequestDispatcher("/newReservation.jsp").forward(request, response);
                return;
            }

            // Get userId from session
            HttpSession session = request.getSession(false);
            int userId = (session != null && session.getAttribute("userId") != null)
                    ? (int) session.getAttribute("userId")
                    : 0;

            // Using Builder Pattern
            Reservation reservation = new ReservationBuilder()
                    .withGuestDetails(guestName, address, contactNo)
                    .withRoomDetails(roomType, roomId)
                    .withDates(checkIn, checkOut)
                    .withTotalAmount(totalAmount)
                    .withUserId(userId)
                    .build();

            try {
                if (reservationDAO.saveReservation(reservation)) {
                    // Lock the room status so others can't book it
                    roomDAO.updateRoomStatus(roomId, "booked");
                    response.sendRedirect("reservation?action=view&reservationNo=" + reservation.getReservationNo()
                            + "&success=true");
                } else {
                    request.setAttribute("roomRates", roomDAO.getRoomRatesMap());
                    request.setAttribute("error", "Failed to save reservation: Database rejected the update.");
                    request.getRequestDispatcher("/newReservation.jsp").forward(request, response);
                }
            } catch (java.sql.SQLException e) {
                request.setAttribute("roomRates", roomDAO.getRoomRatesMap());
                request.setAttribute("error", "Database Error: " + e.getMessage());
                // Provide the fix command in the error message for convenience
                if (e.getMessage().contains("Unknown column 'room_type'")) {
                    request.setAttribute("error",
                            "Database Error: Missing 'room_type' column. Run: ALTER TABLE reservations ADD COLUMN room_type VARCHAR(50) NOT NULL;");
                } else if (e.getMessage().contains("user_id")) {
                    request.setAttribute("error",
                            "Database Error: Missing 'user_id' link. Run: ALTER TABLE reservations ADD COLUMN user_id INT;");
                }
                request.getRequestDispatcher("/newReservation.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("roomRates", roomDAO.getRoomRatesMap());
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/newReservation.jsp").forward(request, response);
        }
    }
}