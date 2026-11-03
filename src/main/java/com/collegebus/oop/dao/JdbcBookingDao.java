package com.collegebus.oop.dao;

import com.collegebus.oop.exception.DatabaseOperationException;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Direct JDBC Data Access Object demonstrating ACID Transactions and Booking CRUD.
 *
 * Demonstrates:
 * 1. ACID Transaction Management: Uses setAutoCommit(false), commit(), and rollback().
 * 2. Foreign Key References: Connects users, trips, and stops via relational keys.
 * 3. Exception Handling: Structured try-catch-finally ensuring rollback on failure.
 */
public class JdbcBookingDao {

    /**
     * Executes a transactional booking reservation demonstrating Atomicity and Consistency.
     * Either all inserts succeed, or everything is rolled back.
     *
     * @return generated booking ID
     */
    public Long createBookingWithTransaction(String bookingRef, Long tripId, Long userId,
                                             Long pickupStopId, Long dropStopId)
            throws DatabaseOperationException {

        String sqlInsert = "INSERT INTO bookings (booking_reference, trip_id, user_id, pickup_stop_id, drop_stop_id, booking_status) " +
                           "VALUES (?, ?, ?, ?, ?, 'CONFIRMED')";

        Connection conn = null;
        try {
            conn = CollegeBusDBConnection.getConnection();
            // 1. Begin ACID Transaction
            CollegeBusDBConnection.beginTransaction(conn);

            Long generatedId = null;
            try (PreparedStatement pstmt = conn.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setString(1, bookingRef);
                pstmt.setObject(2, tripId);
                pstmt.setObject(3, userId);
                pstmt.setObject(4, pickupStopId);
                pstmt.setObject(5, dropStopId);

                int rows = pstmt.executeUpdate();
                if (rows == 0) {
                    throw new SQLException("Insert failed, 0 rows inserted.");
                }

                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getLong(1);
                    }
                }
            }

            // 2. Commit ACID Transaction
            CollegeBusDBConnection.commitTransaction(conn);
            return generatedId;

        } catch (SQLException ex) {
            // 3. Rollback on any failure to guarantee Atomicity
            CollegeBusDBConnection.rollbackTransaction(conn);
            throw new DatabaseOperationException("Transaction aborted & rolled back: " + ex.getMessage(), sqlInsert, ex);
        } finally {
            // 4. Guaranteed connection release (Try-Catch-Finally)
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ignored) {
                }
            }
        }
    }

    /**
     * Reads all active bookings from the relational table.
     */
    public List<Map<String, Object>> findAllBookings() throws DatabaseOperationException {
        String sql = "SELECT booking_id, booking_reference, booking_status, created_at FROM bookings ORDER BY booking_id DESC";
        List<Map<String, Object>> results = new ArrayList<>();

        try (Connection conn = CollegeBusDBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("bookingId", rs.getLong("booking_id"));
                row.put("bookingRef", rs.getString("booking_reference"));
                row.put("status", rs.getString("booking_status"));
                row.put("createdAt", rs.getTimestamp("created_at"));
                results.add(row);
            }

            return results;

        } catch (SQLException ex) {
            throw new DatabaseOperationException("DBMS Error reading bookings: " + ex.getMessage(), sql, ex);
        }
    }

    /**
     * Deletes a booking record by ID.
     */
    public boolean deleteBooking(Long bookingId) throws DatabaseOperationException {
        String sql = "DELETE FROM bookings WHERE booking_id = ?";

        try (Connection conn = CollegeBusDBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, bookingId);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException ex) {
            throw new DatabaseOperationException("DBMS Error deleting booking ID " + bookingId, sql, ex);
        }
    }
}
