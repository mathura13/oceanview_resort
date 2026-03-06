<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.oceanview.model.Reservation" %>
        <%@ page import="java.text.SimpleDateFormat" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Reservation Details - Ocean View Resort</title>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap"
                    rel="stylesheet">
                <style>
                    :root {
                        --primary-gradient: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
                        --glass-bg: rgba(255, 255, 255, 0.95);
                        --glass-border: rgba(255, 255, 255, 0.3);
                    }

                    body {
                        font-family: 'Inter', sans-serif;
                        background: var(--primary-gradient);
                        min-height: 100vh;
                        margin: 0;
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        padding: 2rem;
                        color: #fff;
                        /* White for content outside cards */
                    }

                    .top-header {
                        width: 100%;
                        max-width: 800px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 1.5rem;
                    }

                    .top-header h1 {
                        margin: 0;
                        font-size: 1.5rem;
                        font-weight: 800;
                        color: #fff;
                    }

                    .nav-menu {
                        width: 100%;
                        max-width: 800px;
                        display: flex;
                        gap: 1.5rem;
                        margin-bottom: 2rem;
                    }

                    .nav-menu a,
                    .logout-link {
                        color: #b0bec5;
                        text-decoration: none;
                        font-weight: 600;
                        font-size: 0.9rem;
                        transition: color 0.3s ease;
                    }

                    .nav-menu a:hover,
                    .logout-link:hover {
                        color: #fff;
                    }

                    .details-card {
                        background: var(--glass-bg);
                        padding: 3rem;
                        border-radius: 20px;
                        border: 1px solid var(--glass-border);
                        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
                        max-width: 800px;
                        width: 100%;
                        color: #333;
                        /* Dark for content inside card */
                    }

                    .details-card .header {
                        display: flex;
                        justify-content: space-between;
                        align-items: flex-start;
                        border-bottom: 2px solid #eee;
                        padding-bottom: 1.5rem;
                        margin-bottom: 2rem;
                    }

                    .header h1 {
                        margin: 0;
                        font-size: 1.8rem;
                        color: #0f2027;
                        font-weight: 800;
                    }

                    .reservation-no {
                        font-size: 1.1rem;
                        color: #666;
                        font-weight: 600;
                    }

                    .grid {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 2rem;
                    }

                    .field-group {
                        margin-bottom: 1.5rem;
                    }

                    .label {
                        font-size: 0.8rem;
                        text-transform: uppercase;
                        color: #888;
                        letter-spacing: 1px;
                        font-weight: 600;
                        margin-bottom: 0.3rem;
                    }

                    .value {
                        font-size: 1.1rem;
                        color: #222;
                        font-weight: 500;
                    }

                    .bill-summary {
                        margin-top: 2rem;
                        padding: 2rem;
                        background: #f8fafc;
                        border-radius: 12px;
                        border-left: 5px solid #2c5364;
                    }

                    .bill-row {
                        display: flex;
                        justify-content: space-between;
                        margin-bottom: 0.5rem;
                        font-size: 1rem;
                    }

                    .total-row {
                        margin-top: 1rem;
                        padding-top: 1rem;
                        border-top: 2px dashed #ddd;
                        font-weight: 800;
                        font-size: 1.3rem;
                        color: #0f2027;
                    }

                    .actions {
                        margin-top: 2.5rem;
                        display: flex;
                        gap: 1rem;
                    }

                    .btn {
                        padding: 0.8rem 1.5rem;
                        border-radius: 8px;
                        text-decoration: none;
                        font-weight: 600;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        text-align: center;
                    }

                    .btn-back {
                        background: #eee;
                        color: #444;
                    }

                    .btn-print {
                        background: #2c5364;
                        color: white;
                        border: none;
                    }

                    .success-alert {
                        background: #e6f4ea;
                        color: #1e7e34;
                        padding: 1rem;
                        border-radius: 8px;
                        border-left: 5px solid #28a745;
                        margin-bottom: 2rem;
                        display: flex;
                        align-items: center;
                        gap: 1rem;
                        animation: slideDown 0.5s ease-out;
                    }

                    @keyframes slideDown {
                        from {
                            transform: translateY(-20px);
                            opacity: 0;
                        }

                        to {
                            transform: translateY(0);
                            opacity: 1;
                        }
                    }

                    @media print {
                        body {
                            background: white !important;
                            padding: 0 !important;
                        }

                        .details-card {
                            box-shadow: none !important;
                            border: none !important;
                            max-width: 100% !important;
                            padding: 0 !important;
                        }

                        .actions {
                            display: none !important;
                        }

                        .btn {
                            display: none !important;
                        }
                    }
                </style>
            </head>

            <body>
                <% Reservation res=(Reservation) request.getAttribute("reservation"); SimpleDateFormat sdf=new
                    SimpleDateFormat("yyyy-MM-dd"); String userRoleView=(String) session.getAttribute("role"); String
                    dashboardLinkView=("admin".equals(userRoleView) || "staff" .equals(userRoleView))
                    ? "staff-dashboard" : "dashboard" ; %>
                    <div class="top-header">
                        <div class="header-content">
                            <h1>Ocean View Resort</h1>
                            <p>Welcome, <%= session.getAttribute("user") %> | <a href="logout"
                                        class="logout-link">Logout</a></p>
                        </div>
                    </div>

                    <div class="nav-menu">
                        <a href="<%= dashboardLinkView %>">Dashboard</a>
                        <a href="reservation">New Reservation</a>
                        <a href="help">Help</a>
                    </div>
                    <div class="details-card">
                        <% if ("true".equals(request.getParameter("success"))) { %>
                            <div class="success-alert">
                                <span style="font-size: 1.5rem;">✅</span>
                                <div>
                                    <strong style="display: block;">Booking Successful!</strong>
                                    <span style="font-size: 0.9rem; opacity: 0.9;">Your room has been locked and a
                                        reservation has been created.</span>
                                </div>
                            </div>
                            <% } %>
                                <div class="header">
                                    <div>
                                        <h1>Booking Confirmation</h1>
                                        <div class="reservation-no">ID: <%= res.getReservationNo() %>
                                        </div>
                                    </div>
                                    <div style="text-align: right;">
                                        <div class="label">Booking Date</div>
                                        <div class="value">
                                            <%= sdf.format(res.getCreatedAt()) %>
                                        </div>
                                    </div>
                                </div>

                                <div class="grid">
                                    <div class="field-group">
                                        <div class="label">Guest Name</div>
                                        <div class="value">
                                            <%= res.getGuestName() %>
                                        </div>
                                    </div>
                                    <div class="field-group">
                                        <div class="label">Contact Number</div>
                                        <div class="value">
                                            <%= res.getContactNo() %>
                                        </div>
                                    </div>
                                    <div class="field-group" style="grid-column: span 2;">
                                        <div class="label">Address</div>
                                        <div class="value">
                                            <%= res.getAddress() %>
                                        </div>
                                    </div>
                                    <div class="field-group">
                                        <div class="label">Room Type</div>
                                        <div class="value">
                                            <%= res.getRoomType() %>
                                        </div>
                                    </div>
                                    <div class="field-group">
                                        <div class="label">Booking Status</div>
                                        <div class="value" style="text-transform: uppercase; color: #2e7d32;">
                                            <%= res.getStatus() %>
                                        </div>
                                    </div>
                                    <div class="field-group">
                                        <div class="label">Check In</div>
                                        <div class="value">
                                            <%= sdf.format(res.getCheckInDate()) %>
                                        </div>
                                    </div>
                                    <div class="field-group">
                                        <div class="label">Check Out</div>
                                        <div class="value">
                                            <%= sdf.format(res.getCheckOutDate()) %>
                                        </div>
                                    </div>
                                </div>

                                <div class="bill-summary">
                                    <h2 style="margin-top: 0; font-size: 1.2rem;">Billing Details</h2>
                                    <div class="bill-row">
                                        <span>Room Charges x <%= res.getTotalNights() %> Nights</span>
                                        <span>LKR <%= String.format("%,.2f", res.getTotalAmount()) %></span>
                                    </div>
                                    <div class="total-row">
                                        <span>Total Bill</span>
                                        <span>LKR <%= String.format("%,.2f", res.getTotalAmount()) %></span>
                                    </div>
                                </div>

                                <div class="actions">
                                    <a href="<%= dashboardLinkView %>" class="btn btn-back">Back to Dashboard</a>
                                    <button onclick="window.print()" class="btn btn-print">Print Bill</button>
                                </div>
                    </div>
            </body>

            </html>