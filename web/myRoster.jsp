<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String userID = (String) session.getAttribute("userID");

    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");

    if (name == null) name = "Operator";
    if (role == null) role = "operator";
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Roster | NAKHODA</title>

    <link rel="stylesheet" href="assets/css/dashboard.css">

    <style>

        body{
            margin:0;
            font-family:'Segoe UI', sans-serif;
            background:#f4f7fa;
        }

        .layout{
            display:flex;
            min-height:100vh;
        }

        .content{
            flex:1;
            padding:20px;
        }

        /* TOPBAR (same system style) */
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

        .badge{
            background:#ffffff22;
            padding:8px 12px;
            border-radius:50%;
            font-weight:bold;
        }

        /* CARD */
        .card{
            background:white;
            padding:20px;
            border-radius:14px;
            box-shadow:0 6px 18px rgba(0,0,0,0.06);
        }

        /* TABLE */
        table{
            width:100%;
            border-collapse:collapse;
            margin-top:10px;
        }

        th{
            background:#f1f3f5;
            text-align:left;
            padding:12px;
        }

        td{
            padding:12px;
            border-bottom:1px solid #eee;
        }

        /* BUTTON */
        .btn-view{
            background:#1e88e5;
            color:white;
            padding:6px 12px;
            border-radius:8px;
            text-decoration:none;
            cursor:pointer;
            font-size:13px;
        }

        .btn-view:hover{
            opacity:0.9;
        }

        /* PILL STATUS */
        .pill{
            display:inline-block;
            padding:5px 10px;
            border-radius:20px;
            background:#eef3ff;
            color:#1e88e5;
            font-size:12px;
            font-weight:bold;
        }

        /* MODAL */
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
            margin:10% auto;
            padding:25px;
            width:420px;
            border-radius:14px;
            position:relative;
        }

        .close{
            position:absolute;
            right:15px;
            top:10px;
            font-size:22px;
            cursor:pointer;
        }

        .modal-body p{
            margin:10px 0;
        }

    </style>
</head>

<body>

<div class="layout">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <%@ include file="includes/sidebar.jsp" %>
    </aside>

    <!-- CONTENT -->
    <main class="content">

        <!-- TOPBAR -->
        <div class="topbar">
            <div style="font-weight:900;">
                My Roster
            </div>

            <div class="badge">
                <%=name.substring(0,1).toUpperCase()%>
            </div>
        </div>

        <!-- CARD -->
        <div class="card">

            <h3 style="margin-top:0;">Assigned Rosters</h3>

            <table>

                <thead>
                <tr>
                    <th>Roster ID</th>
                    <th>Date</th>
                    <th>Shift</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody>

                <c:choose>

                    <c:when test="${empty rosterList}">
                        <tr>
                            <td colspan="6" style="text-align:center;">
                                No roster assigned yet.
                            </td>
                        </tr>
                    </c:when>

                    <c:otherwise>

                        <c:forEach var="r" items="${rosterList}">
                            <tr>
                                <td>${r.rosterID}</td>
                                <td>${r.shiftDate}</td>
                                <td>${r.shiftName}</td>
                                <td>${r.startTime} - ${r.endTime}</td>
                                <td><span class="pill">${r.status}</span></td>

                                <td>
                                    <a class="btn-view"
                                       onclick="openModal(
                                           '${r.rosterID}',
                                           '${r.taskID}',
                                           '${r.shiftName}',
                                           '${r.shiftDate}',
                                           '${r.startTime} - ${r.endTime}',
                                           '${r.status}'
                                       )">
                                        View
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                    </c:otherwise>

                </c:choose>

                </tbody>

            </table>

        </div>

        <div style="margin-top:12px;color:#666;font-size:13px;">
            Logged in as <b><%=name%></b> (<%=role%>)
        </div>

    </main>
</div>

<!-- MODAL -->
<div id="rosterModal" class="modal">

    <div class="modal-content">

        <span class="close" onclick="closeModal()">&times;</span>

        <h2>Roster Details</h2>

        <div class="modal-body">

            <p><b>Roster ID:</b> <span id="m_rosterID"></span></p>
            <p><b>Task ID:</b> <span id="m_taskID"></span></p>
            <p><b>Shift Name:</b> <span id="m_shiftName"></span></p>
            <p><b>Date:</b> <span id="m_shiftDate"></span></p>
            <p><b>Time:</b> <span id="m_time"></span></p>
            <p><b>Status:</b> <span id="m_status"></span></p>

        </div>

    </div>

</div>

<script>

function openModal(rosterID, taskID, shiftName, shiftDate, time, status){

    document.getElementById("m_rosterID").innerText = rosterID;
    document.getElementById("m_taskID").innerText = taskID;
    document.getElementById("m_shiftName").innerText = shiftName;
    document.getElementById("m_shiftDate").innerText = shiftDate;
    document.getElementById("m_time").innerText = time;
    document.getElementById("m_status").innerText = status;

    document.getElementById("rosterModal").style.display = "block";
}

function closeModal(){
    document.getElementById("rosterModal").style.display = "none";
}

window.onclick = function(event){
    if(event.target === document.getElementById("rosterModal")){
        closeModal();
    }
}

</script>

</body>
</html>