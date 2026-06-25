package controller;

import dao.UserDAO;
import dao.TaskDAO;
import dao.RosterDAO;
import dao.EquipmentDAO;

import model.Roster;
import model.Task;
import model.User;
import model.Equipment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/supervisorDashboard")
public class SupervisorDashboardServlet extends HttpServlet {

    private UserDAO userDAO;
    private TaskDAO taskDAO;
    private RosterDAO rosterDAO;
    private EquipmentDAO equipmentDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        taskDAO = new TaskDAO();
        rosterDAO = new RosterDAO();
        equipmentDAO = new EquipmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String role = (String) session.getAttribute("role");

        // SECURITY CHECK
        if (role == null || !"supervisor".equalsIgnoreCase(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ================= KPI =================
        request.setAttribute("availableEquipment",
                equipmentDAO.countByStatus("Available"));

        request.setAttribute("inUseEquipment",
                equipmentDAO.countByStatus("In Use"));

        request.setAttribute("maintenanceEquipment",
                equipmentDAO.countByStatus("Maintenance"));

        request.setAttribute("pendingTasks",
                taskDAO.countByStatus("Pending"));

        // ================= DATA =================
        List<User> operators = userDAO.getAllOperators();
        List<Task> tasks = taskDAO.getAllTask();
        List<Roster> todayRoster = rosterDAO.getTodayRoster();
        List<Roster> rosterCalendar = rosterDAO.getAllRoster();

        request.setAttribute("operatorList", operators);
        request.setAttribute("taskList", tasks);
        request.setAttribute("todayRoster", todayRoster);
        request.setAttribute("rosterCalendar", rosterCalendar);

        request.getRequestDispatcher("supervisorDashboard.jsp")
                .forward(request, response);
    }
}