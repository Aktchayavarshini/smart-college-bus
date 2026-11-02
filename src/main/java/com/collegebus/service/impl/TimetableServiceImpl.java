package com.collegebus.service.impl;

import com.collegebus.dto.ExamRecommendationDto;
import com.collegebus.dto.TripCardDto;
import com.collegebus.entity.*;
import com.collegebus.repository.AcademicTimetableRepository;
import com.collegebus.repository.BookingRepository;
import com.collegebus.repository.ExamTimetableRepository;
import com.collegebus.repository.TripRepository;
import com.collegebus.service.TimetableService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class TimetableServiceImpl implements TimetableService {

    private final AcademicTimetableRepository academicTimetableRepository;
    private final ExamTimetableRepository examTimetableRepository;
    private final TripRepository tripRepository;
    private final BookingRepository bookingRepository;

    public TimetableServiceImpl(AcademicTimetableRepository academicTimetableRepository,
                                ExamTimetableRepository examTimetableRepository,
                                TripRepository tripRepository,
                                BookingRepository bookingRepository) {
        this.academicTimetableRepository = academicTimetableRepository;
        this.examTimetableRepository = examTimetableRepository;
        this.tripRepository = tripRepository;
        this.bookingRepository = bookingRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<AcademicTimetable> getAcademicTimetable(String department, Integer academicYear, Integer semester) {
        if (department != null && academicYear != null && semester != null) {
            return academicTimetableRepository.findByDepartmentAndAcademicYearAndSemesterOrderByDayOfWeekAscStartTimeAsc(department, academicYear, semester);
        }
        return academicTimetableRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<AcademicTimetable> getAllAcademicTimetables() {
        return academicTimetableRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<ExamTimetable> getExamTimetable(String department, Integer academicYear, Integer semester) {
        if (department != null && academicYear != null && semester != null) {
            return examTimetableRepository.findByDepartmentAndAcademicYearAndSemesterOrderByExamDateAscExamStartTimeAsc(department, academicYear, semester);
        }
        return examTimetableRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<ExamTimetable> getAllExamTimetables() {
        return examTimetableRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<ExamRecommendationDto> getExamBusRecommendations(String department, Integer academicYear, Integer semester) {
        List<ExamTimetable> exams = getExamTimetable(department, academicYear, semester);
        List<ExamRecommendationDto> recommendations = new ArrayList<>();

        for (ExamTimetable exam : exams) {
            ExamRecommendationDto dto = new ExamRecommendationDto();
            dto.setExamId(exam.getExamId());
            dto.setSubjectName(exam.getSubjectName());
            dto.setDepartment(exam.getDepartment());
            dto.setSemester(exam.getSemester());
            dto.setExamDate(exam.getExamDate());
            dto.setExamStartTime(exam.getExamStartTime());
            dto.setExamEndTime(exam.getExamEndTime());
            dto.setExamType(exam.getExamType());

            // Query actual scheduled trips departing at or after exam end time
            List<Trip> tripsAfter = tripRepository.findTripsAfterTime(exam.getExamDate(), exam.getExamEndTime());

            Trip recommendedTrip = null;
            for (Trip t : tripsAfter) {
                // Return trips from College Main Campus
                boolean isReturnFromCampus = t.getRoute().getSource().toLowerCase().contains("college")
                        || t.getRoute().getSource().toLowerCase().contains("campus");

                // Ideal bus departs between 15 mins to 90 mins after exam end
                LocalTime departure = t.getDepartureTime();
                if (departure.isAfter(exam.getExamEndTime().minusMinutes(5))) {
                    recommendedTrip = t;
                    break;
                }
            }

            if (recommendedTrip != null) {
                TripCardDto card = new TripCardDto();
                card.setTripId(recommendedTrip.getTripId());
                card.setBusNumber(recommendedTrip.getBus().getBusNumber());
                card.setRegistrationNumber(recommendedTrip.getBus().getRegistrationNumber());
                card.setRouteName(recommendedTrip.getRoute().getRouteName());
                card.setSource(recommendedTrip.getRoute().getSource());
                card.setDestination(recommendedTrip.getRoute().getDestination());
                card.setTravelDate(recommendedTrip.getTravelDate());
                card.setDepartureTime(recommendedTrip.getDepartureTime());
                card.setArrivalTime(recommendedTrip.getArrivalTime());
                card.setTripType(recommendedTrip.getTripType());

                long booked = bookingRepository.countByTripAndBookingStatus(recommendedTrip, "CONFIRMED");
                int available = Math.max(0, recommendedTrip.getBus().getTotalSeats() - (int) booked);
                card.setTotalSeats(recommendedTrip.getBus().getTotalSeats());
                card.setBookedSeats((int) booked);
                card.setAvailableSeats(available);

                dto.setRecommendedTrip(card);
            }

            recommendations.add(dto);
        }

        return recommendations;
    }

    @Override
    public AcademicTimetable saveAcademicTimetable(AcademicTimetable timetable) {
        return academicTimetableRepository.save(timetable);
    }

    @Override
    public ExamTimetable saveExamTimetable(ExamTimetable exam) {
        return examTimetableRepository.save(exam);
    }
}
