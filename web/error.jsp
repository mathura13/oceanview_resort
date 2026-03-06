<%@ page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Error - Ocean View Resort</title>
        <link rel="stylesheet" href="style.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
        <style>
            .error-container {
                max-width: 600px;
                margin: 100px auto;
                text-align: center;
                padding: 40px;
                background: white;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }

            .error-code {
                font-size: 72px;
                font-weight: 700;
                color: #005a8c;
                margin-bottom: 20px;
            }

            .error-message {
                font-size: 24px;
                color: #333;
                margin-bottom: 30px;
            }

            .btn-home {
                display: inline-block;
                padding: 12px 30px;
                background: #005a8c;
                color: white;
                text-decoration: none;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-home:hover {
                background: #003f5c;
                transform: translateY(-2px);
            }
        </style>
    </head>

    <body style="background-color: #f0f4f8; font-family: 'Inter', sans-serif;">
        <div class="error-container">
            <div class="error-code">Oops!</div>
            <div class="error-message">Something went wrong or the page you're looking for doesn't exist.</div>
            <div
                style="background: #fff3f3; color: #d32f2f; padding: 15px; border-radius: 8px; margin: 20px 0; font-family: monospace; font-size: 14px; text-align: left; border-left: 4px solid #d32f2f;">
                <strong>Error details:</strong><br>
                <%= exception !=null ? exception.getMessage() : "Unknown error or path not found" %>
                    <% if(exception !=null) { %>
                        <pre
                            style="font-size: 10px; margin-top: 10px; opacity: 0.7; max-height: 150px; overflow: auto;"><% 
                    java.io.StringWriter sw = new java.io.StringWriter();
                    exception.printStackTrace(new java.io.PrintWriter(sw));
                    out.println(sw.toString());
                %></pre>
                        <% } %>
            </div>
            <p style="color: #666; margin-bottom: 40px;">Please try again later or return to the home page.</p>
            <a href="login" class="btn-home">Back to Login</a>
        </div>
    </body>

    </html>