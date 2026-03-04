<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Ocean View Resort - Staff Login</title>
        <link rel="stylesheet" type="text/css" href="style.css">
        <style>
            .staff-login-page {
                background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Inter', sans-serif;
            }

            .login-container {
                background: rgba(255, 255, 255, 0.1);
                padding: 3rem;
                border-radius: 20px;
                box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
                width: 100%;
                max-width: 400px;
                backdrop-filter: blur(15px);
                -webkit-backdrop-filter: blur(15px);
                border: 1px solid rgba(255, 255, 255, 0.18);
                animation: slideUp 0.6s ease-out;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .login-header {
                text-align: center;
                margin-bottom: 2.5rem;
            }

            .login-header h1 {
                color: #ffffff;
                margin: 0;
                font-size: 2rem;
                text-transform: uppercase;
                letter-spacing: 3px;
                font-weight: 900;
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            }

            .login-header p {
                color: rgba(255, 255, 255, 0.8);
                font-weight: 600;
                margin-top: 0.5rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 600;
                color: #ffffff;
            }

            .form-group input {
                width: 100%;
                padding: 1rem;
                background: rgba(255, 255, 255, 0.2);
                border: 1px solid rgba(255, 255, 255, 0.3);
                border-radius: 12px;
                color: #ffffff;
                box-sizing: border-box;
                transition: all 0.3s ease;
            }

            .form-group input::placeholder {
                color: rgba(255, 255, 255, 0.5);
            }

            .form-group input:focus {
                background: rgba(255, 255, 255, 0.25);
                border-color: #ffffff;
                outline: none;
            }

            .btn-staff-login {
                width: 100%;
                padding: 1rem;
                background: #0f2027;
                color: white;
                border: none;
                border-radius: 8px;
                font-weight: 700;
                cursor: pointer;
                transition: background 0.3s;
            }

            .btn-staff-login:hover {
                background: #203a43;
            }

            .error-message {
                background: #ffebee;
                color: #c62828;
                padding: 0.8rem;
                border-radius: 8px;
                margin-bottom: 1.5rem;
                text-align: center;
                font-size: 0.9rem;
            }

            .back-link {
                display: block;
                text-align: center;
                margin-top: 1.5rem;
                color: #2c5364;
                text-decoration: none;
                font-size: 0.9rem;
            }
        </style>
    </head>

    <body class="staff-login-page">
        <div class="login-container">
            <div class="login-header">
                <h1>Staff Secured</h1>
                <p>Hotel Administration Access</p>
            </div>

            <% if(request.getAttribute("error") !=null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                    <form action="staff-login" method="post">
                        <div class="form-group">
                            <label for="username">Staff Identifier:</label>
                            <input type="text" id="username" name="username" required placeholder="Username">
                        </div>

                        <div class="form-group">
                            <label for="password">Security Code:</label>
                            <input type="password" id="password" name="password" required placeholder="Password">
                        </div>

                        <button type="submit" class="btn-staff-login">Authenticate</button>
                    </form>

                    <a href="login" class="back-link"
                        style="color: #ffffff; font-weight: 700; text-decoration: underline;">← Return to User Login</a>
        </div>
    </body>

    </html>