/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
// File: com/oceanview/servlet/LoginServlet.java
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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = UserDAO.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("DEBUG: Login attempt for user: " + username);

        try {
            User user = userDAO.authenticate(username, password);
            if (user != null && "guest".equals(user.getRole())) {
                HttpSession session = request.getSession();
                session.setAttribute("user", username);
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("role", user.getRole());
                session.setAttribute("loggedIn", true);
                System.out.println("DEBUG: Login successful for guest: " + username);
                response.sendRedirect("dashboard");
            } else if (user != null && ("admin".equals(user.getRole()) || "staff".equals(user.getRole()))) {
                System.out.println("DEBUG: Staff user " + username + " tried to use guest login.");
                request.setAttribute("error", "Staff must use the Staff Login page.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            } else {
                System.out.println("DEBUG: Login failed for user: " + username);
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("ERROR: In LoginServlet.doPost: " + e.getMessage());
            e.printStackTrace();
            throw e; // Rethrow to let error.jsp handle it, but now with a log
        }
    }
}