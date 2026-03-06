# Ocean View Resort Reservation System

A professional, web-based reservation management system for Ocean View Resort, Galle, Sri Lanka. This application provides separate interfaces for Guests and Staff to handle room bookings, user management, and automated billing.

## 🏨 Project Overview
Ocean View Resort is a modern web application designed to replace manual hotel management processes. It utilizes a robust 3-tier architecture and incorporates several industry-standard design patterns to ensure scalability, security, and maintainability.

## ✨ Key Features

### For Guests
*   **Secure Authentication:** User registration and login with encrypted passwords.
*   **Room Browsing:** View available rooms (Standard, Deluxe, Suite) with rates and descriptions.
*   **Interactive Booking:** Easy-to-use reservation form with manual data entry or profile-based booking.
*   **Real-time Billing:** "Live Bill Summary" to see estimated costs based on stay duration before confirming.
*   **Booking History:** View and print previous and current reservation details.

### For Staff & Admin
*   **Secured Staff Portal:** Dedicated login for authorized hotel personnel.
*   **Reservation Management:** View, confirm, cancel, and update status for all guest bookings.
*   **Room Inventory Control:** Update room availability and maintenance status in real-time.
*   **Management Reports:** Access occupancy statistics and financial summaries.
*   **Staff Help Section:** Integrated guidelines for system operation.

## 🛠️ Technology Stack
*   **Frontend:** HTML5, Modern CSS (Glassmorphism design), JavaScript.
*   **Backend:** Java Servlets, JSP (JavaServer Pages).
*   **Database:** MySQL 8.0+.
*   **Build Tool:** Apache Ant (NetBeans project structure).
*   **Architecture:** MVC (Model-View-Controller) Pattern.

## 🏗️ Design Patterns Implemented
The system strictly follows 17 software design patterns, with significant implementations of:
*   **Singleton Pattern:** Used in `DatabaseConnection` and all `DAO` classes for efficient resource management.
*   **Factory Pattern:** Implemented in `RoomFactory` for dynamic room object creation.
*   **Builder Pattern:** Utilized in `ReservationBuilder` for clean, readable construction of complex reservation objects.

## 🚀 Setup Instructions

### 1. Database Configuration
1.  Open your MySQL Workbench or command line.
2.  Import the SQL script located at `setup/schema.sql`.
3.  Ensure the `db.properties` file in `src/java/` matches your local MySQL credentials:
    ```properties
    db.url=jdbc:mysql://localhost:3306/oceanview_resort
    db.user=your_username
    db.password=your_password
    ```

### 2. Project Execution (NetBeans)
1.  Open NetBeans IDE.
2.  Go to **File > Open Project** and select the `oceanview_resort` folder.
3.  Right-click the project and select **Run**.
4.  The application will deploy to your local server (Tomcat/GlassFish) and open in your default browser.

---
*Developed as part of the Advanced Software Engineering assessment.*
