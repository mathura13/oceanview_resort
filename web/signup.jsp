<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Ocean View Resort - Sign Up</title>
        <link rel="stylesheet" type="text/css" href="style.css">
        <style>
            .signup-page {
                background: linear-gradient(135deg, #1a2a6c, #b21f1f, #fdbb2d);
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            }

            .signup-container {
                background: rgba(255, 255, 255, 0.1);
                padding: 3rem;
                border-radius: 20px;
                box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
                width: 100%;
                max-width: 450px;
                backdrop-filter: blur(15px);
                -webkit-backdrop-filter: blur(15px);
                border: 1px solid rgba(255, 255, 255, 0.18);
                animation: fadeIn 0.8s ease-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .signup-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .signup-header h1 {
                color: #ffffff;
                margin: 0;
                font-size: 2.2rem;
                font-weight: 800;
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            .signup-header p {
                color: rgba(255, 255, 255, 0.8);
                margin: 0.5rem 0 0;
                font-weight: 500;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                color: #ffffff;
                font-weight: 600;
            }

            .form-group input {
                width: 100%;
                padding: 1rem;
                background: rgba(255, 255, 255, 0.2);
                border: 1px solid rgba(255, 255, 255, 0.3);
                border-radius: 12px;
                color: #ffffff;
                transition: all 0.3s;
                box-sizing: border-box;
            }

            .form-group input::placeholder {
                color: rgba(255, 255, 255, 0.5);
            }

            .form-group input:focus {
                background: rgba(255, 255, 255, 0.25);
                border-color: #ffffff;
                outline: none;
                box-shadow: 0 0 0 4px rgba(255, 255, 255, 0.1);
            }

            .btn-signup {
                width: 100%;
                padding: 1rem;
                background: #1a2a6c;
                color: white;
                border: none;
                border-radius: 10px;
                font-weight: 700;
                font-size: 1rem;
                cursor: pointer;
                transition: all 0.3s;
                margin-top: 1rem;
            }

            .btn-signup:hover {
                background: #0d1640;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(26, 42, 108, 0.3);
            }

            .error-message {
                background: #ffebee;
                color: #c62828;
                padding: 0.8rem;
                border-radius: 10px;
                margin-bottom: 1.5rem;
                text-align: center;
                font-size: 0.9rem;
                border-left: 4px solid #c62828;
            }

            .signup-footer {
                text-align: center;
                margin-top: 2rem;
                color: #666;
                font-size: 0.9rem;
            }

            .signup-footer a {
                color: #1a2a6c;
                text-decoration: none;
                font-weight: 700;
            }

            .signup-footer a:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <body class="signup-page">
        <div class="signup-container">
            <div class="signup-header">
                <h1>Create Account</h1>
                <p>Join Ocean View Resort</p>
            </div>

            <% if(request.getAttribute("error") !=null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                    <form action="signup" method="post">
                        <div class="form-group">
                            <label for="username">Username:</label>
                            <input type="text" id="username" name="username" required placeholder="Enter username">
                        </div>

                        <div class="form-group">
                            <label for="password">Password:</label>
                            <input type="password" id="password" name="password" required placeholder="Create password">
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password:</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" required
                                placeholder="Confirm password">
                        </div>

                        <button type="submit" class="btn-signup">Sign Up</button>
                    </form>

                    <div class="signup-footer">
                        <p style="color: rgba(255, 255, 255, 0.8);">Already have an account? <a href="login"
                                style="color: #ffffff; font-weight: 800; text-decoration: underline;">Login here</a></p>
                        <p style="color: rgba(255, 255, 255, 0.8);">Hotel Staff? <a href="staff-login"
                                style="color: #ffffff; font-weight: 800; text-decoration: underline;">Staff Login</a>
                        </p>
                        <p style="color: rgba(255, 255, 255, 0.6); margin-top: 1rem;">&copy; 2024 Ocean View Resort.
                            Galle, Sri Lanka</p>
                    </div>
        </div>
    </body>

    </html>