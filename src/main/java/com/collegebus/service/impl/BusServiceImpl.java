package com.collegebus.service.impl;

import com.collegebus.entity.Bus;
import com.collegebus.exception.ResourceNotFoundException;
import com.collegebus.repository.BusRepository;
import com.collegebus.service.BusService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class BusServiceImpl implements BusService {

    private final BusRepository busRepository;

    public BusServiceImpl(BusRepository busRepository) {
        this.busRepository = busRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Bus> getAllBuses() {
        return busRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Bus> getActiveBuses() {
        return busRepository.findByBusStatus("ACTIVE");
    }

    @Override
    @Transactional(readOnly = true)
    public Bus getBusById(Long id) {
        return busRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Bus not found with ID: " + id));
    }

    @Override
    public Bus saveBus(Bus bus) {
        return busRepository.save(bus);
    }

    @Override
    public Bus updateBus(Long id, Bus details) {
        Bus bus = getBusById(id);
        bus.setBusNumber(details.getBusNumber());
        bus.setRegistrationNumber(details.getRegistrationNumber());
        bus.setTotalSeats(details.getTotalSeats());
        bus.setBusType(details.getBusType());
        bus.setBusStatus(details.getBusStatus());
        return busRepository.save(bus);
    }

    @Override
    public void toggleBusStatus(Long id) {
        Bus bus = getBusById(id);
        if ("ACTIVE".equalsIgnoreCase(bus.getBusStatus())) {
            bus.setBusStatus("MAINTENANCE");
        } else {
            bus.setBusStatus("ACTIVE");
        }
        busRepository.save(bus);
    }

    @Override
    @Transactional(readOnly = true)
    public long countTotalBuses() {
        return busRepository.count();
    }
}
