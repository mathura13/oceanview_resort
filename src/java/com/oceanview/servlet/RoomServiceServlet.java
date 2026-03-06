package com.oceanview.servlet;

import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Room;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/rooms/available")
public class RoomServiceServlet extends HttpServlet {

    private RoomDAO roomDAO;

    @Override
    public void init() {
        roomDAO = RoomDAO.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Proper Web Service: Returning JSON data
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        List<Room> availableRooms = roomDAO.getAvailableRooms();

        PrintWriter out = response.getWriter();
        StringBuilder json = new StringBuilder("[");

        for (int i = 0; i < availableRooms.size(); i++) {
            Room r = availableRooms.get(i);
            json.append("{")
                    .append("\"id\": ").append(r.getRoomId()).append(",")
                    .append("\"number\": \"").append(r.getRoomNumber()).append("\",")
                    .append("\"type\": \"").append(r.getRoomType()).append("\",")
                    .append("\"rate\": ").append(r.getRatePerNight())
                    .append("}");
            if (i < availableRooms.size() - 1)
                json.append(",");
        }
        json.append("]");

        out.print(json.toString());
        out.flush();
    }
}
