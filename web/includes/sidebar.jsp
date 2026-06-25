<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String sidebarRole = (String) session.getAttribute("role");
    if (sidebarRole == null) sidebarRole = "operator";
%>

<aside class="sidebar">

    <div class="brand">
        <div class="logo">⚓</div>
        <div>
            <div class="title">NAKHODA</div>

            <div class="sub">
                <% if ("manager".equalsIgnoreCase(sidebarRole)) { %>
                    Port Resource Allocation
                <% } else if ("supervisor".equalsIgnoreCase(sidebarRole)) { %>
                    Supervisor Console
                <% } else { %>
                    Operator Portal
                <% } %>
            </div>
        </div>
    </div>

    <nav class="nav">

        <%-- ================= MANAGER ================= --%>
        <% if ("manager".equalsIgnoreCase(sidebarRole)) { %>

            <a href="managerDashboard">📊 Dashboard</a>
            <a href="operators">👷 Operators List</a>
            <a href="report">📄 Reports</a>

        <%-- ================= SUPERVISOR ================= --%>
        <% } else if ("supervisor".equalsIgnoreCase(sidebarRole)) { %>

            <a href="supervisorDashboard">📊 Dashboard</a>
            <a href="equipmentList">🏗 Manage Equipment</a>
            <a href="taskList">🧩 Manage Tasks</a>
            <a href="rosterList">🗓 Manage Roster</a>
            <a href="report">📄 Reports</a>

        <%-- ================= OPERATOR ================= --%>
        <% } else { %>

            <a href="operatorDashboard">📊 Dashboard</a>
            <a href="myRoster">🗓 My Roster</a>
            <a href="myTask">🧩 My Tasks</a>

        <% } %>

        <div class="spacer">ACCOUNT</div>

        <a href="profile">👤 Profile</a>
        <a class="btn gray" href="<%=request.getContextPath()%>/logout">Logout</a>

    </nav>
</aside>