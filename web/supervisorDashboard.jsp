<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Supervisor Dashboard | NAKHODA</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="assets/css/dashboard.css">
        <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

        <style>
            .layout {
                display:flex;
                min-height:100vh;
            }
            .content {
                flex:1;
                padding:20px;
            }
            .topbar {
                background: linear-gradient(135deg,#0b2a4a,#1e88e5);
                color:white;
                padding:15px;
                border-radius:12px;
                margin-bottom:20px;
                display:flex;
                justify-content:space-between;
            }

            .grid {
                display:grid;
                grid-template-columns:repeat(4,1fr);
                gap:15px;
                margin-bottom:20px;
            }

            .card {
                background:white;
                padding:18px;
                border-radius:14px;
                box-shadow:0 6px 18px rgba(0,0,0,0.08);
            }

            .value {
                font-size:26px;
                font-weight:bold;
                color:#1e88e5;
            }

            table {
                width:100%;
                border-collapse:collapse;
            }

            th {
                background:#1e88e5;
                color:white;
                padding:10px;
            }

            td {
                padding:10px;
                border-bottom:1px solid #eee;
            }

            #calendar {
                min-height:700px;
            }

            .calendar-card {
                background:white;
                padding:20px;
                border-radius:14px;
                margin-top:20px;
            }

/* ==========================================================================
   KOD TAMBAHAN: RESPONSIF UNTUK TELEFON (Maksimum 768px)
   ========================================================================== */
@media screen and (max-width: 768px) {
    .layout {
        flex-direction: column !important;
    }
    .grid {
        grid-template-columns: 1fr !important;
        gap: 12px !important;
    }
    .two-col {
        grid-template-columns: 1fr !important;
        gap: 15px !important;
    }
    .card {
        overflow-x: auto !important;
    }
    .form-card {
        overflow-x: visible !important;
    }
    .modern-form {
        grid-template-columns: 1fr !important;
    }
}
        </style>
    </head>

    <body>

        <div class="layout">

            <aside class="sidebar">
                <%@ include file="includes/sidebar.jsp" %>
            </aside>

            <main class="content">

                <!-- TOP -->
                <div class="topbar">
                    <div><b>Supervisor Dashboard</b></div>
                    <div>Welcome, ${name}</div>
                </div>

                <!-- KPI -->
                <section class="grid">

                    <div class="card">
                        <h3>Available Equipment</h3>
                        <div class="value">${availableEquipment}</div>
                    </div>

                    <div class="card">
                        <h3>In Use</h3>
                        <div class="value">${inUseEquipment}</div>
                    </div>

                    <div class="card">
                        <h3>Maintenance</h3>
                        <div class="value">${maintenanceEquipment}</div>
                    </div>

                    <div class="card">
                        <h3>Pending Tasks</h3>
                        <div class="value">${pendingTasks}</div>
                    </div>

                </section>

                <!-- TODAY ROSTER -->
                <section class="card">

                    <h3>Today Roster</h3>

                    <table>
                        <tr>
                            <th>Shift</th>
                            <th>Time</th>
                            <th>Operator</th>
                            <th>Status</th>
                        </tr>

                        <c:forEach var="r" items="${todayRoster}">
                            <tr>
                                <td>${r.shiftName}</td>
                                <td>${r.startTime} - ${r.endTime}</td>
                                <td>${r.userID}</td>
                                <td>${r.status}</td>
                            </tr>
                        </c:forEach>
                    </table>

                </section>

                <!-- CALENDAR -->
                <section class="calendar-card">

                    <h3>Roster Calendar</h3>

                    <div id="calendar"></div>

                </section>

            </main>
        </div>

        <script>

            document.addEventListener('DOMContentLoaded', function () {

                var calendar = new FullCalendar.Calendar(
                        document.getElementById('calendar'),
                        {
                            initialView: 'dayGridMonth',
                            height: 700,

                            events: [
            <c:forEach var="r" items="${rosterCalendar}">
                                {
                                    id: '${r.rosterID}',
                                    title: '${r.userID} - ${r.shiftName}',
                                                                start: '${r.shiftDate}T${r.startTime}',
                                                                                            end: '${r.shiftDate}T${r.endTime}',

                                                                                                                        color:
                                                                                                                                '${r.status == "Completed" ? "#4CAF50"
                   : r.status == "Assigned" ? "#2196F3"
                   : "#FF9800"}'
                                                                                                                    },
            </c:forEach>
                                                                                                                ]
                                                                                                            }
                                                                                                    );

                                                                                                    calendar.render();

                                                                                                });

        </script>

    </body>
</html>
