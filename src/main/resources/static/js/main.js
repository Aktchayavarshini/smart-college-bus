/**
 * SMART COLLEGE BUS ALLOCATION SYSTEM - MAIN JAVASCRIPT
 */

document.addEventListener('DOMContentLoaded', function () {
    // 1. Auto dismiss alerts after 5 seconds
    const alerts = document.querySelectorAll('.alert-dismissible');
    alerts.forEach(function (alert) {
        setTimeout(function () {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 6000);
    });

    // 2. Student vs Teacher Registration Form Toggle
    const roleSelect = document.getElementById('roleSelect');
    const studentFields = document.getElementById('studentFields');
    const teacherFields = document.getElementById('teacherFields');
    const studentTypeSelect = document.getElementById('studentTypeSelect');
    const hostelGroup = document.getElementById('hostelNameGroup');

    if (roleSelect) {
        function toggleRoleFields() {
            const selected = roleSelect.value;
            if (selected === 'STUDENT') {
                if (studentFields) studentFields.style.display = 'block';
                if (teacherFields) teacherFields.style.display = 'none';
            } else if (selected === 'TEACHER') {
                if (studentFields) studentFields.style.display = 'none';
                if (teacherFields) teacherFields.style.display = 'block';
            } else {
                if (studentFields) studentFields.style.display = 'none';
                if (teacherFields) teacherFields.style.display = 'none';
            }
        }
        roleSelect.addEventListener('change', toggleRoleFields);
        toggleRoleFields();
    }

    if (studentTypeSelect && hostelGroup) {
        function toggleHostel() {
            if (studentTypeSelect.value === 'HOSTEL') {
                hostelGroup.style.display = 'block';
            } else {
                hostelGroup.style.display = 'none';
            }
        }
        studentTypeSelect.addEventListener('change', toggleHostel);
        toggleHostel();
    }

    // 3. Travel Date restriction to today or future
    const travelDateInputs = document.querySelectorAll('input[type="date"]');
    const today = new Date().toISOString().split('T')[0];
    travelDateInputs.forEach(input => {
        if (!input.hasAttribute('data-allow-past')) {
            input.setAttribute('min', today);
        }
    });

    // 4. Interactive Monthly Calendar Render on /calendar
    const calendarGrid = document.getElementById('calendarDaysGrid');
    if (calendarGrid) {
        renderInteractiveCalendar();
    }
});

/**
 * Interactive Monthly Calendar Generator
 */
function renderInteractiveCalendar() {
    const calendarGrid = document.getElementById('calendarDaysGrid');
    const monthYearTitle = document.getElementById('calendarMonthYear');
    if (!calendarGrid) return;

    const now = new Date();
    let currentYear = now.getFullYear();
    let currentMonth = now.getMonth();

    const monthNames = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ];

    function buildCalendar(year, month) {
        calendarGrid.innerHTML = '';
        if (monthYearTitle) {
            monthYearTitle.textContent = `${monthNames[month]} ${year}`;
        }

        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const today = new Date();

        // Empty padding cells before first day
        for (let i = 0; i < firstDay; i++) {
            const emptyCell = document.createElement('div');
            emptyCell.className = 'calendar-day empty text-muted';
            calendarGrid.appendChild(emptyCell);
        }

        // Days of month
        for (let d = 1; d <= daysInMonth; d++) {
            const dayCell = document.createElement('div');
            dayCell.className = 'calendar-day p-2 text-center rounded border m-1 position-relative';
            dayCell.style.cursor = 'pointer';
            dayCell.style.minHeight = '65px';

            const cellDate = new Date(year, month, d);
            const isPast = cellDate < new Date(today.getFullYear(), today.getMonth(), today.getDate());
            const isToday = cellDate.toDateString() === today.toDateString();

            const formattedDate = `${year}-${String(month + 1).padStart(2, '0')}-${String(d).padStart(2, '0')}`;

            if (isPast) {
                dayCell.classList.add('bg-light', 'text-muted');
                dayCell.style.cursor = 'not-allowed';
                dayCell.innerHTML = `<span class="fw-bold">${d}</span><div class="small text-muted">Past</div>`;
            } else {
                dayCell.classList.add('bg-white', 'hover-lift');
                if (isToday) {
                    dayCell.classList.add('border-primary', 'bg-light-blue');
                }
                dayCell.innerHTML = `
                    <span class="fw-bold fs-6">${d}</span>
                    <div class="small text-success mt-1"><i class="fas fa-bus small"></i> Trips Active</div>
                `;
                dayCell.addEventListener('click', function () {
                    window.location.href = `/select-slot?date=${formattedDate}`;
                });
            }

            calendarGrid.appendChild(dayCell);
        }
    }

    buildCalendar(currentYear, currentMonth);

    const prevBtn = document.getElementById('calPrevBtn');
    const nextBtn = document.getElementById('calNextBtn');

    if (prevBtn) {
        prevBtn.addEventListener('click', function () {
            currentMonth--;
            if (currentMonth < 0) {
                currentMonth = 11;
                currentYear--;
            }
            buildCalendar(currentYear, currentMonth);
        });
    }

    if (nextBtn) {
        nextBtn.addEventListener('click', function () {
            currentMonth++;
            if (currentMonth > 11) {
                currentMonth = 0;
                currentYear++;
            }
            buildCalendar(currentYear, currentMonth);
        });
    }
}

/**
 * Print Boarding Pass Functionality
 */
function printBoardingPass(bookingId) {
    const printContents = document.getElementById('pass-content-' + bookingId);
    if (!printContents) {
        window.print();
        return;
    }
    const originalContents = document.body.innerHTML;
    document.body.innerHTML = printContents.innerHTML;
    window.print();
    document.body.innerHTML = originalContents;
    window.location.reload();
}
