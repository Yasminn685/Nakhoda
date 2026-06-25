package controller;

import dao.TaskDAO;
import model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/taskAdd")
public class TaskAddServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String taskID = request.getParameter("taskID");
        String taskName = request.getParameter("taskName");
        String taskDescription = request.getParameter("taskDescription");
        String taskStatus = request.getParameter("taskStatus");

        if (taskID == null || taskID.trim().isEmpty() || taskName == null || taskName.trim().isEmpty()) {
            response.sendRedirect("taskList?err=1");
            return;
        }

        Task t = new Task(taskID, taskName, taskDescription, taskStatus);

        TaskDAO dao = new TaskDAO();;
        boolean ok = dao.addTask(t);

        if (ok) {
            response.sendRedirect("taskList");
        } else {
            response.sendRedirect("taskList?err=2");
        }
    }
}