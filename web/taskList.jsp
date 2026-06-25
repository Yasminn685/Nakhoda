<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.Task"%>

<%
    List<Task> taskList = (List<Task>) request.getAttribute("taskList");
    if (taskList == null) {
        taskList = new ArrayList<>();
    }

    String role = (String) session.getAttribute("role");
    String name = (String) session.getAttribute("name");

    if (role == null) {
        role = "manager";
    }
    if (name == null) {
        name = "Demo User";
    }

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
        <title>Manage Task | NAKHODA</title>

        <link rel="stylesheet" href="assets/css/dashboard.css">

        <style>

            body{
                margin:0;
                background:#f4f7fb;
                font-family:'Segoe UI', sans-serif;
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
                padding:15px 20px;
                border-radius:12px;
                display:flex;
                justify-content:space-between;
                align-items:center;
                margin-bottom:20px;
            }

            .header-nav a{
                color:white;
                text-decoration:none;
                font-weight:600;
            }

            /* CARD */
            .card{
                background:white;
                padding:25px;
                border-radius:14px;
                box-shadow:0 6px 18px rgba(0,0,0,0.08);
            }

            /* BUTTON */
            .btn{
                background:linear-gradient(135deg,#1e88e5,#0b2a4a);
                color:white;
                border:none;
                padding:10px 16px;
                border-radius:10px;
                cursor:pointer;
                font-weight:600;
            }

            .btn.secondary{
                background:#6c757d;
            }

            /* TABLE */
            table{
                width:100%;
                border-collapse:collapse;
                margin-top:10px;
            }

            th{
                background:#1e88e5;
                color:white;
                padding:12px;
                text-align:left;
            }

            td{
                padding:12px;
                border-bottom:1px solid #eee;
            }

            tr:hover{
                background:#f2f7ff;
            }

            /* DELETE BUTTON */
            .action-delete{
                background:#dc3545;
                color:white;
                padding:6px 10px;
                border-radius:8px;
                text-decoration:none;
                font-size:12px;
            }

            /* TOP ACTION */
            .top-actions{
                margin:10px 0 15px 0;
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
                background:rgba(0,0,0,0.6);
            }

            .modal-content{
                background:white;
                width:520px;
                max-width:90%;
                margin:70px auto;
                padding:25px;
                border-radius:14px;
                box-shadow:0 10px 25px rgba(0,0,0,0.2);
            }

            label{
                display:block;
                margin-top:12px;
                font-weight:600;
                color:#333;
            }

            input,select,textarea{
                width:100%;
                padding:10px;
                border-radius:8px;
                border:1px solid #ddd;
                margin-top:5px;
            }

            textarea{
                min-height:90px;
            }

            .button-group{
                margin-top:20px;
                display:flex;
                gap:10px;
            }

        </style>

    </head>

    <body>

        <div class="layout">

            <!-- SIDEBAR -->
            <jsp:include page="includes/sidebar.jsp" />

            <div class="content">

                <!-- HEADER -->
                <div class="header-nav">

                    <div>
                        <b>NAKHODA</b> — Task Management
                    </div>

                    <a href="<%=dashboardPage%>">
                        ⬅ Back
                    </a>

                </div>

                <!-- CARD -->
                <div class="card">

                    <h2>📋 Task List</h2>

                    <div class="top-actions">

                        <button class="btn" onclick="openAddModal()">
                            ➕ Add Task
                        </button>

                    </div>

                    <table>

                        <thead>
                            <tr>
                                <th>Task ID</th>
                                <th>Task Name</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody>

                            <% for (Task t : taskList) {%>

                            <tr>
                                <td><%=t.getTaskID()%></td>
                                <td><%=t.getTaskName()%></td>
                                <td><%=t.getTaskDescription()%></td>
                                <td><%=t.getTaskStatus()%></td>

                                <td>
                                    <a class="action-delete"
                                       href="taskDelete?taskID=<%=t.getTaskID()%>"
                                       onclick="return confirm('Delete this task?');">
                                        Delete
                                    </a>
                                </td>
                            </tr>

                            <% }%>

                        </tbody>

                    </table>

                </div>

            </div>
        </div>

        <!-- MODAL -->
        <div id="addModal" class="modal">

            <div class="modal-content">

                <h3>➕ Add New Task</h3>

                <form action="taskAdd" method="post">

                    <label>Task ID</label>
                    <input type="text" name="taskID" required>

                    <label>Task Name</label>
                    <input type="text" name="taskName" required>

                    <label>Description</label>
                    <textarea name="taskDescription"></textarea>

                    <label>Status</label>
                    <select name="taskStatus">
                        <option>Pending</option>
                        <option>In Progress</option>
                        <option>Completed</option>
                    </select>

                    <div class="button-group">
                        <button class="btn" type="submit">Save Task</button>
                        <button class="btn secondary" type="button" onclick="closeAddModal()">Cancel</button>
                    </div>

                </form>

            </div>

        </div>

        <script>

            function openAddModal() {
                document.getElementById("addModal").style.display = "block";
            }

            function closeAddModal() {
                document.getElementById("addModal").style.display = "none";
            }

            window.onclick = function (event) {
                let modal = document.getElementById("addModal");
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            }

        </script>

    </body>
</html>