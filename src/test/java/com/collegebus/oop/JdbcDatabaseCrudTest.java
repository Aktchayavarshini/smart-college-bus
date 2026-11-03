package com.collegebus.oop;

import com.collegebus.oop.dao.CollegeBusDBConnection;
import com.collegebus.oop.dao.JdbcBookingDao;
import com.collegebus.oop.dao.JdbcBusDao;
import com.collegebus.oop.exception.DatabaseOperationException;
import com.collegebus.oop.model.AirConditionedBus;
import com.collegebus.oop.model.CollegeBus;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("DBMS Connectivity & JDBC CRUD Test Suite")
class JdbcDatabaseCrudTest {

    private static JdbcBusDao busDao;
    private static JdbcBookingDao bookingDao;

    @BeforeAll
    static void init() {
        // Enforce fallback in-memory H2 mode during decoupled testing
        CollegeBusDBConnection.setFallbackMode(true);
        busDao = new JdbcBusDao();
        bookingDao = new JdbcBookingDao();
    }

    @Test
    @DisplayName("DBMS: Verifies raw JDBC Connection metadata")
    void testJdbcConnection_Metadata() throws Exception {
        Connection conn = CollegeBusDBConnection.getConnection();
        assertNotNull(conn);
        assertFalse(conn.isClosed());
        assertNotNull(conn.getMetaData().getDatabaseProductName());
        conn.close();
    }

    @Test
    @DisplayName("DBMS: Complete CRUD Lifecycle (Create, Read, Update, Delete) on 'buses' table")
    void testBusCrudLifecycle() throws DatabaseOperationException {
        // 1. CREATE
        AirConditionedBus newBus = new AirConditionedBus(null, "BUS-TEST-CRUD", "TN-01-CR-1111", 42, "Test Corridor", 21.0);
        CollegeBus created = busDao.create(newBus);
        assertNotNull(created.getVehicleId());
        assertTrue(created.getVehicleId() > 0);

        // 2. READ (findById)
        Optional<CollegeBus> found = busDao.findById(created.getVehicleId());
        assertTrue(found.isPresent());
        assertEquals("BUS-TEST-CRUD", found.get().getBusNumber());
        assertEquals(42, found.get().getCapacity());

        // 3. READ (findAll)
        List<CollegeBus> allBuses = busDao.findAll();
        assertFalse(allBuses.isEmpty());

        // 4. UPDATE
        created.setCapacity(50);
        created.setStatus("MAINTENANCE");
        boolean updated = busDao.update(created);
        assertTrue(updated);

        Optional<CollegeBus> postUpdate = busDao.findById(created.getVehicleId());
        assertTrue(postUpdate.isPresent());
        assertEquals(50, postUpdate.get().getCapacity());
        assertEquals("MAINTENANCE", postUpdate.get().getStatus());

        // 5. DELETE
        boolean deleted = busDao.deleteById(created.getVehicleId());
        assertTrue(deleted);

        Optional<CollegeBus> postDelete = busDao.findById(created.getVehicleId());
        assertFalse(postDelete.isPresent());
    }

    @Test
    @DisplayName("DBMS: ACID Transactional Booking creation")
    void testTransactionalBooking() throws DatabaseOperationException {
        String ref = "TXN-DEMO-" + System.currentTimeMillis();
        Long bookingId = bookingDao.createBookingWithTransaction(ref, 1L, 1L, 1L, 2L);
        assertNotNull(bookingId);
        assertTrue(bookingId > 0);

        // Clean up test booking
        bookingDao.deleteBooking(bookingId);
    }
}
