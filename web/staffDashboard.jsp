<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.oceanview.model.Reservation" %>
            <%@ page import="com.oceanview.model.User" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Ocean View Resort - Staff Dashboard</title>
                    <link rel="stylesheet" type="text/css" href="style.css">
                    <style>
                        .staff-dashboard {
                            padding: 2rem;
                            max-width: 1200px;
                            margin: 0 auto;
                            font-family: 'Inter', sans-serif;
                        }

                        .header-section {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 2rem;
                            padding-bottom: 1rem;
                            border-bottom: 2px solid #eee;
                        }

                        .header-section h1 {
                            color: #0f2027;
                            margin: 0;
                        }

                        .logout-btn {
                            padding: 0.6rem 1.2rem;
                            background: #b21f1f;
                            color: white;
                            text-decoration: none;
                            border-radius: 5px;
                            font-weight: 600;
                        }

                        .dashboard-grid {
                            display: grid;
                            grid-template-columns: 1fr;
                            gap: 2rem;
                        }

                        .section-card {
                            background: white;
                            padding: 1.5rem;
                            border-radius: 12px;
                            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                            border: 1px solid #eee;
                        }

                        .section-card h2 {
                            margin-top: 0;
                            color: #2c5364;
                            font-size: 1.4rem;
                            margin-bottom: 1rem;
                        }

                        table {
                            width: 100%;
                            border-collapse: collapse;
                            margin-top: 1rem;
                        }

                        th,
                        td {
                            text-align: left;
                            padding: 1rem;
                            border-bottom: 1px solid #eee;
                        }

                        th {
                            background: #f8f9fa;
                            color: #666;
                            font-weight: 600;
                            text-transform: uppercase;
                            font-size: 0.8rem;
                        }

                        .status-badge {
                            padding: 0.3rem 0.6rem;
                            border-radius: 20px;
                            font-size: 0.8rem;
                            font-weight: 700;
                            text-transform: uppercase;
                        }

                        .status-confirmed {
                            background: #e8f5e9;
                            color: #2e7d32;
                        }

                        .status-pending {
                            background: #fff3e0;
                            color: #ef6c00;
                        }

                        .role-badge {
                            padding: 0.2rem 0.5rem;
                            border-radius: 4px;
                            font-size: 0.75rem;
                            font-weight: 600;
                        }

                        .role-staff {
                            background: #e3f2fd;
                            color: #1565c0;
                        }

                        .role-guest {
                            background: #f5f5f5;
                            background: #f3e5f5;
                            color: #7b1fa2;
                        }

                        .status-badge {
                            padding: 0.4rem 0.8rem;
                            border-radius: 20px;
                            font-size: 0.8rem;
                            font-weight: 600;
                            text-transform: capitalize;
                        }

                        .status-pending,
                        .status-booked {
                            background: #fff3e0;
                            color: #ef6c00;
                        }

                        .status-confirmed {
                            background: #e8f5e9;
                            color: #2e7d32;
                        }

                        .status-active {
                            background: #e3f2fd;
                            color: #1565c0;
                        }

                        .status-completed {
                            background: #f5f5f5;
                            color: #616161;
                        }

                        .status-cancelled {
                            background: #ffebee;
                            color: #c62828;
                        }

                        .action-btn {
                            border: none;
                            padding: 0.4rem 0.6rem;
                            border-radius: 4px;
                            cursor: pointer;
                            font-weight: bold;
                            transition: all 0.2s;
                            color: white;
                            font-size: 0.9rem;
                        }

                        .btn-confirm {
                            background-color: #2e7d32;
                        }

                        .btn-confirm:hover {
                            background-color: #1b5e20;
                            transform: scale(1.1);
                        }

                        .btn-cancel {
                            background-color: #d32f2f;
                        }

                        .btn-cancel:hover {
                            background-color: #b71c1c;
                            transform: scale(1.1);
                        }
                    </style>
                </head>

                <body class="dashboard-page">
                    <div class="staff-dashboard">
                        <div class="header-section">
                            <h1>Staff Dashboard</h1>
                            <div style="display: flex; gap: 1rem;">
                                <a href="staff-report" class="action-btn" style="background: #ef6c00;">View Management
                                    Report</a>
                                <a href="reservation" class="action-btn" style="background: #2c5364;">Add Walk-in
                                    Reservation</a>
                                <a href="help" class="action-btn" style="background: #2b5876;">System Help</a>
                                <a href="logout" class="logout-btn">Sign Out</a>
                            </div>
                        </div>
                        <p>Logged in as: <strong>
                                <%= session.getAttribute("user") %>
                            </strong></p>


                        <div class="dashboard-grid">
                            <div class="section-card">
                                <h2>All Reservations</h2>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Res No</th>
                                            <th>Guest Name</th>
                                            <th>Room Type</th>
                                            <th>Check In</th>
                                            <th>Check Out</th>
                                            <th>Amount</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List<Reservation> reservations = (List<Reservation>)
                                                request.getAttribute("reservations");
                                                if (reservations != null && !reservations.isEmpty()) {
                                                for (Reservation res : reservations) {
                                                %>
                                                <tr>
                                                    <td><strong>
                                                            <%= res.getReservationNo() %>
                                                        </strong></td>
                                                    <td>
                                                        <%= res.getGuestName() %>
                                                    </td>
                                                    <td>
                                                        <%= res.getRoomType() %>
                                                    </td>
                                                    <td>
                                                        <%= res.getCheckInDate() %>
                                                    </td>
                                                    <td>
                                                        <%= res.getCheckOutDate() %>
                                                    </td>
                                                    <td>$<%= String.format("%.2f", res.getTotalAmount()) %>
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="status-badge status-<%= res.getStatus().toLowerCase() %>">
                                                            <%= res.getStatus() %>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div
                                                            style="display: flex; flex-direction: column; gap: 0.3rem;">
                                                            <a href="view-reservation?id=<%= res.getReservationNo() %>"
                                                                class="action-btn"
                                                                style="background: #2c5364; padding: 0.3rem 0.6rem; font-size: 0.75rem; text-align: center;">View
                                                                Details</a>

                                                            <% String status=res.getStatus().toLowerCase(); %>
                                                                <div
                                                                    style="display: flex; gap: 0.3rem; flex-wrap: wrap;">
                                                                    <form action="update-reservation-status"
                                                                        method="POST"
                                                                        style="display:inline; flex: 1; min-width: 80px;">
                                                                        <input type="hidden" name="reservationNo"
                                                                            value="<%= res.getReservationNo() %>">

                                                                        <% if ("booked".equals(status) || "pending"
                                                                            .equals(status)) { %>
                                                                            <input type="hidden" name="status"
                                                                                value="confirmed">
                                                                            <button type="submit" class="action-btn"
                                                                                style="background: #2e7d32; padding: 0.3rem 0.6rem; font-size: 0.75rem; width: 100%;">Confirm</button>
                                                                            <% } else if ("confirmed".equals(status)) {
                                                                                %>
                                                                                <input type="hidden" name="status"
                                                                                    value="active">
                                                                                <button type="submit" class="action-btn"
                                                                                    style="background: #1565c0; padding: 0.3rem 0.6rem; font-size: 0.75rem; width: 100%;">Check-in</button>
                                                                                <% } else if ("active".equals(status)) {
                                                                                    %>
                                                                                    <input type="hidden" name="status"
                                                                                        value="completed">
                                                                                    <button type="submit"
                                                                                        class="action-btn"
                                                                                        style="background: #2c5364; padding: 0.3rem 0.6rem; font-size: 0.75rem; width: 100%;">Check-out</button>
                                                                                    <% } %>
                                                                    </form>

                                                                    <% if (!"cancelled".equals(status) &&
                                                                        !"completed".equals(status)) { %>
                                                                        <form action="update-reservation-status"
                                                                            method="POST"
                                                                            style="display:inline; flex: 1; min-width: 80px;">
                                                                            <input type="hidden" name="reservationNo"
                                                                                value="<%= res.getReservationNo() %>">
                                                                            <input type="hidden" name="status"
                                                                                value="cancelled">
                                                                            <button type="submit" class="action-btn"
                                                                                style="background: #c62828; padding: 0.3rem 0.6rem; font-size: 0.75rem; width: 100%;">Cancel</button>
                                                                        </form>
                                                                        <% } %>
                                                                </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <% } } else { %>
                                                    <tr>
                                                        <td colspan="8">No reservations found.</td>
                                                    </tr>
                                                    <% } %>
                                    </tbody>
                                </table>
                            </div>

                            <div class="section-card">
                                <h2>Registered Users</h2>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>User ID</th>
                                            <th>Username</th>
                                            <th>Role</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List<User> users = (List<User>) request.getAttribute("users");
                                                if (users != null && !users.isEmpty()) {
                                                for (User u : users) {
                                                %>
                                                <tr>
                                                    <td>#<%= u.getUserId() %>
                                                    </td>
                                                    <td>
                                                        <%= u.getUsername() %>
                                                    </td>
                                                    <td>
                                                        <span class="role-badge role-<%= u.getRole() %>">
                                                            <%= u.getRole().toUpperCase() %>
                                                        </span>
                                                    </td>
                                                </tr>
                                                <% } } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </body>

                </html>