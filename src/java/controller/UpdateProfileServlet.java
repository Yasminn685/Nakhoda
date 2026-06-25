package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String userID = (String) session.getAttribute("userID");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNo = request.getParameter("phoneNo");

        User u = new User();

        u.setUserID(userID);
        u.setName(name);
        u.setEmail(email);
        u.setPhoneNo(phoneNo);

        UserDAO dao = new UserDAO();

        boolean ok = dao.updateProfile(u);

        if (ok) {

            // update session values
            session.setAttribute("name", name);

            User updatedUser
                    = dao.getUserByID(userID);

            session.setAttribute("user", updatedUser);
            session.setAttribute("name", updatedUser.getName());
            session.setAttribute("role", updatedUser.getRole());

            response.sendRedirect("profile.jsp?success=1");

        } else {

            response.sendRedirect("profile.jsp?error=1");

        }
    }
}
