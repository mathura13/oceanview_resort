package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/view-reservation")
public class ViewReservationServlet extends HttpServlet {

    private ReservationDAO reservationDAO;

    @Override
    public void init() {
        reservationDAO = ReservationDAO.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null ||
                (!"admin".equals(session.getAttribute("role")) && !"staff".equals(session.getAttribute("role")))) {
            response.sendRedirect("staff-login");
            return;
        }

        String reservationNo = request.getParameter("id");
        if (reservationNo != null && !reservationNo.isEmpty()) {
            Reservation reservation = reservationDAO.getReservation(reservationNo);
            if (reservation != null) {
                request.setAttribute("reservation", reservation);
                request.getRequestDispatcher("/viewReservation.jsp").forward(request, response);
                return;
            }
        }

        response.sendRedirect("staff-dashboard?error=Reservation not found");
    }
}
