/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// File: com/oceanview/util/DatabaseConnection.java
package com.oceanview.util;

import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static DatabaseConnection instance;
    private Connection connection;
    private String url;
    private String username;
    private String password;

    private DatabaseConnection() {
        System.out.println("DEBUG: Initializing DatabaseConnection...");
        try {
            java.util.Properties prop = new java.util.Properties();
            java.io.InputStream input = getClass().getResourceAsStream("/db.properties");
            if (input == null) {
                input = getClass().getClassLoader().getResourceAsStream("db.properties");
            }

            if (input != null) {
                prop.load(input);
                this.url = prop.getProperty("db.url");
                this.username = prop.getProperty("db.username");
                this.password = prop.getProperty("db.password");
                String driver = prop.getProperty("db.driver");
                System.out.println("DEBUG: Loaded properties. URL: " + url + ", Driver: " + driver);

                Class.forName(driver);
                this.connection = DriverManager.getConnection(url, username, password);
                System.out.println("DEBUG: Database connection established successfully.");
            } else {
                System.out.println("DEBUG: CRITICAL ERROR - db.properties NOT FOUND in classpath!");
                // Fallback to defaults if file is missing (for development convenience)
                this.url = "jdbc:mysql://localhost:3306/oceanview_resort";
                this.username = "root";
                this.password = "";
                Class.forName("com.mysql.cj.jdbc.Driver");
                this.connection = DriverManager.getConnection(url, username, password);
            }
        } catch (Exception e) {
            System.out.println("DEBUG: Exception in DatabaseConnection: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static DatabaseConnection getInstance() {
        if (instance == null) {
            synchronized (DatabaseConnection.class) {
                if (instance == null) {
                    instance = new DatabaseConnection();
                }
            }
        }
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }
}