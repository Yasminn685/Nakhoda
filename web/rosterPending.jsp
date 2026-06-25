<%-- 
    Document   : rosterPending
    Created on : 20 Jan 2026, 10:18:46 AM
    Author     : yasmi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dao.RosterDAO"%>
<%@page import="model.Roster"%>

<%
  String name = (String) session.getAttribute("name");
  String role = (String) session.getAttribute("role");
  if(name == null) name = "Demo Manager";
  if(role == null) role = "Manager";

  RosterDAO dao = new RosterDAO();
  List<Roster> pending = dao.getPendingRoster();
%>

<!DOCTYPE html>
<html>
<head>
  <title>Pending Rosters | NAKHODA</title>
  <style>
    body{font-family:Arial;margin:0;background:#f5f7fb;}
    .top{display:flex;justify-content:space-between;align-items:center;padding:16px 20px;background:#0b2a4a;color:#fff;}
    .btn{background:#1e88e5;color:#fff;padding:10px 14px;border-radius:10px;text-decoration:none;border:none;cursor:pointer}
    .btn.gray{background:#445;}
    .wrap{padding:18px 20px;}
    .card{background:#fff;border-radius:14px;padding:16px;box-shadow:0 10px 24px rgba(0,0,0,.06)}
    table{width:100%;border-collapse:collapse;margin-top:10px}
    th,td{padding:10px;border-bottom:1px solid #eee;text-align:left;font-size:14px}
    .tag{padding:4px 10px;border-radius:999px;background:#fff3cd;display:inline-block}
  </style>
</head>
<body>

<div class="top">
  <div><b>NAKHODA</b> — Pending Rosters (Supervisor)</div>
  <div>
    <%
    String dashboardPage = "managerDashboard.jsp";

    if("supervisor".equalsIgnoreCase(role)){
        dashboardPage = "supervisorDashboard.jsp";
    }
    else if("operator".equalsIgnoreCase(role)){
        dashboardPage = "operatorDashboard.jsp";
    }
%>

<a class="btn gray" href="<%=dashboardPage%>">Back</a>
  </div>
</div>

<div class="wrap">
  <div class="card">
    <h3>Pending Approval List</h3>

    <table>
      <thead>
        <tr>
          <th>Roster ID</th>
          <th>User ID</th>
          <th>Shift</th>
          <th>Time</th>
          <th>Date</th>
          <th>Action</th>
        </tr>
      </thead>

      <tbody>
      <%
        if(pending == null || pending.isEmpty()){
      %>
        <tr><td colspan="6">No pending roster.</td></tr>
      <%
        } else {
            for(Roster r : pending){
      %>
        <tr>
          <td><%=r.getRosterID()%></td>
          <td><%=r.getUserID()%></td>
          <td><%=r.getShiftName()%></td>
          <td><%=r.getStartTime()%> - <%=r.getEndTime()%></td>
          <td><%=r.getShiftDate()%></td>
          <td><span class="tag"><%=r.getStatus()%></span></td>
          <td>
            <a class="btn"href="rosterApprove?rosterID=<%=r.getRosterID()%>&status=Approved">Approve</a>
            <a class="btn gray"href="rosterApprove?rosterID=<%=r.getRosterID()%>&status=Rejected">Reject</a>
          </td>
        </tr>
      <%
            }
        }
      %>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>