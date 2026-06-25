/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RosterDAO;
import model.Roster;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/rosterList")
public class RosterListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RosterDAO dao = new RosterDAO();
        List<Roster> roster = dao.getAllRoster();

        request.setAttribute("roster", roster);
        request.getRequestDispatcher("rosterList.jsp").forward(request, response);
    }
}