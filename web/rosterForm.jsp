<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.UserDAO"%>
<%@page import="dao.TaskDAO"%>
<%@page import="model.User"%>
<%@page import="model.Task"%>
<%@page import="java.util.List"%>

<%
    UserDAO userDAO = new UserDAO();
    List<User> operators = userDAO.getAllOperators();

    TaskDAO taskDAO = new TaskDAO();
    List<Task> tasks = taskDAO.getAllTask();

    String err = request.getParameter("err");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Create Roster | NAKHODA</title>
        <link rel="stylesheet" href="assets/css/dashboard.css">

        <!-- ONLY ADD SHIFT CARD STYLE (NO TOUCH ORIGINAL STYLE) -->
        <style>
            .shift-grid{
                display:grid;
                grid-template-columns:repeat(3,1fr);
                gap:12px;
                margin-top:10px;
            }

            .shift-card{
                background:white;
                border:2px solid #e6e6e6;
                border-radius:12px;
                padding:12px;
                text-align:center;
                cursor:pointer;
                transition:0.2s;
                font-weight:600;
            }

            .shift-card:hover{
                border-color:#1e88e5;
                transform:translateY(-2px);
            }

            .shift-card.active{
                border-color:#1e88e5;
                background:#eaf3ff;
            }

            .shift-time{
                font-size:12px;
                color:#666;
                margin-top:4px;
            }
        </style>
    </head>

    <body>

        <div class="layout">

            <%@ include file="includes/sidebar.jsp" %>

            <main class="content">

                <div class="topbar">
                    <div style="font-weight:900;">
                        Create New Roster
                    </div>
                </div>

                <section class="card">

                    <form action="<%=request.getContextPath()%>/rosterAdd"
                          method="post">

                        <div class="form-grid">

                            <!-- Roster ID -->
                            <div class="input">
                                <label>Roster ID</label>
                                <input type="text" name="rosterID" required>
                            </div>

                            <!-- Operator -->
                            <div class="input">
                                <label>Assign Operator</label>
                                <select name="userID" required>
                                    <option value="">Select Operator</option>
                                    <% for (User u : operators) {%>
                                    <option value="<%=u.getUserID()%>">
                                        <%=u.getName()%>
                                    </option>
                                    <% } %>
                                </select>
                            </div>

                            <!-- Task -->
                            <div class="input">
                                <label>Assign Task</label>
                                <select name="taskID" required>
                                    <option value="">Select Task</option>
                                    <% for (Task t : tasks) {%>
                                    <option value="<%=t.getTaskID()%>">
                                        <%=t.getTaskName()%>
                                    </option>
                                    <% }%>
                                </select>
                            </div>

                            <!-- SHIFT CARDS -->
                            <div class="input">
                                <label>Shift</label>

                                <div class="shift-grid">

                                    <div class="shift-card" onclick="selectShift('Morning', this)">
                                        🌅 Morning
                                        <div class="shift-time">08:00 - 16:00</div>
                                    </div>

                                    <div class="shift-card" onclick="selectShift('Evening', this)">
                                        🌇 Evening
                                        <div class="shift-time">16:00 - 00:00</div>
                                    </div>

                                    <div class="shift-card" onclick="selectShift('Night', this)">
                                        🌙 Night
                                        <div class="shift-time">00:00 - 08:00</div>
                                    </div>

                                </div>
                            </div>

                            <!-- HIDDEN AUTO VALUES -->
                            <input type="hidden" name="shiftName" id="shiftName">
                            <input type="hidden" name="startTime" id="startTime">
                            <input type="hidden" name="endTime" id="endTime">

                            <!-- Shift Date -->
                            <div class="input">
                                <label>Shift Date</label>
                                <input type="date"
                                       name="shiftDate"
                                       required
                                       min="<%= java.time.LocalDate.now()%>">
                            </div>

                            <!-- Status -->
                            <div class="input">
                                <label>Status</label>
                                <select name="status">
                                    <option value="Scheduled">Scheduled</option>
                                    <option value="Assigned">Assigned</option>
                                    <option value="Completed">Completed</option>
                                </select>
                            </div>

                        </div>

                        <div style="margin-top:15px; display:flex; gap:10px;">
                            <button class="btn" type="submit">Save Roster</button>
                            <button class="btn secondary" type="reset">Reset</button>
                        </div>

                    </form>

                </section>

            </main>

        </div>

        <script>
            function selectShift(shift, el) {

                document.querySelectorAll('.shift-card')
                        .forEach(c => c.classList.remove('active'));

                el.classList.add('active');

                document.getElementById("shiftName").value = shift;

                let start = "";
                let end = "";

                if (shift === "Morning") {
                    start = "08:00";
                    end = "16:00";
                } else if (shift === "Evening") {
                    start = "16:00";
                    end = "00:00";
                } else if (shift === "Night") {
                    start = "00:00";
                    end = "08:00";
                }

                document.getElementById("startTime").value = start;
                document.getElementById("endTime").value = end;
            }
        </script>

    </body>
</html>