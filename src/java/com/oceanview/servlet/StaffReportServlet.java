package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/staff-report")
public class StaffReportServlet extends HttpServlet {

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
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (session == null || (!"staff".equals(role) && !"admin".equals(role))) {
            response.sendRedirect("staff-login");
            return;
        }

        List<Room> allRooms = roomDAO.getAllRooms();
        List<Reservation> allReservations = reservationDAO.getAllReservations();

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Management Report - Ocean View Resort</title>");
        out.println(
                "<link href='https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap' rel='stylesheet'>");
        out.println("<link rel='stylesheet' href='style.css'>");
        out.println("<style>");
        out.println("body { background: #f0f4f8; font-family: 'Inter', sans-serif; }");
        out.println(
                ".report-container { background: white; padding: 3rem; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); margin: 2rem auto; max-width: 1100px; }");
        out.println(".stat-card { border-left: 5px solid #2c5364; transition: transform 0.3s; }");
        out.println(".stat-card:hover { transform: translateY(-5px); }");
        out.println(".report-table th { background: #2c5364; color: white; padding: 1rem; text-align: left; }");
        out.println(".report-table td { padding: 1rem; border-bottom: 1px solid #eee; }");
        out.println(
                ".actions-row { margin-top: 3rem; display: flex; gap: 1rem; border-top: 2px solid #eee; padding-top: 2rem; }");
        out.println(
                "@media print { .actions-row, .btn-back, .btn-print, .logout-link { display: none !important; } .report-container { box-shadow: none; padding: 0; margin: 0; } }");
        out.println("</style></head><body>");

        out.println("<div class='report-container'>");
        out.println(
                "<div style='display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;'>");
        out.println("<div><h1 style='margin:0; color: #0f2027;'>Resort Management Report</h1>");
        out.println("<p style='color: #666; margin: 5px 0 0 0;'>Generated on: " + new java.util.Date() + "</p></div>");
        out.println(
                "<img src='https://images.unsplash.com/photo-1581859814481-bfd944e3122f?w=100' style='border-radius: 50%; width: 60px; height: 60px; object-fit: cover;'>");
        out.println("</div>");
        out.println("<hr style='border: 0; border-top: 2px solid #eee; margin-bottom: 2rem;'>");

        // Summary Stats
        int totalRooms = allRooms.size();
        long occupied = allRooms.stream().filter(r -> "occupied".equals(r.getStatus())).count();
        double occupancyRate = totalRooms > 0 ? (double) occupied / totalRooms * 100 : 0;

        out.println(
                "<div class='stats-grid' style='display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1.5rem; margin-bottom: 3rem;'>");
        out.println("<div class='stat-card' style='padding: 1.5rem; background: #f8fafc; border-radius: 12px;'>");
        out.println(
                "<div style='font-size: 0.8rem; color: #666; text-transform: uppercase; letter-spacing: 1px;'>Total Inventory</div>");
        out.println("<div style='font-size: 2rem; font-weight: 800; color: #2c5364;'>" + totalRooms
                + " <span style='font-size: 1rem; font-weight: 400;'>Rooms</span></div></div>");

        out.println(
                "<div class='stat-card' style='padding: 1.5rem; background: #fff5f5; border-radius: 12px; border-left-color: #d32f2f;'>");
        out.println(
                "<div style='font-size: 0.8rem; color: #666; text-transform: uppercase; letter-spacing: 1px;'>Current Occupancy</div>");
        out.println("<div style='font-size: 2rem; font-weight: 800; color: #d32f2f;'>" + occupied
                + " <span style='font-size: 1rem; font-weight: 400;'>Checked-in</span></div></div>");

        out.println(
                "<div class='stat-card' style='padding: 1.5rem; background: #f0fdf4; border-radius: 12px; border-left-color: #166534;'>");
        out.println(
                "<div style='font-size: 0.8rem; color: #666; text-transform: uppercase; letter-spacing: 1px;'>Occupancy Load</div>");
        out.println("<div style='font-size: 2rem; font-weight: 800; color: #166534;'>"
                + String.format("%.1f", occupancyRate) + "%</div></div>");
        out.println("</div>");

        out.println("<h2 style='color: #2c5364; margin-bottom: 1rem;'>Recent Bookings Activity</h2>");
        out.println("<table class='report-table' style='width: 100%; border-collapse: collapse;'>");
        out.println(
                "<thead><tr style='background: #2c5364; color: white;'><th>Res No</th><th>Guest Name</th><th>Check-in</th><th>Revenue</th><th>Status</th></tr></thead><tbody>");

        for (Reservation res : allReservations) {
            out.println("<tr>");
            out.println("<td><strong>#" + res.getReservationNo() + "</strong></td>");
            out.println("<td>" + res.getGuestName() + "</td>");
            out.println("<td>" + res.getCheckInDate() + "</td>");
            out.println("<td><strong>LKR " + String.format("%,.2f", res.getTotalAmount()) + "</strong></td>");
            out.println("<td>" + res.getStatus() + "</td>");
            out.println("</tr>");
        }

        out.println("</tbody></table>");
        out.println("<div class='actions-row'>");
        out.println(
                "<button onclick='window.print()' class='btn-print' style='padding: 1rem 2rem; background: #2c5364; color: white; border: none; border-radius: 8px; font-weight: 600; cursor: pointer;'>Print Full Report</button> ");
        out.println(
                "<a href='staff-dashboard' class='btn-back' style='padding: 1rem 2rem; background: #64748b; color: white; text-decoration: none; border-radius: 8px; font-weight: 600;'>Return to Dashboard</a>");
        out.println("</div></div></body></html>");
    }
}
