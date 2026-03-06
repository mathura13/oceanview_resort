/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
// File: com/oceanview/servlet/DashboardServlet.java
package com.oceanview.servlet;

import com.oceanview.dao.RoomDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Room;
import com.oceanview.model.Reservation;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private RoomDAO roomDAO;
    private ReservationDAO reservationDAO;

    @Override
    public void init() {
        roomDAO = RoomDAO.getInstance();
        reservationDAO = ReservationDAO.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedIn") == null) {
            response.sendRedirect("login");
            return;
        }

        Object userIdObj = session.getAttribute("userId");
        int userId = (userIdObj != null) ? (int) userIdObj : 0;

        List<Room> availableRooms = roomDAO.getAvailableRooms();
        List<Reservation> userReservations = null;

        if (userId > 0) {
            try {
                userReservations = reservationDAO.getReservationsByUserId(userId);
            } catch (Exception e) {
                System.out.println("DEBUG: Error fetching user reservations: " + e.getMessage());
                // Non-critical error, can still show available rooms
            }
        }

        request.setAttribute("rooms", availableRooms);
        request.setAttribute("userReservations", userReservations);
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}