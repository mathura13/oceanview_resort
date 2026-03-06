<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Staff Help Guide - Ocean View Resort</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            }

            body {
                font-family: 'Inter', sans-serif;
                background: #f4f7f6;
                margin: 0;
                color: #333;
                line-height: 1.6;
            }

            .help-container {
                max-width: 900px;
                margin: 3rem auto;
                background: white;
                padding: 3rem;
                border-radius: 12px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            }

            h1 {
                color: #0f2027;
                font-weight: 800;
                border-bottom: 3px solid #eee;
                padding-bottom: 1rem;
                margin-bottom: 2rem;
            }

            h2 {
                color: #2c5364;
                margin-top: 2rem;
            }

            .section {
                margin-bottom: 2rem;
                background: #f8fafc;
                padding: 1.5rem;
                border-radius: 8px;
                border-left: 4px solid #2c5364;
            }

            ul {
                padding-left: 1.5rem;
            }

            li {
                margin-bottom: 0.8rem;
            }

            .tip {
                background: #e1f5fe;
                padding: 1rem;
                border-radius: 6px;
                font-weight: 600;
                color: #01579b;
                margin-top: 2rem;
            }

            .btn-back {
                display: inline-block;
                margin-top: 2rem;
                padding: 0.8rem 1.5rem;
                background: #2c5364;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-weight: 600;
            }
        </style>
    </head>

    <body>
        <div class="help-container">
            <h1>Ocean View System: Staff Guide</h1>

            <p>Welcome to the Ocean View Resort Reservation System. This guide will help you manage hotel bookings
                efficiently.</p>

            <div class="section">
                <h2>1. Managing Reservations & Lifecycle</h2>
                <ul>
                    <li><strong>Confirming</strong>: When a new guest makes a reservation, it appears as "Pending" or
                        "Booked". Click "Confirm" to secure their stay.</li>
                    <li><strong>Check-in</strong>: When the guest arrives, click "Check-in". This sets the room to
                        **"Occupied"** in the system database.</li>
                    <li><strong>Check-out</strong>: When the guest departs, click "Check-out". This automatically
                        **RELEASES** the room, setting it back to "Available" for new guests.</li>
                    <li><strong>Cancellations</strong>: If a guest requests a cancellation, use the "Cancel" button.
                        This immediately releases the room.</li>
                </ul>
            </div>

            <div class="section">
                <h2>2. Walk-in Reservations</h2>
                <ul>
                    <li>To add a reservation for a guest standing at the counter, click the <strong>"Add Walk-in
                            Reservation"</strong> button on the dashboard.</li>
                    <li>Fill out all details including guest address, contact, and check-out dates to calculate the
                        final bill.</li>
                </ul>
            </div>

            <div class="section">
                <h2>3. Management Reports</h2>
                <ul>
                    <li>Access real-time analytics by clicking the <strong>"View Management Report"</strong> button on
                        the dashboard.</li>
                    <li>The report provides your current **Occupancy Load %**, a list of checked-in guests, and total
                        revenue tracking.</li>
                    <li>Click <strong>"Print Full Report"</strong> for a clean, professional paper record (navigation
                        buttons will be hidden automatically).</li>
                </ul>
            </div>

            <div class="section">
                <h2>4. Billing & Receipts</h2>
                <ul>
                    <li>To generate a guest bill, go to the reservation's <strong>"View Details"</strong> page.</li>
                    <li>Click the <strong>"Print Bill"</strong> button. This will format the receipt perfectly for a
                        printer.</li>
                </ul>
            </div>

            <div class="section">
                <h2>4. Security</h2>
                <ul>
                    <li>Always sign out of your account when leaving the desk.</li>
                    <li>Do not share your admin password. The system tracks actions based on the logged-in user.</li>
                </ul>
            </div>

            <div class="tip">
                💡 Need more assistance? Contact the IT administrator or refer to the developer documentation.
            </div>

            <a href="staff-dashboard" class="btn-back">Return to Dashboard</a>
        </div>
    </body>

    </html>