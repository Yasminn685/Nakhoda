package controller;

import dao.UserDAO;
import model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/updateUser")
public class UpdateUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String userID = request.getParameter("userID");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNo = request.getParameter("phoneNo");
        String status = request.getParameter("status");

        User user = new User();
        user.setUserID(userID);
        user.setName(name);
        user.setEmail(email);
        user.setPhoneNo(phoneNo);
        user.setStatus(status);

        UserDAO dao = new UserDAO();

        boolean success = dao.updateUser(user);

        if (success) {
            response.sendRedirect("operators");
        } else {
            response.sendRedirect("operators?err=update");
        }
    }
}