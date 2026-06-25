package controller;

import dao.RosterDAO;
import dao.TaskDAO;
import model.Roster;
import model.Task;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/operatorDashboard")
public class OperatorDashboardServlet extends HttpServlet {

    private RosterDAO rosterDAO;
    private TaskDAO taskDAO;

    @Override
    public void init() throws ServletException {
        rosterDAO = new RosterDAO();
        taskDAO = new TaskDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String userID = (String) session.getAttribute("userID");
        String role = (String) session.getAttribute("role");
        String name = (String) session.getAttribute("name");

        // SECURITY CHECK
        if (userID == null || role == null ||
                !"operator".equalsIgnoreCase(role)) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        // LOAD DATA
        List<Roster> rosterList = rosterDAO.getRosterByUser(userID);
        List<Task> taskList = taskDAO.getTaskByUser(userID);

        // KPI VARIABLES
        int pendingTasksCount = 0;
        String todayShift = "No Shift Today";
        String todayTime = "-";

        // FIND TODAY ROSTER (FIXED LOGIC)
        java.time.LocalDate today = java.time.LocalDate.now();

        for (Roster r : rosterList) {

            if (r.getShiftDate() != null &&
                r.getShiftDate().toString().equals(today.toString())) {

                todayShift = r.getShiftName();
                todayTime = r.getStartTime() + " - " + r.getEndTime();
                break;
            }
        }

        // COUNT PENDING TASKS
        for (Task t : taskList) {

            if (t.getTaskStatus() != null &&
                "Pending".equalsIgnoreCase(t.getTaskStatus())) {

                pendingTasksCount++;
            }
        }

        // SET ATTRIBUTES FOR JSP
        request.setAttribute("rosters", rosterList);
        request.setAttribute("tasks", taskList);

        request.setAttribute("pendingCount", pendingTasksCount);
        request.setAttribute("todayShift", todayShift);
        request.setAttribute("todayTime", todayTime);
        request.setAttribute("operatorName", name);

        // FORWARD TO JSP
        request.getRequestDispatcher("/operatorDashboard.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String role = (String) session.getAttribute("role");
        String userID = (String) session.getAttribute("userID");

        // SECURITY CHECK
        if (role == null ||
                !"operator".equalsIgnoreCase(role)) {

            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");

        if ("updateStatus".equals(action)) {

            String taskID = request.getParameter("taskID");
            String newStatus = request.getParameter("newStatus");

            if (taskID != null && newStatus != null) {

                boolean success = taskDAO.updateTaskStatus(taskID, newStatus);

                if (success) {

                    response.sendRedirect(
                            request.getContextPath() +
                            "/operatorDashboard?msg=success");

                } else {

                    response.sendRedirect(
                            request.getContextPath() +
                            "/operatorDashboard?msg=failed");
                }

                return;
            }
        }

        // fallback
        response.sendRedirect(
                request.getContextPath() + "/operatorDashboard");
    }
}