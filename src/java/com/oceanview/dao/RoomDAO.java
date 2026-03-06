/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// File: com/oceanview/dao/RoomDAO.java
package com.oceanview.dao;

import com.oceanview.model.Room;
import com.oceanview.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    private static RoomDAO instance;
    private Connection connection;

    private RoomDAO() {
    }

    public static RoomDAO getInstance() {
        if (instance == null) {
            instance = new RoomDAO();
        }
        return instance;
    }

    private Connection getConnection() {
        if (connection == null) {
            connection = DatabaseConnection.getInstance().getConnection();
        }
        return connection;
    }

    public List<Room> getAvailableRooms() {
        List<Room> rooms = new ArrayList<>();
        String query = "SELECT * FROM rooms WHERE status = 'available'";

        try (Statement stmt = getConnection().createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                rooms.add(mapRowToRoom(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        String query = "SELECT * FROM rooms";

        try (Statement stmt = getConnection().createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                rooms.add(mapRowToRoom(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    private Room mapRowToRoom(ResultSet rs) throws SQLException {
        Room room = new Room();
        room.setRoomId(rs.getInt("room_id"));
        room.setRoomNumber(rs.getString("room_number"));
        room.setRoomType(rs.getString("room_type"));
        room.setRatePerNight(rs.getDouble("rate_per_night"));
        room.setDescription(rs.getString("description"));
        room.setImagePath(rs.getString("image_path"));
        room.setStatus(rs.getString("status"));
        return room;
    }

    public Room getRoomById(int roomId) {
        String query = "SELECT * FROM rooms WHERE room_id = ?";
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, roomId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomType(rs.getString("room_type"));
                room.setRatePerNight(rs.getDouble("rate_per_night"));
                room.setDescription(rs.getString("description"));
                room.setImagePath(rs.getString("image_path"));
                room.setStatus(rs.getString("status"));
                return room;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getAvailableRoomIdByType(String roomType) {
        String query = "SELECT room_id FROM rooms WHERE room_type = ? AND status = 'available' LIMIT 1";
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, roomType);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("room_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Or better, throw exception or return -1
    }

    public double getRoomRate(String roomType) {
        String query = "SELECT rate_per_night FROM rooms WHERE room_type = ? LIMIT 1";
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, roomType);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble("rate_per_night");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public java.util.Map<String, Double> getRoomRatesMap() {
        java.util.Map<String, Double> rates = new java.util.HashMap<>();
        // Only show room types that have at least one 'available' room
        String query = "SELECT DISTINCT room_type, rate_per_night FROM rooms WHERE status = 'available'";
        try (Statement stmt = getConnection().createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                rates.put(rs.getString("room_type"), rs.getDouble("rate_per_night"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rates;
    }

    public boolean updateRoomStatus(int roomId, String status) {
        String query = "UPDATE rooms SET status = ? WHERE room_id = ?";
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, roomId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
