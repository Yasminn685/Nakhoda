<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="util.DBConnection"%>

<h2>DB Proof (Shift)</h2>

<%
    Connection conn = DBConnection.getConnection();
    if(conn == null){
        out.println("<p style='color:red'>❌ Connection = NULL</p>");
        return;
    }
    out.println("<p style='color:green'>✅ Connected: " + conn.getMetaData().getURL() + "</p>");

    // 1) Insert sample (only once)
    String insert = "INSERT INTO shift (shiftID, shiftName, startTime, endTime, shiftDate, status) " +
                    "SELECT ?,?,?,?,?,? FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM shift WHERE shiftID=?)";
    PreparedStatement ps = conn.prepareStatement(insert);
    ps.setString(1, "SH_DEMO");
    ps.setString(2, "Morning Ops Demo");
    ps.setTime(3, java.sql.Time.valueOf("08:00:00"));
    ps.setTime(4, java.sql.Time.valueOf("16:00:00"));
    ps.setDate(5, java.sql.Date.valueOf("2026-01-20"));
    ps.setString(6, "Scheduled");
    ps.setString(7, "SH_DEMO");
    int rows = ps.executeUpdate();
    out.println("<p>Insert result: " + rows + " row(s)</p>");
    ps.close();

    // 2) Select & display
    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery("SELECT shiftID, shiftName, shiftDate, startTime, endTime, status FROM shift ORDER BY shiftDate DESC");

    out.println("<table border='1' cellpadding='8' cellspacing='0'>");
    out.println("<tr><th>ID</th><th>Name</th><th>Date</th><th>Start</th><th>End</th><th>Status</th></tr>");
    while(rs.next()){
        out.println("<tr>");
        out.println("<td>"+rs.getString("shiftID")+"</td>");
        out.println("<td>"+rs.getString("shiftName")+"</td>");
        out.println("<td>"+rs.getDate("shiftDate")+"</td>");
        out.println("<td>"+rs.getTime("startTime")+"</td>");
        out.println("<td>"+rs.getTime("endTime")+"</td>");
        out.println("<td>"+rs.getString("status")+"</td>");
        out.println("</tr>");
    }
    out.println("</table>");

    rs.close();
    st.close();
    conn.close();
%>