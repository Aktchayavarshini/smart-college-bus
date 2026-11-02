package com.collegebus.service.impl;

import com.collegebus.entity.BusStop;
import com.collegebus.exception.ResourceNotFoundException;
import com.collegebus.repository.BusStopRepository;
import com.collegebus.service.BusStopService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class BusStopServiceImpl implements BusStopService {

    private final BusStopRepository busStopRepository;

    public BusStopServiceImpl(BusStopRepository busStopRepository) {
        this.busStopRepository = busStopRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<BusStop> getAllStops() {
        return busStopRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<BusStop> getActiveStops() {
        return busStopRepository.findByStopStatus("ACTIVE");
    }

    @Override
    @Transactional(readOnly = true)
    public BusStop getStopById(Long id) {
        return busStopRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Bus Stop not found with ID: " + id));
    }

    @Override
    public BusStop saveStop(BusStop stop) {
        return busStopRepository.save(stop);
    }

    @Override
    public BusStop updateStop(Long id, BusStop details) {
        BusStop stop = getStopById(id);
        stop.setStopName(details.getStopName());
        stop.setLocationDescription(details.getLocationDescription());
        stop.setArea(details.getArea());
        stop.setStopStatus(details.getStopStatus());
        return busStopRepository.save(stop);
    }

    @Override
    public void toggleStopStatus(Long id) {
        BusStop stop = getStopById(id);
        if ("ACTIVE".equalsIgnoreCase(stop.getStopStatus())) {
            stop.setStopStatus("INACTIVE");
        } else {
            stop.setStopStatus("ACTIVE");
        }
        busStopRepository.save(stop);
    }

    @Override
    @Transactional(readOnly = true)
    public List<BusStop> searchStops(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getActiveStops();
        }
        return busStopRepository.findByStopNameContainingIgnoreCaseOrAreaContainingIgnoreCase(query, query);
    }

    @Override
    @Transactional(readOnly = true)
    public long countTotalStops() {
        return busStopRepository.count();
    }
}
