<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dao.RosterDAO"%>
<%@page import="model.Roster"%>

<%
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");

    if (name == null) {
        name = "Demo User";
    }

    if (role == null) {
        role = "manager";
    }

    List<Roster> roster = (List<Roster>) request.getAttribute("roster");

    // Logik menentukan halaman dashboard berdasarkan role
    String dashboardPage = "managerDashboard.jsp";
    if ("supervisor".equalsIgnoreCase(role)) {
        dashboardPage = "supervisorDashboard.jsp";
    } else if ("operator".equalsIgnoreCase(role)) {
        dashboardPage = "operatorDashboard.jsp";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Roster | NAKHODA</title>

    <link rel="stylesheet" href="assets/css/dashboard.css">
    <script src="assets/js/dashboard.js"></script>

    <style>
        .pill{
            padding:6px 12px;
            border-radius:20px;
            font-size:12px;
            font-weight:bold;
            background:#e8f0fe;
            color:#0b2a4a;
        }

        .table-wrap{
            overflow-x:auto;
        }

        .link-btn.red{
            color:red;
            text-decoration:none;
            font-weight:bold;
        }

        .link-btn.red:hover{
            text-decoration:underline;
        }
    </style>
</head>

<body>

<div class="layout">

    <%@ include file="includes/sidebar.jsp" %>

    <main class="content">

        <div class="topbar" style="display: flex; justify-content: space-between; align-items: center;">

            <div style="font-weight:900;">
                Manage Roster
            </div>

            <div class="actions" style="display: flex; gap: 10px; align-items: center;">

                <% if ("supervisor".equalsIgnoreCase(role)) { %>

                    <button class="btn"
                            onclick="location.href='rosterForm.jsp'">
                        ＋ Create Roster
                    </button>

                <% } %>
                
                <a href="<%= dashboardPage %>" style="color: inherit; text-decoration: none; font-weight: bold; padding: 10px 15px;">
                    ⬅ Back
                </a>

            </div>

        </div>

        <section class="card">

            <div style="display:flex;justify-content:space-between;align-items:center;">
                <div style="font-weight:900;">
                    Roster List
                </div>

                <span class="pill">
                    Live Data
                </span>
            </div>

            <%
                String msg = request.getParameter("msg");
                String err = request.getParameter("err");

                if ("deleted".equals(msg)) {
            %>

                <p style="color:green;margin-top:15px;">
                    Roster deleted successfully.
                </p>

            <%
                } else if (err != null) {
            %>

                <p style="color:red;margin-top:15px;">
                    Action failed : <%= err %>
                </p>

            <%
                }
            %>

            <div class="table-wrap">

                <table>

                    <thead>
                    <tr>

                        <th>Roster ID</th>
                        <th>Operator</th>
                        <th>Task</th>
                        <th>Shift</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                        <th>Date</th>
                        <th>Status</th>

                        <% if ("supervisor".equalsIgnoreCase(role)) { %>
                            <th>Action</th>
                        <% } %>

                    </tr>
                    </thead>

                    <tbody>

                    <%
                        if (roster == null || roster.isEmpty()) {
                    %>

                        <tr>
                            <td colspan="9" style="text-align: center;">
                                No roster found.
                            </td>
                        </tr>

                    <%
                        } else {

                            for (Roster r : roster) {
                    %>

                        <tr>

                            <td><%= r.getRosterID() %></td>

                            <td><%= r.getUserID() %></td>

                            <td><%= r.getTaskID() %></td>

                            <td><%= r.getShiftName() %></td>

                            <td><%= r.getStartTime() %></td>

                            <td><%= r.getEndTime() %></td>

                            <td><%= r.getShiftDate() %></td>

                            <td>
                                <span class="pill">
                                    <%= r.getStatus() %>
                                </span>
                            </td>

                            <% if ("supervisor".equalsIgnoreCase(role)) { %>

                            <td>

                                <a class="link-btn red"
                                   href="<%=request.getContextPath()%>/rosterDelete?rosterID=<%=r.getRosterID()%>"
                                   onclick="return confirm('Delete roster <%=r.getRosterID()%>?');">

                                    Delete

                                </a>

                            </td>

                            <% } %>

                        </tr>

                    <%
                            }
                        }
                    %>

                    </tbody>

                </table>

            </div>

            <div class="footer-note" style="margin-top: 15px;">

                Logged in as
                <b><%= name %></b>

                (Role:
                <b><%= role %></b>)

            </div>

        </section>

    </main>

</div>

</body>
</html>
