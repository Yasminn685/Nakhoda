package controller;

import dao.IndexDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "IndexServlet", urlPatterns = {"/index"})
public class IndexServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        IndexDAO dao = new IndexDAO();

        try {
            // =========================
            // GET DATA FROM DAO
            // =========================
            int totalOperators = dao.countOperators();
            int totalTasks = dao.countTasks();
            int totalEquipment = dao.countEquipment();
            int totalRosters = dao.countRosters();

            // =========================
            // SET TO JSP
            // =========================
            request.setAttribute("totalOperators", totalOperators);
            request.setAttribute("totalTasks", totalTasks);
            request.setAttribute("totalEquipment", totalEquipment);
            request.setAttribute("totalRosters", totalRosters);

            // optional debug
            System.out.println("Index loaded:");
            System.out.println("Operators: " + totalOperators);
            System.out.println("Tasks: " + totalTasks);
            System.out.println("Equipment: " + totalEquipment);
            System.out.println("Rosters: " + totalRosters);

            // =========================
            // FORWARD TO JSP
            // =========================
            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

            // fallback kalau error
            request.setAttribute("totalOperators", 0);
            request.setAttribute("totalTasks", 0);
            request.setAttribute("totalEquipment", 0);
            request.setAttribute("totalRosters", 0);

            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Index Controller for NAKHODA System";
    }
}