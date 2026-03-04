package com.oceanview.servlet;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/staff-login")
public class StaffLoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = UserDAO.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/staffLogin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("DEBUG: Staff Login attempt for user: " + username);

        try {
            User user = userDAO.authenticate(username, password);

            if (user != null && ("staff".equals(user.getRole()) || "admin".equals(user.getRole()))) {
                HttpSession session = request.getSession();
                session.setAttribute("user", username);
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("role", user.getRole());
                session.setAttribute("loggedIn", true);
                System.out.println("DEBUG: Staff login successful for: " + username);
                response.sendRedirect("staff-dashboard");
            } else if (user != null) {
                System.out.println("DEBUG: Guest user " + username + " tried to use staff login.");
                request.setAttribute("error", "Access denied. Guests must use the regular login page.");
                request.getRequestDispatcher("/staffLogin.jsp").forward(request, response);
            } else {
                System.out.println("DEBUG: Staff login failed for user: " + username);
                request.setAttribute("error", "Invalid staff credentials.");
                request.getRequestDispatcher("/staffLogin.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("ERROR: In StaffLoginServlet.doPost: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
}
