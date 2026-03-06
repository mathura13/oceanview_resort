/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// File: com/oceanview/pattern/ReservationBuilder.java
package com.oceanview.pattern;

import com.oceanview.model.Reservation;
import java.util.Date;

public class ReservationBuilder {
    private Reservation reservation;

    public ReservationBuilder() {
        reservation = new Reservation();
        reservation.setReservationNo(Reservation.generateReservationNo());
        reservation.setStatus("booked");
    }

    public ReservationBuilder withGuestDetails(String name, String address, String contact) {
        reservation.setGuestName(name);
        reservation.setAddress(address);
        reservation.setContactNo(contact);
        return this;
    }

    public ReservationBuilder withRoomDetails(String roomType, int roomId) {
        reservation.setRoomType(roomType);
        reservation.setRoomId(roomId);
        return this;
    }

    public ReservationBuilder withDates(Date checkIn, Date checkOut) {
        reservation.setCheckInDate(checkIn);
        reservation.setCheckOutDate(checkOut);
        int nights = reservation.calculateNights(checkIn, checkOut);
        reservation.setTotalNights(nights);
        return this;
    }

    public ReservationBuilder withTotalAmount(double amount) {
        reservation.setTotalAmount(amount);
        return this;
    }

    public ReservationBuilder withUserId(int userId) {
        reservation.setUserId(userId);
        return this;
    }

    public Reservation build() {
        // Validate required fields
        if (reservation.getGuestName() == null || reservation.getContactNo() == null) {
            throw new IllegalStateException("Guest details are required");
        }
        if (reservation.getCheckInDate() == null || reservation.getCheckOutDate() == null) {
            throw new IllegalStateException("Check-in and Check-out dates are required");
        }
        return reservation;
    }
}
