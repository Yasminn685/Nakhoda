<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.time.LocalDate"%>
<%@page import="model.Task"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    String userID = (String) session.getAttribute("userID");
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");

    if (name == null) name = "Operator";
    if (role == null) role = "operator";

    java.time.LocalDate today = java.time.LocalDate.now();
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Task | NAKHODA</title>

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

        .card{
            background:white;
            padding:20px;
            border-radius:14px;
            box-shadow:0 6px 18px rgba(0,0,0,0.06);
        }

        table{
            width:100%;
            border-collapse:collapse;
        }

        th{
            background:#f1f3f5;
            padding:12px;
            text-align:left;
        }

        td{
            padding:12px;
            border-bottom:1px solid #eee;
        }

        .btn{
            border:none;
            padding:7px 12px;
            border-radius:8px;
            cursor:pointer;
            font-weight:600;
            font-size:13px;
            color:white;
            background:#1e88e5;
        }

        .btn:hover{
            opacity:0.9;
        }

        .btn.orange{ background:#ff9800; }
        .btn.green{ background:#4caf50; }

        .btn:disabled{
            opacity:0.4;
            cursor:not-allowed;
        }

        .modal{
            display:none;
            position:fixed;
            top:0;
            left:0;
            width:100%;
            height:100%;
            background:rgba(0,0,0,0.55);
            z-index:9999;
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

    </style>

    <script>

        function openModal(id, name, desc, status, taskDate){

            document.getElementById("m_taskID").innerText = id;
            document.getElementById("m_taskName").innerText = name;
            document.getElementById("m_taskDesc").innerText = desc;
            document.getElementById("m_taskStatus").innerText = status;

            let today = new Date();
            let tDate = new Date(taskDate);

            today.setHours(0,0,0,0);
            tDate.setHours(0,0,0,0);

            let state = "UPCOMING";

            if(tDate < today){
                state = "OVERDUE";
            } else if(tDate.getTime() === today.getTime()){
                state = "ACTIVE";
            }

            let buttons = document.querySelectorAll(".modal button");

            if(state === "OVERDUE" || status === "Done"){
                buttons.forEach(b=>{
                    b.disabled = true;
                });
            } else {
                buttons.forEach(b=>{
                    b.disabled = false;
                });
            }

            document.getElementById("taskModal").style.display = "block";
        }

        function closeModal(){
            document.getElementById("taskModal").style.display = "none";
        }

        window.onclick = function(event){
            if(event.target === document.getElementById("taskModal")){
                closeModal();
            }
        }

    </script>

</head>

<body>

<div class="layout">

    <%@ include file="includes/sidebar.jsp" %>

    <main class="content">

        <div class="topbar">
            <div style="font-weight:900;">My Tasks</div>
            <div><%=name%></div>
        </div>

        <section class="card">

            <table>

                <thead>
                <tr>
                    <th>Task ID</th>
                    <th>Name</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody>

                <%
                    List<Task> taskList =
                        (List<Task>) request.getAttribute("taskList");

                    if(taskList != null){
                        for(Task t : taskList){

                            String status = t.getTaskStatus();
                            String taskDate = "2026-06-26"; // fallback kalau belum ada date field
                %>

                <tr>

                    <td><%=t.getTaskID()%></td>
                    <td><%=t.getTaskName()%></td>
                    <td><%=status%></td>

                    <td style="display:flex;gap:8px;">

                        <button class="btn"
                            onclick="openModal(
                                '<%=t.getTaskID()%>',
                                '<%=t.getTaskName()%>',
                                '<%=t.getTaskDescription()%>',
                                '<%=t.getTaskStatus()%>',
                                '<%=taskDate%>'
                            )">
                            View
                        </button>

                        <form action="updateTaskStatus" method="post">
                            <input type="hidden" name="taskID" value="<%=t.getTaskID()%>"/>
                            <input type="hidden" name="status" value="In Progress"/>

                            <button class="btn orange"
                                <%= "Done".equals(status) ? "disabled" : "" %>>
                                Start
                            </button>
                        </form>

                        <form action="updateTaskStatus" method="post">
                            <input type="hidden" name="taskID" value="<%=t.getTaskID()%>"/>
                            <input type="hidden" name="status" value="Done"/>

                            <button class="btn green"
                                <%= "Done".equals(status) ? "disabled" : "" %>>
                                Done
                            </button>
                        </form>

                    </td>
                </tr>

                <%
                        }
                    }
                %>

                </tbody>

            </table>

        </section>

    </main>
</div>

<!-- MODAL -->
<div id="taskModal" class="modal">

    <div class="modal-content">

        <span class="close" onclick="closeModal()">&times;</span>

        <h3>Task Details</h3>

        <p><b>ID:</b> <span id="m_taskID"></span></p>
        <p><b>Name:</b> <span id="m_taskName"></span></p>
        <p><b>Description:</b> <span id="m_taskDesc"></span></p>
        <p><b>Status:</b> <span id="m_taskStatus"></span></p>

    </div>

</div>

</body>
</html>