/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
// File: com/oceanview/servlet/HelpServlet.java
package com.oceanview.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/help")
public class HelpServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null
                && ("admin".equals(session.getAttribute("role")) || "staff".equals(session.getAttribute("role")))) {
            request.getRequestDispatcher("/staffHelp.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/help.jsp").forward(request, response);
        }
    }
}