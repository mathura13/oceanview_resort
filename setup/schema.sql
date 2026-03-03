-- Database initialization script for Ocean View Resort
CREATE DATABASE IF NOT EXISTS oceanview_resort;
USE oceanview_resort;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- SHA-256 hashed
    full_name VARCHAR(100),
    role ENUM('guest', 'staff', 'admin') DEFAULT 'guest',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Rooms table
CREATE TABLE IF NOT EXISTS rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    rate_per_night DECIMAL(10, 2) NOT NULL,
    description TEXT,
    image_path VARCHAR(255),
    status ENUM('available', 'occupied', 'maintenance') DEFAULT 'available'
);

-- Reservations table
CREATE TABLE IF NOT EXISTS reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_no VARCHAR(20) UNIQUE NOT NULL,
    guest_name VARCHAR(100) NOT NULL,
    address TEXT,
    contact_no VARCHAR(20) NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    room_id INT,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_nights INT,
    total_amount DECIMAL(10, 2),
    user_id INT,
    status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Initial Data
INSERT INTO users (username, password, full_name, role) 
VALUES ('admin', SHA2('admin123', 256), 'Administrator', 'staff');

INSERT INTO rooms (room_number, room_type, rate_per_night, description, image_path, status)
VALUES 
('101', 'Standard', 150.00, 'Comfortable room with garden view', 'images/standard.jpg', 'available'),
('201', 'Deluxe', 250.00, 'Spacious room with partial sea view', 'images/deluxe.jpg', 'available'),
('301', 'Suite', 450.00, 'Luxury suite with full ocean view', 'images/suite.jpg', 'available');

