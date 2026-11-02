package com.collegebus.service.impl;

import com.collegebus.entity.Driver;
import com.collegebus.exception.ResourceNotFoundException;
import com.collegebus.repository.DriverRepository;
import com.collegebus.service.DriverService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class DriverServiceImpl implements DriverService {

    private final DriverRepository driverRepository;

    public DriverServiceImpl(DriverRepository driverRepository) {
        this.driverRepository = driverRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Driver> getAllDrivers() {
        return driverRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Driver> getActiveDrivers() {
        return driverRepository.findByDriverStatus("ACTIVE");
    }

    @Override
    @Transactional(readOnly = true)
    public Driver getDriverById(Long id) {
        return driverRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Driver not found with ID: " + id));
    }

    @Override
    public Driver saveDriver(Driver driver) {
        return driverRepository.save(driver);
    }

    @Override
    public Driver updateDriver(Long id, Driver details) {
        Driver driver = getDriverById(id);
        driver.setDriverName(details.getDriverName());
        driver.setPhoneNumber(details.getPhoneNumber());
        driver.setLicenseNumber(details.getLicenseNumber());
        driver.setDriverStatus(details.getDriverStatus());
        return driverRepository.save(driver);
    }

    @Override
    public void toggleDriverStatus(Long id) {
        Driver driver = getDriverById(id);
        if ("ACTIVE".equalsIgnoreCase(driver.getDriverStatus())) {
            driver.setDriverStatus("ON_LEAVE");
        } else {
            driver.setDriverStatus("ACTIVE");
        }
        driverRepository.save(driver);
    }

    @Override
    @Transactional(readOnly = true)
    public long countTotalDrivers() {
        return driverRepository.count();
    }
}
