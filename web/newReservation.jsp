<%@ page import="java.util.Map" %>
    <%@ page import="java.text.SimpleDateFormat" %>
        <%@ page import="java.util.Date" %>
            <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Ocean View Resort - New Reservation</title>
                    <link rel="stylesheet" type="text/css" href="style.css">
                    <script>
                        // Room rates passed from server
                        const roomRates = {
                            <%
                            Map < String, Double> rates = (Map < String, Double >) request.getAttribute("roomRates");
                        if (rates != null) {
                            for (Map.Entry < String, Double > entry : rates.entrySet()) {
                            %>
                                    "<%= entry.getKey() %>": <%= entry.getValue() %>,
                            <% 
                                    }
                        }
                            %>
                        };

                        function updateBill() {
                            const roomType = document.getElementById('roomType').value;
                            const checkInStr = document.getElementById('checkInDate').value;
                            const checkOutStr = document.getElementById('checkOutDate').value;
                            const preview = document.getElementById('bill-preview-section');

                            if (!roomType || !checkInStr || !checkOutStr) {
                                preview.style.display = 'none';
                                return;
                            }

                            const checkIn = new Date(checkInStr);
                            const checkOut = new Date(checkOutStr);

                            if (checkOut <= checkIn) {
                                preview.style.display = 'none';
                                return;
                            }

                            const diffTime = Math.abs(checkOut - checkIn);
                            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                            const rate = roomRates[roomType] || 0;
                            const total = diffDays * rate;

                            // Update text content
                            document.getElementById('display-room-type').innerText = roomType;
                            document.getElementById('display-nights').innerText = diffDays;
                            document.getElementById('display-rate').innerText = 'LKR ' + rate.toLocaleString('en-US', { minimumFractionDigits: 2 });
                            document.getElementById('display-total').innerText = 'LKR ' + total.toLocaleString('en-US', { minimumFractionDigits: 2 });

                            preview.style.display = 'block';
                        }

                        function validateForm() {
                            if (!validateDates()) return false;
                            if (!validateContact()) return false;
                            return true;
                        }

                        function validateDates() {
                            const checkIn = new Date(document.getElementById('checkInDate').value);
                            const checkOut = new Date(document.getElementById('checkOutDate').value);
                            const today = new Date();
                            today.setHours(0, 0, 0, 0);

                            if (checkIn < today) {
                                alert('Check-in date cannot be in the past');
                                return false;
                            }

                            if (checkOut <= checkIn) {
                                alert('Check-out date must be after check-in date');
                                return false;
                            }

                            return true;
                        }

                        function validateContact() {
                            const contact = document.getElementById('contactNo').value;
                            const phoneRegex = /^[0-9]{10}$/;

                            if (!phoneRegex.test(contact)) {
                                alert('Please enter a valid 10-digit contact number');
                                return false;
                            }
                            return true;
                        }

                        // Attach listeners after load
                        window.onload = function () {
                            document.getElementById('roomType').addEventListener('change', updateBill);
                            document.getElementById('checkInDate').addEventListener('change', updateBill);
                            document.getElementById('checkOutDate').addEventListener('change', updateBill);

                            // Trigger once on load in case values are already present (e.g. after error)
                            updateBill();
                        }
                    </script>
                </head>

                <body>
                    <div class="header">
                        <div class="header-content">
                            <h1>Ocean View Resort</h1>
                            <p>Welcome, <%= session.getAttribute("user") %> | <a href="logout"
                                        class="logout-link">Logout</a></p>
                        </div>
                    </div>

                    <% String userRole=(String) session.getAttribute("role"); String
                        dashboardLink=("admin".equals(userRole) || "staff" .equals(userRole)) ? "staff-dashboard"
                        : "dashboard" ; %>
                        <div class="nav-menu">
                            <a href="<%= dashboardLink %>">Dashboard</a>
                            <a href="reservation" class="active">New Reservation</a>
                            <a href="help">Help</a>
                        </div>

                        <div class="main-content">
                            <h2>New Reservation</h2>

                            <% if(request.getAttribute("error") !=null) { %>
                                <div class="error-message">
                                    <%= request.getAttribute("error") %>
                                </div>
                                <% } %>

                                    <form action="reservation" method="post" onsubmit="return validateForm()">

                                        <div class="form-section">
                                            <h3>Guest Information</h3>

                                            <div class="form-group">
                                                <label for="guestName">Guest Name:</label>
                                                <% String guestName=request.getParameter("guestName") !=null ?
                                                    request.getParameter("guestName") :
                                                    (request.getAttribute("guestName") !=null ?
                                                    (String)request.getAttribute("guestName") : "" ); %>
                                                    <input type="text" id="guestName" name="guestName" required
                                                        value="<%= guestName %>">
                                            </div>

                                            <div class="form-group">
                                                <label for="address">Address:</label>
                                                <% String address=request.getParameter("address") !=null ?
                                                    request.getParameter("address") : (request.getAttribute("address")
                                                    !=null ? (String)request.getAttribute("address") : "" ); %>
                                                    <textarea id="address" name="address" rows="3"
                                                        required><%= address %></textarea>
                                            </div>

                                            <div class="form-group">
                                                <label for="contactNo">Contact Number:</label>
                                                <% String contactNo=request.getParameter("contactNo") !=null ?
                                                    request.getParameter("contactNo") :
                                                    (request.getAttribute("contactNo") !=null ?
                                                    (String)request.getAttribute("contactNo") : "" ); %>
                                                    <input type="tel" id="contactNo" name="contactNo"
                                                        pattern="[0-9]{10}" title="Please enter 10-digit number"
                                                        required value="<%= contactNo %>">
                                            </div>
                                        </div>

                                        <div class="form-section">
                                            <h3>Booking Details</h3>

                                            <div class="form-group">
                                                <label for="roomType">Room Type:</label>
                                                <% String selectedRoomType=request.getParameter("roomType") !=null ?
                                                    request.getParameter("roomType") : (request.getAttribute("roomType")
                                                    !=null ? (String)request.getAttribute("roomType") : "" ); %>
                                                    <select id="roomType" name="roomType" required>
                                                        <option value="">Select Room Type</option>
                                                        <option value="Standard" <%="Standard" .equals(selectedRoomType)
                                                            ? "selected" : "" %>>Standard - LKR 7,500/night</option>
                                                        <option value="Deluxe" <%="Deluxe" .equals(selectedRoomType)
                                                            ? "selected" : "" %>>Deluxe - LKR 12,500/night</option>
                                                        <option value="Suite" <%="Suite" .equals(selectedRoomType)
                                                            ? "selected" : "" %>>Suite - LKR 20,000/night</option>
                                                    </select>
                                            </div>

                                            <div class="form-row">
                                                <div class="form-group">
                                                    <label for="checkInDate">Check-in Date:</label>
                                                    <% String checkInDate=request.getParameter("checkInDate") !=null ?
                                                        request.getParameter("checkInDate") :
                                                        (request.getAttribute("checkInDate") !=null ?
                                                        (String)request.getAttribute("checkInDate") : "" ); %>
                                                        <input type="date" id="checkInDate" name="checkInDate"
                                                            min="<%= new SimpleDateFormat(" yyyy-MM-dd").format(new
                                                            Date()) %>"
                                                        required value="<%= checkInDate %>">
                                                </div>

                                                <div class="form-group">
                                                    <label for="checkOutDate">Check-out Date:</label>
                                                    <% String checkOutDate=request.getParameter("checkOutDate") !=null ?
                                                        request.getParameter("checkOutDate") :
                                                        (request.getAttribute("checkOutDate") !=null ?
                                                        (String)request.getAttribute("checkOutDate") : "" ); %>
                                                        <input type="date" id="checkOutDate" name="checkOutDate"
                                                            required value="<%= checkOutDate %>">
                                                </div>
                                            </div>

                                            <div class="form-actions"
                                                style="margin-top: 2rem; border-top: 1px solid #eee; padding-top: 2rem;">
                                                <button type="submit" name="action" value="save" class="btn-submit"
                                                    style="width: 100%;">Confirm & Make Reservation</button>
                                            </div>
                                        </div>
                                    </form>

                                    <div id="bill-preview-section" class="bill-preview"
                                        style="display: none; animation: fadeIn 0.5s ease-out;">
                                        <h3>Live Bill Summary</h3>
                                        <table class="bill-table">
                                            <tr>
                                                <td>Room Type:</td>
                                                <td id="display-room-type">-</td>
                                            </tr>
                                            <tr>
                                                <td>Number of Nights:</td>
                                                <td id="display-nights">0</td>
                                            </tr>
                                            <tr>
                                                <td>Rate per Night:</td>
                                                <td id="display-rate">LKR 0.00</td>
                                            </tr>
                                            <tr class="total-row">
                                                <td>Total Amount:</td>
                                                <td id="display-total">LKR 0.00</td>
                                            </tr>
                                        </table>
                                        <p
                                            style="font-size: 0.85rem; color: #666; margin-top: 1rem; font-style: italic;">
                                            *
                                            Final bill will be generated upon confirmation.</p>
                                    </div>
                        </div>

                        <div class="footer">
                            <p>&copy; 2024 Ocean View Resort. All rights reserved. | Galle, Sri Lanka</p>
                        </div>
                </body>

                </html>