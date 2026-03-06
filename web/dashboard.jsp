<%-- Document : dashboard Created on : Mar 2, 2026, 8:07:02 PM Author : mathu --%>
    <%@ page import="java.util.List" %>
        <%@ page import="java.text.SimpleDateFormat" %>
            <%@ page import="com.oceanview.model.Room" %>
                <%@ page import="com.oceanview.model.Reservation" %>
                    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                        <% SimpleDateFormat dashboardSdf=new SimpleDateFormat("MMM dd, yyyy"); %>
                            <!DOCTYPE html>
                            <html>

                            <head>
                                <title>Ocean View Resort - Dashboard</title>
                                <link rel="stylesheet" type="text/css" href="style.css">
                                <link
                                    href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap"
                                    rel="stylesheet">
                                <style>
                                    body {
                                        font-family: 'Inter', sans-serif;
                                    }
                                </style>
                            </head>

                            <body>
                                <div class="header">
                                    <div class="header-content">
                                        <h1>Ocean View Resort</h1>
                                        <p>Welcome, <%= session.getAttribute("user") %> | <a href="logout"
                                                    class="logout-link">Logout</a></p>
                                    </div>
                                </div>

                                <div class="nav-menu">
                                    <a href="dashboard" class="active">Dashboard</a>
                                    <a href="reservation">New Reservation</a>
                                    <a href="help">Help</a>
                                </div>

                                <div class="main-content">
                                    <% List<Reservation> userReservations = (List<Reservation>)
                                            request.getAttribute("userReservations");
                                            int bookingCount = (userReservations != null) ? userReservations.size() : 0;
                                            %>

                                            <div class="dashboard-controls"
                                                style="margin-bottom: 2rem; display: flex; align-items: center; gap: 1rem;">
                                                <button onclick="toggleBookings()" class="btn-secondary"
                                                    id="toggleBookingsBtn"
                                                    style="padding: 0.8rem 1.5rem; background: #fff; border: 1px solid #2c5364; color: #2c5364; border-radius: 50px; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 0.5rem; transition: all 0.3s ease;">
                                                    <span>📅 My Bookings</span>
                                                    <span
                                                        style="background: #2c5364; color: white; border-radius: 50%; width: 22px; height: 22px; display: flex; align-items: center; justify-content: center; font-size: 0.8rem;">
                                                        <%= bookingCount %>
                                                    </span>
                                                </button>
                                                <a href="reservation" class="btn-primary"
                                                    style="padding: 0.8rem 1.5rem; background: #2c5364; color: white; text-decoration: none; border-radius: 50px; font-weight: 600;">🏨
                                                    Book a New Room</a>
                                            </div>

                                            <div id="bookingsContainer"
                                                style="display: none; opacity: 0; transition: opacity 0.4s ease; margin-bottom: 4rem;">
                                                <% if(bookingCount> 0) { %>
                                                    <div class="my-bookings"
                                                        style="background: white; padding: 2rem; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05);">
                                                        <div
                                                            style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; border-bottom: 2px solid #f1f5f9; padding-bottom: 1rem;">
                                                            <h2 style="margin: 0; color: #0f2027;">Your Reservation
                                                                History</h2>
                                                            <button onclick="toggleBookings()"
                                                                style="background: #f1f5f9; border: none; padding: 0.5rem 1rem; border-radius: 8px; color: #64748b; cursor: pointer; font-weight: 600;">✕
                                                                Close</button>
                                                        </div>
                                                        <div class="bookings-grid"
                                                            style="display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 1.5rem;">
                                                            <% for(Reservation res : userReservations) { String
                                                                dateStr="TBD" ; if (res.getCheckInDate() !=null)
                                                                dateStr=dashboardSdf.format(res.getCheckInDate());
                                                                String status=res.getStatus(); if (status==null)
                                                                status="Pending" ; String color="#10b981" ; if
                                                                ("pending".equalsIgnoreCase(status)) color="#f59e0b" ;
                                                                else if ("cancelled".equalsIgnoreCase(status))
                                                                color="#ef4444" ; %>
                                                                <div class="booking-card"
                                                                    style="background: white; padding: 1.5rem; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); border-top: 5px solid <%= color %>;">
                                                                    <div
                                                                        style="display: flex; justify-content: space-between; margin-bottom: 1rem;">
                                                                        <h4
                                                                            style="margin: 0; color: #0f2027; font-size: 1.1rem;">
                                                                            <%= res.getRoomType() %> Room
                                                                        </h4>
                                                                        <span class="status-badge"
                                                                            style="background: <%= color %>20; color: <%= color %>; padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.7rem; font-weight: 800; text-transform: uppercase;">
                                                                            <%= status %>
                                                                        </span>
                                                                    </div>
                                                                    <div
                                                                        style="color: #64748b; font-size: 0.85rem; line-height: 2;">
                                                                        <div><span style="opacity: 0.7;">Reference
                                                                                ID:</span> <strong>#<%=
                                                                                    res.getReservationNo() %></strong>
                                                                        </div>
                                                                        <div><span style="opacity: 0.7;">Check-in
                                                                                Date:</span> <strong>
                                                                                <%= dateStr %>
                                                                            </strong></div>
                                                                        <div
                                                                            style="margin-top: 0.5rem; font-size: 1.3rem; color: #2c5364; font-weight: 800;">
                                                                            LKR <%= String.format("%,.2f",
                                                                                res.getTotalAmount()) %>
                                                                        </div>
                                                                    </div>
                                                                    <a href="reservation?action=view&reservationNo=<%= res.getReservationNo() %>"
                                                                        style="display: block; margin-top: 1.5rem; color: #2c5364; font-weight: 700; text-decoration: none; font-size: 0.85rem; border-top: 1px solid #f1f5f9; padding-top: 1rem; text-align: right;">View
                                                                        Details &rarr;</a>
                                                                </div>
                                                                <% } %>
                                                        </div>
                                                    </div>
                                                    <% } else { %>
                                                        <div
                                                            style="text-align: center; padding: 4rem; background: #fff; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05);">
                                                            <div style="font-size: 3rem; margin-bottom: 1rem;">🏝️</div>
                                                            <h3 style="color: #0f2027; margin-bottom: 0.5rem;">No
                                                                Bookings Yet</h3>
                                                            <p style="color: #64748b; margin-bottom: 2rem;">Ready for
                                                                your next adventure? Start by exploring our available
                                                                rooms.</p>
                                                            <a href="reservation"
                                                                style="padding: 1rem 2.5rem; background: #2c5364; color: white; text-decoration: none; border-radius: 50px; font-weight: 700; box-shadow: 0 4px 15px rgba(44, 83, 100, 0.3);">Book
                                                                Now</a>
                                                        </div>
                                                        <% } %>
                                                            <hr
                                                                style="border: 0; border-top: 2px solid #e2e8f0; margin: 4rem 0;">
                                            </div>

                                            <h2 style="color: #0f2027; margin-bottom: 2rem;">Available Rooms</h2>
                                            <div class="rooms-grid">
                                                <% List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                                                        if(rooms != null && !rooms.isEmpty()) {
                                                        for(Room room : rooms) {
                                                        %>
                                                        <div class="room-card">
                                                            <img src="<%= room.getImagePath() %>"
                                                                alt="<%= room.getRoomType() %>">
                                                            <div class="room-details">
                                                                <h3>Room <%= room.getRoomNumber() %> - <%=
                                                                            room.getRoomType() %>
                                                                </h3>
                                                                <p>
                                                                    <%= room.getDescription() %>
                                                                </p>
                                                                <p class="room-rate">LKR <%= String.format("%.2f",
                                                                        room.getRatePerNight()) %> per night</p>
                                                                <a href="reservation?roomType=<%= room.getRoomType() %>"
                                                                    class="btn-book">Book Now</a>
                                                            </div>
                                                        </div>
                                                        <% } } else { %>
                                                            <div
                                                                style="grid-column: 1/-1; text-align: center; padding: 3rem; background: #f8fafc; border-radius: 12px;">
                                                                <p style="color: #64748b; font-size: 1.1rem;">All rooms
                                                                    are currently occupied. Please check back later!</p>
                                                            </div>
                                                            <% } %>
                                            </div>
                                </div>

                                <div class="footer">
                                    <p>&copy; 2024 Ocean View Resort. All rights reserved. | Galle, Sri Lanka</p>
                                </div>

                                <script>
                                    function toggleBookings() {
                                        var container = document.getElementById('bookingsContainer');
                                        var btn = document.getElementById('toggleBookingsBtn');
                                        if (!container || !btn) return;
                                        if (container.style.display === 'none' || container.style.display === '') {
                                            container.style.display = 'block';
                                            setTimeout(function () { container.style.opacity = '1'; }, 10);
                                            btn.style.background = '#2c5364';
                                            btn.style.color = '#fff';
                                        } else {
                                            container.style.opacity = '0';
                                            setTimeout(function () { container.style.display = 'none'; }, 400);
                                            btn.style.background = '#fff';
                                            btn.style.color = '#2c5364';
                                        }
                                    }
                                </script>
                            </body>

                            </html>