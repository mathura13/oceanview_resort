<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%-- Document : login Created on : Mar 2, 2026, 8:04:51 PM Author : mathu --%>


        <!DOCTYPE html>
        <html>

        <head>
            <title>Ocean View Resort - Login</title>
            <link rel="stylesheet" type="text/css" href="style.css">
        </head>

        <body class="login-page">
            <div class="login-container">
                <div class="login-header">
                    <h1>Ocean View Resort</h1>
                    <p>Galle, Sri Lanka</p>
                </div>

                <div class="login-image">
                    <img src="https://www.theanvayabali.com/wp-content/uploads/2025/05/Pool-Beach-Area-1440x960-1-scaled.jpg" alt="Ocean View Resort">
                </div>

                <div class="login-form">
                    <h2>Users Login</h2>

                    <% if(request.getAttribute("error") !=null) { %>
                        <div class="error-message">
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>

                            <% if("success".equals(request.getParameter("signup"))) { %>
                                <div class="success-message"
                                    style="background: #e8f5e9; color: #2e7d32; padding: 0.8rem; border-radius: 10px; margin-bottom: 1.5rem; text-align: center; border-left: 4px solid #2e7d32;">
                                    Registration successful! Please login.
                                </div>
                                <% } %>

                                    <form action="login" method="post">
                                        <div class="form-group">
                                            <label for="username">Username:</label>
                                            <input type="text" id="username" name="username" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="password">Password:</label>
                                            <input type="password" id="password" name="password" required>
                                        </div>

                                        <button type="submit" class="btn-login">Login</button>
                                    </form>

                                    <div class="login-footer">
                                        <p style="color: rgba(255, 255, 255, 0.8);">Don't have an account? <a
                                                href="signup"
                                                style="color: #ffffff; font-weight: 800; text-decoration: underline;">Sign
                                                up here</a></p>
                                        <p style="color: rgba(255, 255, 255, 0.8);">Hotel Staff? <a href="staff-login"
                                                style="color: #ffffff; font-weight: 800; text-decoration: underline;">Staff
                                                Login</a></p>
                                        <p style="color: rgba(255, 255, 255, 0.6); margin-top: 1rem;">&copy; 2024 Ocean
                                            View Resort. All rights reserved.</p>
                                    </div>
                </div>
            </div>
        </body>

        </html>