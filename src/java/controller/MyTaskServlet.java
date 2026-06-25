package controller;

import dao.TaskDAO;
import model.Task;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/myTask")
public class MyTaskServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userID = (String) request.getSession().getAttribute("userID");
        String taskID = request.getParameter("taskID");

        TaskDAO dao = new TaskDAO();

        List<Task> taskList;

        // IF click from calendar (single task view)
        if (taskID != null && !taskID.isEmpty()) {
            Task t = dao.getTaskByID(taskID);
            taskList = java.util.Arrays.asList(t);
        } 
        else {
            taskList = dao.getTaskByUser(userID);
        }

        request.setAttribute("taskList", taskList);
        request.getRequestDispatcher("myTask.jsp").forward(request, response);
    }
}