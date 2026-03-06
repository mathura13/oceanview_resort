package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.UserDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/staff-dashboard")
public class StaffDashboardServlet extends HttpServlet {

    private ReservationDAO reservationDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        reservationDAO = ReservationDAO.getInstance();
        userDAO = UserDAO.getInstance();
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

        List<Reservation> reservations = reservationDAO.getAllReservations();
        List<User> users = userDAO.getAllUsers();

        request.setAttribute("reservations", reservations);
        request.setAttribute("users", users);

        request.getRequestDispatcher("/staffDashboard.jsp").forward(request, response);
    }
}
