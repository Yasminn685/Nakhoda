<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.Equipment"%>

<%
    List<Equipment> equipmentList
            = (List<Equipment>) request.getAttribute("equipmentList");

    if (equipmentList == null) {
        equipmentList = new ArrayList<Equipment>();
    }

    String role = (String) session.getAttribute("role");
    String name = (String) session.getAttribute("name");

    if (role == null) {
        role = "manager";
    }
    if (name == null) {
        name = "Demo User";
    }

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
        <title>Manage Equipment | NAKHODA</title>

        <link rel="stylesheet" href="assets/css/dashboard.css">

        <style>

            body {
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                background: #f4f7fb;
            }

            .layout {
                display: flex;
                min-height: 100vh;
            }

            .content {
                flex: 1;
                padding: 20px;
            }

            /* TOPBAR */
            .header-nav {
                background: linear-gradient(135deg, #0b2a4a, #1e88e5);
                color: white;
                padding: 15px 20px;
                border-radius: 12px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            /* CARD */
            .card {
                background: white;
                padding: 20px;
                border-radius: 14px;
                box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            }

            /* BUTTON */
            .btn {
                background: linear-gradient(135deg, #1e88e5, #0b2a4a);
                color: white;
                padding: 10px 15px;
                border-radius: 10px;
                border: none;
                cursor: pointer;
                font-weight: bold;
            }

            .btn.secondary {
                background: #6c757d;
            }

            /* TABLE */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
                overflow: hidden;
                border-radius: 10px;
            }

            th {
                background: #1e88e5;
                color: white;
                padding: 12px;
                text-align: left;
            }

            td {
                padding: 12px;
                border-bottom: 1px solid #eee;
            }

            tr:hover {
                background: #f2f7ff;
            }

            /* ACTION BUTTONS */
            .btn-edit {
                background: #ffc107;
                color: black;
                padding: 6px 10px;
                border-radius: 8px;
                text-decoration: none;
                font-size: 12px;
                margin-right: 5px;
            }

            .btn-delete {
                background: #dc3545;
                color: white;
                padding: 6px 10px;
                border-radius: 8px;
                text-decoration: none;
                font-size: 12px;
            }

            /* MODAL */
            .modal {
                display: none;
                position: fixed;
                z-index: 999;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.6);
            }

            .modal-content {
                background: white;
                width: 450px;
                margin: 80px auto;
                padding: 25px;
                border-radius: 14px;
            }

            label {
                display: block;
                margin-top: 10px;
                font-weight: 600;
                color: #333;
            }

            input, select {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ddd;
                border-radius: 8px;
            }

            .button-group {
                margin-top: 15px;
                display: flex;
                gap: 10px;
            }

        </style>
    </head>

    <body>

        <div class="layout">

            <!-- SIDEBAR -->
            <jsp:include page="includes/sidebar.jsp" />

            <div class="content">

                <!-- TOPBAR -->
                <div class="header-nav">
                    <div><b>NAKHODA</b> — Manage Equipment</div>

                    <a href="<%= dashboardPage%>" style="color:white;text-decoration:none;">
                        ⬅ Back
                    </a>
                </div>

                <!-- CONTENT -->
                <div class="card">

                    <div style="display:flex;justify-content:space-between;align-items:center;">
                        <h2 style="margin:0;">🏗 Equipment List</h2>

                        <button class="btn" onclick="openAddModal()">
                            ➕ Add Equipment
                        </button>
                    </div>

                    <table>

                        <tr>
                            <th>ID</th>
                            <th>Type</th>
                            <th>Code</th>
                            <th>Status</th>
                            <th>Location</th>
                            <th>Action</th>
                        </tr>

                        <%
                            for (Equipment e : equipmentList) {
                        %>
                        <tr>
                            <td><%= e.getEquipmentID()%></td>
                            <td><%= e.getEquipmentType()%></td>
                            <td><%= e.getEquipmentCode()%></td>
                            <td><%= e.getEquipmentStatus()%></td>
                            <td><%= e.getLocation()%></td>

                            <td>
                                <a class="btn-edit"
                                   href="#"
                                   onclick="openEditModal(
                                           '<%= e.getEquipmentID()%>',
                                           '<%= e.getEquipmentType()%>',
                                           '<%= e.getEquipmentCode()%>',
                                           '<%= e.getEquipmentStatus()%>',
                                           '<%= e.getLocation()%>'
                                           )">Edit</a>

                                <a class="btn-delete"
                                   href="equipmentDelete?equipmentID=<%= e.getEquipmentID()%>"
                                   onclick="return confirm('Delete this equipment?')">
                                    Delete
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                        %>

                    </table>

                </div>
            </div>
        </div>

        <!-- ================= MODAL ================= -->
        <div id="equipmentModal" class="modal">
            <div class="modal-content">

                <h2 id="modalTitle">Add Equipment</h2>

                <form id="equipmentForm" method="post">

                    <input type="hidden" id="equipmentIDOld" name="equipmentIDOld">

                    <label>Equipment ID</label>
                    <input type="text" id="equipmentID" name="equipmentID" required>

                    <label>Type of Equipment</label>
                    <select id="equipmentType" name="equipmentType" required>
                        <option value="">-- Select Type --</option>
                        <option value="PM">Prime Mover</option>
                        <option value="RTG">Rubber Tyred Gantry</option>
                        <option value="QC">Quay Crane</option>
                    </select>

                    <label>Code</label>
                    <input type="text" id="equipmentCode" name="equipmentCode" required>

                    <label>Status</label>
                    <select id="equipmentStatus" name="equipmentStatus">
                        <option>Available</option>
                        <option>In Use</option>
                        <option>Maintenance</option>
                        <option>Out of Service</option>
                    </select>

                    <label>Location</label>
                    <input type="text" id="location" name="location" required>

                    <div class="button-group">
                        <button type="submit" class="btn">Save</button>
                        <button type="button" class="btn secondary" onclick="closeModal()">Cancel</button>
                    </div>

                </form>

            </div>
        </div>

        <script>
            function openAddModal() {
                document.getElementById("equipmentModal").style.display = "block";
                document.getElementById("modalTitle").innerText = "Add Equipment";
                document.getElementById("equipmentForm").action = "equipmentAdd";

                document.getElementById("equipmentID").value = "";
                document.getElementById("equipmentID").readOnly = false;
            }

            function openEditModal(id, type, code, status, location) {
                document.getElementById("equipmentModal").style.display = "block";
                document.getElementById("modalTitle").innerText = "Edit Equipment";
                document.getElementById("equipmentForm").action = "equipmentUpdate";

                document.getElementById("equipmentID").value = id;
                document.getElementById("equipmentID").readOnly = true;

                document.getElementById("equipmentIDOld").value = id;
                document.getElementById("equipmentType").value = type;
                document.getElementById("equipmentCode").value = code;
                document.getElementById("equipmentStatus").value = status;
                document.getElementById("location").value = location;
            }

            function closeModal() {
                document.getElementById("equipmentModal").style.display = "none";
            }

            window.onclick = function (event) {
                let modal = document.getElementById("equipmentModal");
                if (event.target == modal)
                    modal.style.display = "none";
            }
        </script>

    </body>
</html>