<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>

<%
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");

    if (name == null) {
        name = "Manager";
    }

    if (role == null || !(role.equalsIgnoreCase("manager") || role.equalsIgnoreCase("supervisor"))) {
        response.sendRedirect("login.jsp?err=unauthorized");
        return;
    }

    Integer totalOperators = (Integer) request.getAttribute("totalOperators");
    Integer activeOperators = (Integer) request.getAttribute("activeOperators");
    Integer totalTasks = (Integer) request.getAttribute("totalTasks");
    Integer completedTasks = (Integer) request.getAttribute("completedTasks");
    Integer totalRosters = (Integer) request.getAttribute("totalRosters");

    Map<String, Integer> taskMap = (Map<String, Integer>) request.getAttribute("taskStatusMap");
    Map<String, Integer> workloadMap = (Map<String, Integer>) request.getAttribute("workloadMap");
    Map<String, Integer> equipMap = (Map<String, Integer>) request.getAttribute("equipmentMap");

    if (taskMap == null) {
        taskMap = new java.util.LinkedHashMap<>();
    }
    if (workloadMap == null) {
        workloadMap = new java.util.LinkedHashMap<>();
    }
    if (equipMap == null)
        equipMap = new java.util.LinkedHashMap<>();

    // Logik menentukan halaman dashboard berdasarkan role
    String dashboardPage = "managerDashboard";
    if ("supervisor".equalsIgnoreCase(role)) {
        dashboardPage = "supervisorDashboard";
    } else if ("operator".equalsIgnoreCase(role)) {
        dashboardPage = "operatorDashboard";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>NAKHODA Report Dashboard</title>

        <link rel="stylesheet" href="assets/css/dashboard.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <style>

            /* GLOBAL */
            body{
                margin:0;
                font-family:'Segoe UI',sans-serif;
                background:#f4f7fb;
            }

            .layout{
                display:flex;
                min-height:100vh;
            }

            .content{
                flex:1;
                padding:20px;
            }

            /* TOPBAR */
            .header-nav{
                background:linear-gradient(135deg,#0b2a4a,#1e88e5);
                color:white;
                padding:15px 25px;
                display:flex;
                justify-content:space-between;
                align-items:center;
                border-radius:12px;
            }

            /* KPI GRID */
            .grid{
                display:grid;
                grid-template-columns:repeat(auto-fit,minmax(180px,1fr));
                gap:15px;
                margin-top:20px;
            }

            .card{
                background:white;
                border-radius:14px;
                padding:18px;
                box-shadow:0 6px 18px rgba(0,0,0,0.08);
                transition:0.2s;
            }

            .card:hover{
                transform:translateY(-3px);
            }

            .card small{
                color:#777;
            }

            .card h2{
                margin:10px 0 0;
                color:#1e88e5;
            }

            /* CHART SECTION */
            .charts{
                display:grid;
                grid-template-columns:1fr 1fr;
                gap:15px;
                margin-top:20px;
            }

            .chart-card{
                background:white;
                border-radius:14px;
                padding:20px;
                box-shadow:0 6px 18px rgba(0,0,0,0.08);
            }

            .chart-card h3{
                margin-top:0;
                color:#0b2a4a;
            }

            canvas{
                max-height:320px;
            }

            /* FOOTER */
            .footer-note{
                text-align:center;
                margin-top:20px;
                color:#888;
                font-size:13px;
            }

        </style>
    </head>

    <body>

        <div class="layout">

            <jsp:include page="includes/sidebar.jsp" />

            <div class="content">

                <div class="header-nav">
                    <div style="font-weight:800;">📊 Report Dashboard</div>
                    <div style="display: flex; align-items: center; gap: 15px;">
                        <div>Welcome, <b><%=name%></b></div>
                        <a href="<%= dashboardPage %>" style="color:white; text-decoration:none; font-weight: bold;">
                            ⬅ Back
                        </a>
                    </div>
                </div>

                <div class="grid">

                    <div class="card">
                        <small>Total Operators</small>
                        <h2><%=totalOperators%></h2>
                    </div>

                    <div class="card">
                        <small>Active Operators</small>
                        <h2><%=activeOperators%></h2>
                    </div>

                    <div class="card">
                        <small>Total Tasks</small>
                        <h2><%=totalTasks%></h2>
                    </div>

                    <div class="card">
                        <small>Completed Tasks</small>
                        <h2><%=completedTasks%></h2>
                    </div>

                    <div class="card">
                        <small>Total Rosters</small>
                        <h2><%=totalRosters%></h2>
                    </div>

                </div>

                <div class="charts">

                    <div class="chart-card">
                        <h3>Task Status</h3>
                        <canvas id="taskChart"></canvas>
                    </div>

                    <div class="chart-card">
                        <h3>Equipment Status</h3>
                        <canvas id="equipChart"></canvas>
                    </div>

                    <div class="chart-card" style="grid-column:1/-1;">
                        <h3>Operator Workload</h3>
                        <canvas id="workloadChart"></canvas>
                    </div>

                </div>

                <div class="footer-note">
                    NAKHODA Analytics Dashboard
                </div>

            </div>
        </div>

        <script>

            /* TASK CHART */
            new Chart(document.getElementById("taskChart"), {
            type: 'pie',
                    data: {
                    labels: [
            <% for (String k : taskMap.keySet()) {%>
                    "<%=k%>",
            <% } %>
                    ],
                            datasets: [{
                            data: [
            <% for (Integer v : taskMap.values()) {%>
            <%=v%>,
            <% } %>
                            ]
                            }]
                    }
            });
            /* EQUIPMENT */
            new Chart(document.getElementById("equipChart"), {
            type: 'doughnut',
                    data: {
                    labels: [
            <% for (String k : equipMap.keySet()) {%>
                    "<%=k%>",
            <% } %>
                    ],
                            datasets: [{
                            data: [
            <% for (Integer v : equipMap.values()) {%>
            <%=v%>,
            <% } %>
                            ]
                            }]
                    }
            });
            /* WORKLOAD */
            new Chart(document.getElementById("workloadChart"), {
            type: 'bar',
                    data: {
                    labels: [
            <% for (String k : workloadMap.keySet()) {%>
                    "<%=k%>",
            <% } %>
                    ],
                            datasets: [{
                            label: 'Workload',
                                    data: [
            <% for (Integer v : workloadMap.values()) {%>
            <%=v%>,
            <% }%>
                                    ]
                            }]
                    }
            });

        </script>

    </body>
</html>
