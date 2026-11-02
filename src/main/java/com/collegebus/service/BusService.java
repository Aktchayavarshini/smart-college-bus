package com.collegebus.service;

import com.collegebus.entity.Bus;
import java.util.List;

public interface BusService {

    List<Bus> getAllBuses();

    List<Bus> getActiveBuses();

    Bus getBusById(Long id);

    Bus saveBus(Bus bus);

    Bus updateBus(Long id, Bus busDetails);

    void toggleBusStatus(Long id);

    long countTotalBuses();
}
