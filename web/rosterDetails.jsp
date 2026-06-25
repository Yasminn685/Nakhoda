<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.RosterDAO"%>
<%@page import="model.Roster"%>

<%
String rosterID = request.getParameter("rosterID");

if(rosterID == null){
    response.sendRedirect("myRoster.jsp");
    return;
}

RosterDAO dao = new RosterDAO();
Roster roster = dao.getRosterByID(rosterID);

if(roster == null){
    response.sendRedirect("myRoster.jsp");
    return;
}

String name = (String) session.getAttribute("name");
String role = (String) session.getAttribute("role");

if(name == null) name = "Operator";
if(role == null) role = "operator";
%>

<!DOCTYPE html>
<html>
<head>

    <title>Roster Details | NAKHODA</title>

    <link rel="stylesheet" href="assets/css/dashboard.css">

    <style>

        .detail-box{
            max-width:700px;
        }

        .detail-row{
            padding:12px 0;
            border-bottom:1px solid #eee;
        }

        .label{
            font-weight:bold;
            color:#0b2a4a;
        }

        .pill{
            display:inline-block;
            padding:6px 12px;
            border-radius:20px;
            background:#e3f2fd;
            color:#1565c0;
            font-weight:bold;
        }

    </style>

</head>

<body>

<div class="layout">

    <aside class="sidebar">
        <%@ include file="includes/sidebar.jsp" %>
    </aside>

    <main class="content">

        <div class="topbar">

            <div style="font-weight:900;">
                Roster Details
            </div>

            <div class="actions">
                <div class="badge">
                    <%=name.substring(0,1).toUpperCase()%>
                </div>
            </div>

        </div>

        <section class="card detail-box">

            <h2>Assigned Roster Information</h2>

            <div class="detail-row">
                <span class="label">Roster ID:</span>
                <%=roster.getRosterID()%>
            </div>

            <div class="detail-row">
                <span class="label">Operator ID:</span>
                <%=roster.getUserID()%>
            </div>

            <div class="detail-row">
                <span class="label">Task ID:</span>
                <%=roster.getTaskID()%>
            </div>

            <div class="detail-row">
                <span class="label">Shift Name:</span>
                <%=roster.getShiftName()%>
            </div>

            <div class="detail-row">
                <span class="label">Shift Date:</span>
                <%=roster.getShiftDate()%>
            </div>

            <div class="detail-row">
                <span class="label">Start Time:</span>
                <%=roster.getStartTime()%>
            </div>

            <div class="detail-row">
                <span class="label">End Time:</span>
                <%=roster.getEndTime()%>
            </div>

            <div class="detail-row">
                <span class="label">Status:</span>

                <span class="pill">
                    <%=roster.getStatus()%>
                </span>
            </div>

            <div style="margin-top:20px;">

                <a href="myRoster.jsp" class="btn">
                    ← Back to My Roster
                </a>

            </div>

        </section>

    </main>

</div>

</body>
</html>