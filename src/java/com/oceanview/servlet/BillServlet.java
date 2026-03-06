/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
// File: com/oceanview/servlet/BillServlet.java
package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Reservation;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {

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

        String reservationNo = request.getParameter("reservationNo");
        Reservation reservation = reservationDAO.getReservation(reservationNo);

        if (reservation == null) {
            response.sendRedirect("dashboard");
            return;
        }

        double rate = roomDAO.getRoomRate(reservation.getRoomType());

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Ocean View Resort - Bill</title>");
        out.println("<link rel='stylesheet' type='text/css' href='style.css'>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='bill-container'>");
        out.println("<h1>Ocean View Resort</h1>");
        out.println("<h2>Guest Bill</h2>");
        out.println("<hr>");
        out.println("<p><strong>Reservation No:</strong> " + reservation.getReservationNo() + "</p>");
        out.println("<p><strong>Guest Name:</strong> " + reservation.getGuestName() + "</p>");
        out.println("<p><strong>Room Type:</strong> " + reservation.getRoomType() + "</p>");
        out.println("<p><strong>Check-in Date:</strong> " + reservation.getCheckInDate() + "</p>");
        out.println("<p><strong>Check-out Date:</strong> " + reservation.getCheckOutDate() + "</p>");
        out.println("<p><strong>Number of Nights:</strong> " + reservation.getTotalNights() + "</p>");
        out.println("<hr>");
        out.println("<h3>Charges</h3>");
        out.println("<p>Room Rate per Night: LKR " + String.format("%.2f", rate) + "</p>");
        out.println("<p><strong>Total Amount: LKR " + String.format("%.2f", reservation.getTotalAmount())
                + "</strong></p>");
        out.println("<hr>");
        out.println("<p>Thank you for choosing Ocean View Resort!</p>");
        out.println("<a href='dashboard' class='btn'>Back to Dashboard</a>");
        out.println("<button onclick='window.print()' class='btn'>Print Bill</button>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}