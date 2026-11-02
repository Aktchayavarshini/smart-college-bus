package com.collegebus.service;

import com.collegebus.entity.Driver;
import java.util.List;

public interface DriverService {

    List<Driver> getAllDrivers();

    List<Driver> getActiveDrivers();

    Driver getDriverById(Long id);

    Driver saveDriver(Driver driver);

    Driver updateDriver(Long id, Driver driverDetails);

    void toggleDriverStatus(Long id);

    long countTotalDrivers();
}
