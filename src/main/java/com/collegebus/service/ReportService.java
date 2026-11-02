package com.collegebus.service;

import com.collegebus.dto.DemandReportDto;

import java.util.List;
import java.util.Map;

public interface ReportService {

    List<DemandReportDto> getRouteDemandReports();

    Map<String, Object> getOverallSystemMetrics();

    List<Map<String, Object>> getFrequentlyFullTrips();
}
