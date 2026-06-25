package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String userID = (String) session.getAttribute("userID");

        if(userID == null){
            response.sendRedirect("login.jsp");
            return;
        }

        UserDAO dao = new UserDAO();
        User u = dao.getUserByID(userID);

        request.setAttribute("user", u);

        RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
        rd.forward(request, response);
    }
}