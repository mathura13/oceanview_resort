/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// File: com/oceanview/dao/UserDAO.java
package com.oceanview.dao;

import com.oceanview.model.User;
import com.oceanview.util.DatabaseConnection;
import java.sql.*;

public class UserDAO {

    private static UserDAO instance;
    private Connection connection;

    private UserDAO() {
    }

    public static UserDAO getInstance() {
        if (instance == null) {
            instance = new UserDAO();
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

    public User authenticate(String username, String password) {
        Connection conn = getConnection();
        if (conn == null) {
            System.out.println("DEBUG: UserDAO connection is NULL!");
            return null;
        }
        String query = "SELECT * FROM users WHERE username = ? AND password = SHA2(?, 256)";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            System.out.println("DEBUG: Authenticating user: " + username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
                System.out.println("DEBUG: Authentication success for: " + username + " with role: " + user.getRole());
                return user;
            }
            return null;
        } catch (SQLException e) {
            System.out.println("DEBUG: SQL Exception in authenticate: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public java.util.List<User> getAllUsers() {
        java.util.List<User> users = new java.util.ArrayList<>();
        Connection conn = getConnection();
        if (conn == null)
            return users;

        String query = "SELECT * FROM users ORDER BY username";
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean registerUser(String username, String password) {
        Connection conn = getConnection();
        if (conn == null) {
            return false;
        }
        String query = "INSERT INTO users (username, password, role) VALUES (?, SHA2(?, 256), 'guest')";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("ERROR: SQL Exception in registerUser: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
