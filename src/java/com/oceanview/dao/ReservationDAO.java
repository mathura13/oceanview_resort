/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// File: com/oceanview/dao/ReservationDAO.java
package com.oceanview.dao;

import com.oceanview.model.Reservation;
import com.oceanview.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    private static ReservationDAO instance;
    private Connection connection;

    private ReservationDAO() {
    }

    public static ReservationDAO getInstance() {
        if (instance == null) {
            instance = new ReservationDAO();
        }
        return instance;
    }

    private Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                connection = DatabaseConnection.getInstance().getConnection();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public boolean saveReservation(Reservation reservation) throws SQLException {
        String query = "INSERT INTO reservations (reservation_no, guest_name, address, contact_no, " +
                "room_type, room_id, check_in_date, check_out_date, total_nights, total_amount, status, user_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, reservation.getReservationNo());
            pstmt.setString(2, reservation.getGuestName());
            pstmt.setString(3, reservation.getAddress());
            pstmt.setString(4, reservation.getContactNo());
            pstmt.setString(5, reservation.getRoomType());
            pstmt.setInt(6, reservation.getRoomId());
            pstmt.setDate(7, new java.sql.Date(reservation.getCheckInDate().getTime()));
            pstmt.setDate(8, new java.sql.Date(reservation.getCheckOutDate().getTime()));
            pstmt.setInt(9, reservation.getTotalNights());
            pstmt.setDouble(10, reservation.getTotalAmount());
            pstmt.setString(11, reservation.getStatus());
            if (reservation.getUserId() > 0) {
                pstmt.setInt(12, reservation.getUserId());
            } else {
                pstmt.setNull(12, Types.INTEGER);
            }

            return pstmt.executeUpdate() > 0;
        }
    }

    public Reservation getReservation(String reservationNo) {
        String query = "SELECT * FROM reservations WHERE reservation_no = ?";
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, reservationNo);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Reservation reservation = new Reservation();
                reservation.setReservationNo(rs.getString("reservation_no"));
                reservation.setGuestName(rs.getString("guest_name"));
                reservation.setAddress(rs.getString("address"));
                reservation.setContactNo(rs.getString("contact_no"));
                reservation.setRoomType(rs.getString("room_type"));
                reservation.setRoomId(rs.getInt("room_id"));
                reservation.setCheckInDate(rs.getDate("check_in_date"));
                reservation.setCheckOutDate(rs.getDate("check_out_date"));
                reservation.setTotalNights(rs.getInt("total_nights"));
                reservation.setTotalAmount(rs.getDouble("total_amount"));
                reservation.setStatus(rs.getString("status"));
                reservation.setCreatedAt(rs.getTimestamp("created_at"));
                return reservation;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Reservation> getAllReservations() {
        List<Reservation> reservations = new ArrayList<>();
        String query = "SELECT * FROM reservations ORDER BY check_in_date DESC";

        try (Statement stmt = getConnection().createStatement()) {
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                Reservation reservation = new Reservation();
                reservation.setReservationNo(rs.getString("reservation_no"));
                reservation.setGuestName(rs.getString("guest_name"));
                reservation.setAddress(rs.getString("address"));
                reservation.setContactNo(rs.getString("contact_no"));
                reservation.setRoomType(rs.getString("room_type"));
                reservation.setRoomId(rs.getInt("room_id"));
                reservation.setCheckInDate(rs.getDate("check_in_date"));
                reservation.setCheckOutDate(rs.getDate("check_out_date"));
                reservation.setTotalNights(rs.getInt("total_nights"));
                reservation.setTotalAmount(rs.getDouble("total_amount"));
                reservation.setStatus(rs.getString("status"));
                reservation.setCreatedAt(rs.getTimestamp("created_at"));
                reservations.add(reservation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservations;
    }

    public boolean updateReservationStatus(String reservationNo, String status) {
        String query = "UPDATE reservations SET status = ? WHERE reservation_no = ?";
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setString(2, reservationNo);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Reservation> getReservationsByUserId(int userId) {
        List<Reservation> reservations = new ArrayList<>();
        String query = "SELECT * FROM reservations WHERE user_id = ? ORDER BY check_in_date DESC";

        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Reservation reservation = new Reservation();
                reservation.setReservationNo(rs.getString("reservation_no"));
                reservation.setGuestName(rs.getString("guest_name"));
                reservation.setAddress(rs.getString("address"));
                reservation.setContactNo(rs.getString("contact_no"));
                reservation.setRoomType(rs.getString("room_type"));
                reservation.setRoomId(rs.getInt("room_id"));
                reservation.setCheckInDate(rs.getDate("check_in_date"));
                reservation.setCheckOutDate(rs.getDate("check_out_date"));
                reservation.setTotalNights(rs.getInt("total_nights"));
                reservation.setTotalAmount(rs.getDouble("total_amount"));
                reservation.setStatus(rs.getString("status"));
                reservation.setUserId(rs.getInt("user_id"));
                reservation.setCreatedAt(rs.getTimestamp("created_at"));
                reservations.add(reservation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservations;
    }
}
