/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// File: com/oceanview/pattern/RoomFactory.java
package com.oceanview.pattern;

import com.oceanview.model.Room;

public class RoomFactory {
    
    public static Room createRoom(String roomType, String roomNumber, double rate) {
        Room room = new Room();
        room.setRoomNumber(roomNumber);
        room.setRoomType(roomType);
        room.setRatePerNight(rate);
        
        // Set description based on room type
        switch(roomType.toLowerCase()) {
            case "standard":
                room.setDescription("Comfortable room with modern amenities and garden view");
                room.setImagePath("images/standard.jpg");
                break;
            case "deluxe":
                room.setDescription("Spacious room with partial sea view and luxury amenities");
                room.setImagePath("images/deluxe.jpg");
                break;
            case "suite":
                room.setDescription("Luxury suite with full ocean view and private balcony");
                room.setImagePath("images/suite.jpg");
                break;
            default:
                room.setDescription("Standard comfortable room");
                room.setImagePath("images/default.jpg");
        }
        
        return room;
    }
}
