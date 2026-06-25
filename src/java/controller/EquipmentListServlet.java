package controller;
import dao.EquipmentDAO;
import model.Equipment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/equipmentList")
public class EquipmentListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EquipmentDAO dao = new EquipmentDAO();
        List<Equipment> list = dao.getAllEquipment();
        request.setAttribute("equipmentList", list);
        request.getRequestDispatcher("equipmentList.jsp").forward(request, response);
    }
}