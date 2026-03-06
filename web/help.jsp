<%-- Document : help Created on : Mar 2, 2026, 8:14:02 PM Author : mathu --%>

    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Ocean View Resort - Help Guide</title>
            <link rel="stylesheet" type="text/css" href="style.css">
        </head>

        <body>
            <div class="header">
                <div class="header-content">
                    <h1>Ocean View Resort</h1>
                    <p>Welcome, <%= session.getAttribute("user") %> | <a href="logout" class="logout-link">Logout</a>
                    </p>
                </div>
            </div>

            <% String userRoleHelp=(String) session.getAttribute("role"); String
                dashboardLinkHelp=("admin".equals(userRoleHelp) || "staff" .equals(userRoleHelp)) ? "staff-dashboard"
                : "dashboard" ; %>
                <div class="nav-menu">
                    <a href="<%= dashboardLinkHelp %>">Dashboard</a>
                    <a href="reservation">New Reservation</a>
                    <a href="help" class="active">Help</a>
                </div>

                <div class="main-content">
                    <h2>Staff Help Guide</h2>

                    <div class="help-container">
                        <div class="help-section">
                            <h3>1. Getting Started</h3>
                            <p>The Ocean View Resort Reservation System is designed to help you manage room bookings
                                efficiently. To access the system:</p>
                            <ul>
                                <li>Use your provided username and password to login</li>
                                <li>Default admin credentials: username: "admin", password: "admin123"</li>
                                <li>Always logout after completing your tasks for security</li>
                            </ul>
                        </div>

                        <div class="help-section">
                            <h3>2. Making a New Reservation</h3>
                            <p>To create a new booking for a guest:</p>
                            <ol>
                                <li>Click on "New Reservation" in the navigation menu</li>
                                <li>Enter guest details:
                                    <ul>
                                        <li>Guest Name - Full name as per ID</li>
                                        <li>Address - Complete address with postal code</li>
                                        <li>Contact Number - 10-digit mobile number</li>
                                    </ul>
                                </li>
                                <li>Select room type from the dropdown (Standard/Deluxe/Suite)</li>
                                <li>Choose check-in and check-out dates</li>
                                <li>Click "Make Reservation" to complete the booking</li>
                            </ol>
                            <p class="note">Note: Check-in date cannot be in the past. Check-out date must be after
                                check-in date.</p>
                        </div>

                        <div class="help-section">
                            <h3>3. Managing Reservations</h3>
                            <p>From the Staff Dashboard, you can manage the full lifecycle of a booking:</p>
                            <ul>
                                <li><strong>Confirm</strong>: Move a 'Pending' or 'Booked' reservation to 'Confirmed'
                                    status.</li>
                                <li><strong>Check-in</strong>: Mark a guest as arrived. This sets the physical room to
                                    'Occupied'.</li>
                                <li><strong>Check-out</strong>: When the guest departs. This automatically resets the
                                    room to 'Available' for new bookings.</li>
                                <li><strong>Cancel</strong>: Immediately releases the room and updates the reservation
                                    status.</li>
                            </ul>
                        </div>

                        <div class="help-section">
                            <h3>4. Calculating Bills</h3>
                            <p>The system automatically calculates the total stay cost:</p>
                            <ul>
                                <li>Number of nights is calculated between check-in and check-out dates</li>
                                <li>Room rates:
                                    <ul>
                                        <li>Standard Room: LKR 7,500 per night</li>
                                        <li>Deluxe Room: LKR 12,500 per night</li>
                                        <li>Suite: LKR 20,000 per night</li>
                                    </ul>
                                </li>
                                <li>Total amount = Number of nights × Room rate</li>
                                <li>View and print bills from the reservation details page</li>
                            </ul>
                        </div>

                        <div class="help-section">
                            <h3>5. System Navigation</h3>
                            <p>Main menu options:</p>
                            <ul>
                                <li><strong>Staff Dashboard:</strong> Manage all reservations and room statuses.</li>
                                <li><strong>View Management Report:</strong> Access real-time occupancy stats and
                                    revenue data.</li>
                                <li><strong>New Reservation:</strong> Create new guest bookings.</li>
                                <li><strong>Help:</strong> Access this guide anytime.</li>
                            </ul>
                        </div>

                        <div class="help-section">
                            <h3>6. Troubleshooting Tips</h3>
                            <p>Common issues and solutions:</p>
                            <ul>
                                <li><strong>Can't login?</strong> Check username and password, ensure Caps Lock is off
                                </li>
                                <li><strong>Date selection error?</strong> Verify dates are in correct format
                                    (YYYY-MM-DD)</li>
                                <li><strong>Booking not saving?</strong> Check all required fields are filled</li>
                                <li><strong>Contact number error?</strong> Enter exactly 10 digits without spaces or
                                    special characters</li>
                            </ul>
                        </div>

                        <div class="help-section">
                            <h3>8. Management Reporting</h3>
                            <p>Use the "View Management Report" button to access business analytics:</p>
                            <ul>
                                <li><strong>Occupancy Load</strong>: Percentage of rooms currently in use.</li>
                                <li><strong>Revenue Tracking</strong>: Total revenue generated by active reservations.
                                </li>
                                <li><strong>Printable Format</strong>: Clean, button-free layout for physical
                                    documentation.</li>
                            </ul>
                        </div>

                        <div class="help-section">
                            <h3>9. Contact Support</h3>
                            <p>If you encounter any technical issues:</p>
                            <ul>
                                <li>Contact IT Support: ext. 1234</li>
                                <li>Email: support@oceanviewresort.com</li>
                                <li>Available 24/7 for emergency assistance</li>
                            </ul>
                        </div>

                        <div class="help-footer">
                            <p>This guide is for staff use only. For guest inquiries, please contact the front desk.</p>
                            <p>Version 1.0 | Last Updated: 2024</p>
                        </div>
                    </div>
                </div>

                <div class="footer">
                    <p>&copy; 2024 Ocean View Resort. All rights reserved. | Galle, Sri Lanka</p>
                </div>
        </body>

        </html>