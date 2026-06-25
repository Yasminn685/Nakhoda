package controller;

import dao.UserDAO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/operators")
public class OperatorListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO dao = new UserDAO();

        // ambil semua operator dari database
        request.setAttribute("operatorList", dao.getAllOperators());

        // pergi ke page operator list
        request.getRequestDispatcher("operatorList.jsp")
               .forward(request, response);
    }
}