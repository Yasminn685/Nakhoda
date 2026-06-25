<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");

    if (name == null) name = "Demo Operator";
    if (role == null) role = "operator";
%>

<!DOCTYPE html>
<html>
<head>
    <title>Operator Dashboard | NAKHODA</title>

    <link rel="stylesheet" href="assets/css/dashboard.css">
    <script src="assets/js/dashboard.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

    <style>
        body{
            margin:0;
            font-family:'Segoe UI', sans-serif;
            background:#f4f7fa;
        }

        .layout{ display:flex; min-height:100vh; }
        .content{ flex:1; padding:20px; }

        .topbar{
            background:linear-gradient(135deg,#0b2a4a,#1e88e5);
            color:white;
            padding:15px 20px;
            border-radius:12px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:20px;
        }

        .grid{
            display:grid;
            grid-template-columns:repeat(3,1fr);
            gap:15px;
        }

        .card{
            background:white;
            padding:18px;
            border-radius:14px;
            box-shadow:0 6px 18px rgba(0,0,0,0.06);
        }

        .value{
            font-size:24px;
            font-weight:bold;
            color:#1e88e5;
        }

        .pill{
            background:#eef3ff;
            color:#1e88e5;
            padding:5px 12px;
            border-radius:20px;
            font-size:12px;
        }

        #calendar{
            margin-top:10px;
            min-height:650px;
        }

        .modal{
            display:none;
            position:fixed;
            z-index:9999;
            left:0;
            top:0;
            width:100%;
            height:100%;
            background:rgba(0,0,0,0.55);
        }

        .modal-content{
            background:white;
            width:420px;
            margin:10% auto;
            padding:25px;
            border-radius:14px;
        }

        .close{
            float:right;
            font-size:22px;
            cursor:pointer;
        }

        .btn{
            background:#1e88e5;
            color:white;
            border:none;
            padding:10px 14px;
            border-radius:8px;
            cursor:pointer;
            font-weight:600;
        }

        .btn.secondary{
            background:#6c757d;
        }

        .btn:disabled{
            opacity:0.4;
            cursor:not-allowed;
        }

        .fc-event.active{ background:#1e88e5 !important; }
        .fc-event.overdue{ background:#dc3545 !important; }
        .fc-event.upcoming{ background:#6c757d !important; }

    </style>
</head>

<body>

<div class="layout">

    <%@ include file="includes/sidebar.jsp" %>

    <main class="content">

        <!-- TOPBAR -->
        <div class="topbar">
            <div style="font-weight:900;">Welcome, <%=name%></div>
            <div class="pill">OPERATOR</div>
        </div>

        <!-- KPI -->
        <section class="grid">

            <div class="card">
                <div>Today Shift</div>
                <div class="value">${todayShift}</div>
            </div>

            <div class="card">
                <div>Total Tasks</div>
                <div class="value">${tasks.size()}</div>
            </div>

            <div class="card">
                <div>Equipment</div>
                <div class="value">E-QC-01</div>
            </div>

        </section>

        <!-- CALENDAR -->
        <section class="card" style="margin-top:15px;">
            <b>My Work Calendar</b>
            <span class="pill">Click event to update</span>

            <div id="calendar"></div>
        </section>

    </main>
</div>

<!-- MODAL -->
<div id="taskModal" class="modal">

    <div class="modal-content">

        <span class="close">&times;</span>

        <h3>Task Details</h3>

        <p><b>Task ID:</b> <span id="taskID"></span></p>
        <p><b>Shift:</b> <span id="taskName"></span></p>
        <p><b>Status:</b> <span id="taskStatus"></span></p>

        <p>
            <b>Task:</b>
            <span id="taskLink"></span>
        </p>

        <form action="operatorDashboard" method="POST">
            <input type="hidden" name="action" value="updateStatus">
            <input type="hidden" name="taskID" id="formTaskID">

            <button type="submit" name="newStatus" value="In Progress" class="btn">
                Start
            </button>

            <button type="submit" name="newStatus" value="Completed" class="btn secondary">
                Done
            </button>
        </form>

    </div>
</div>

<script>

document.addEventListener('DOMContentLoaded', function () {

    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {

        initialView: 'dayGridMonth',

        events: [
        <c:forEach var="roster" items="${rosters}">
        {
            title: '${roster.shiftName}',
            start: '${roster.shiftDate}',

            extendedProps: {
                taskID: '${roster.taskID}',
                shiftName: '${roster.shiftName}',
                status: '${roster.status}',
                shiftDate: '${roster.shiftDate}'
            }
        },
        </c:forEach>
        ],

        eventClick: function(info){

            let shiftDate = new Date(info.event.start);
            let today = new Date();

            today.setHours(0,0,0,0);
            shiftDate.setHours(0,0,0,0);

            let state = "UPCOMING";

            if(shiftDate < today){
                state = "OVERDUE";
            } else if(shiftDate.getTime() === today.getTime()){
                state = "ACTIVE";
            }

            document.getElementById("taskID").innerText =
                info.event.extendedProps.taskID;

            document.getElementById("taskName").innerText =
                info.event.extendedProps.shiftName;

            document.getElementById("taskStatus").innerText =
                info.event.extendedProps.status + " (" + state + ")";

            // CLICKABLE LINK TO MY TASK PAGE
            document.getElementById("taskLink").innerHTML =
                '<a href="myTask?taskID=' +
                info.event.extendedProps.taskID +
                '" style="color:#1e88e5;font-weight:600;text-decoration:underline;">View Task Details</a>';

            document.getElementById("formTaskID").value =
                info.event.extendedProps.taskID;

            let buttons = document.querySelectorAll("#taskModal button");

            if(state === "OVERDUE" || info.event.extendedProps.status === "Completed"){
                buttons.forEach(b => b.disabled = true);
            } else {
                buttons.forEach(b => b.disabled = false);
            }

            document.getElementById("taskModal").style.display = "block";
        }

    });

    calendar.render();

    document.querySelector(".close").onclick = function(){
        document.getElementById("taskModal").style.display = "none";
    };

    window.onclick = function(event){
        if(event.target === document.getElementById("taskModal")){
            document.getElementById("taskModal").style.display = "none";
        }
    };

});

</script>

</body>
</html>