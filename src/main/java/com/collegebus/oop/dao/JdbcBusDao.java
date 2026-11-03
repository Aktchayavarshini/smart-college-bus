package com.collegebus.oop.dao;

import com.collegebus.oop.exception.DatabaseOperationException;
import com.collegebus.oop.interfaces.DatabaseOperations;
import com.collegebus.oop.model.AirConditionedBus;
import com.collegebus.oop.model.CollegeBus;
import com.collegebus.oop.model.StandardCollegeBus;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Direct JDBC Data Access Object (DAO) for the 'buses' relational table.
 *
 * Demonstrates:
 * 1. Interface Implementation: Implements DatabaseOperations<CollegeBus, Long>.
 * 2. SQL PreparedStatements: Uses parameterized SQL to eliminate SQL Injection risks.
 * 3. Complete CRUD: Implements Create, Read, Update, and Delete operations.
 * 4. OOP & DBMS Integration: Maps relational table rows into polymorphic OOP domain models
 *    (instantiating AirConditionedBus vs StandardCollegeBus based on bus_type column).
 * 5. Resource Management: Employs try-with-resources to guarantee Connection, PreparedStatement,
 *    and ResultSet closure (Try-Catch-Finally).
 */
public class JdbcBusDao implements DatabaseOperations<CollegeBus, Long> {

    // ==========================================
    // 1. CREATE (INSERT)
    // ==========================================
    @Override
    public CollegeBus create(CollegeBus bus) throws DatabaseOperationException {
        String sql = "INSERT INTO buses (bus_number, registration_number, total_seats, bus_type, bus_status) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = CollegeBusDBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, bus.getBusNumber());
            pstmt.setString(2, bus.getRegistrationNumber());
            pstmt.setInt(3, bus.getCapacity());
            pstmt.setString(4, bus instanceof AirConditionedBus ? "AC" : "NON_AC");
            pstmt.setString(5, bus.getStatus());

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows == 0) {
                throw new DatabaseOperationException("Creating bus record failed, no rows affected.", sql, null);
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    bus.setVehicleId(generatedKeys.getLong(1));
                }
            }

            return bus;

        } catch (SQLException ex) {
            throw new DatabaseOperationException("DBMS Error inserting bus record: " + ex.getMessage(), sql, ex);
        }
    }

    // ==========================================
    // 2. READ (SELECT BY ID)
    // ==========================================
    @Override
    public Optional<CollegeBus> findById(Long id) throws DatabaseOperationException {
        String sql = "SELECT bus_id, bus_number, registration_number, total_seats, bus_type, bus_status " +
                     "FROM buses WHERE bus_id = ?";

        try (Connection conn = CollegeBusDBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToBus(rs));
                }
            }

            return Optional.empty();

        } catch (SQLException ex) {
            throw new DatabaseOperationException("DBMS Error querying bus by ID: " + ex.getMessage(), sql, ex);
        }
    }

    // ==========================================
    // 3. READ (SELECT ALL)
    // ==========================================
    @Override
    public List<CollegeBus> findAll() throws DatabaseOperationException {
        String sql = "SELECT bus_id, bus_number, registration_number, total_seats, bus_type, bus_status " +
                     "FROM buses ORDER BY bus_id ASC";
        List<CollegeBus> busList = new ArrayList<>();

        try (Connection conn = CollegeBusDBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                busList.add(mapResultSetToBus(rs));
            }

            return busList;

        } catch (SQLException ex) {
            throw new DatabaseOperationException("DBMS Error querying all buses: " + ex.getMessage(), sql, ex);
        }
    }

    // ==========================================
    // 4. UPDATE
    // ==========================================
    @Override
    public boolean update(CollegeBus bus) throws DatabaseOperationException {
        String sql = "UPDATE buses SET bus_number = ?, registration_number = ?, total_seats = ?, " +
                     "bus_type = ?, bus_status = ? WHERE bus_id = ?";

        try (Connection conn = CollegeBusDBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, bus.getBusNumber());
            pstmt.setString(2, bus.getRegistrationNumber());
            pstmt.setInt(3, bus.getCapacity());
            pstmt.setString(4, bus instanceof AirConditionedBus ? "AC" : "NON_AC");
            pstmt.setString(5, bus.getStatus());
            pstmt.setLong(6, bus.getVehicleId());

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException ex) {
            throw new DatabaseOperationException("DBMS Error updating bus ID " + bus.getVehicleId() + ": " + ex.getMessage(), sql, ex);
        }
    }

    // ==========================================
    // 5. DELETE
    // ==========================================
    @Override
    public boolean deleteById(Long id) throws DatabaseOperationException {
        String sql = "DELETE FROM buses WHERE bus_id = ?";

        try (Connection conn = CollegeBusDBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, id);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException ex) {
            throw new DatabaseOperationException("DBMS Error deleting bus ID " + id + ": " + ex.getMessage(), sql, ex);
        }
    }

    // ==========================================
    // 6. COUNT
    // ==========================================
    @Override
    public long count() throws DatabaseOperationException {
        String sql = "SELECT COUNT(*) FROM buses";

        try (Connection conn = CollegeBusDBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getLong(1);
            }
            return 0L;

        } catch (SQLException ex) {
            throw new DatabaseOperationException("DBMS Error counting bus records: " + ex.getMessage(), sql, ex);
        }
    }

    // ==========================================
    // OOP & DBMS INTEGRATION: MAP RESULTSET TO OOP HIERARCHY
    // ==========================================
    /**
     * Demonstrates integration of database records with runtime polymorphism:
     * Instantiates the exact subclass (AirConditionedBus vs StandardCollegeBus) based on
     * relational table discriminator 'bus_type'.
     */
    private CollegeBus mapResultSetToBus(ResultSet rs) throws SQLException {
        Long busId = rs.getLong("bus_id");
        String busNumber = rs.getString("bus_number");
        String regNumber = rs.getString("registration_number");
        int seats = rs.getInt("total_seats");
        String busType = rs.getString("bus_type");
        String status = rs.getString("bus_status");

        CollegeBus bus;
        if ("AC".equalsIgnoreCase(busType)) {
            bus = new AirConditionedBus(busId, busNumber, regNumber, seats, "Active Route", 22.0);
        } else {
            bus = new StandardCollegeBus(busId, busNumber, regNumber, seats, "Active Route", 2);
        }

        bus.setStatus(status);
        return bus;
    }
}
