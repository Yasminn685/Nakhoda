<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="dao.UserDAO"%>

<%
UserDAO dao = new UserDAO();

request.setAttribute("totalOps", dao.countOperators(""));
request.setAttribute("activeOps",
        dao.countOperators("AND status='active'"));
request.setAttribute("inactiveOps",
        dao.countOperators("AND status='inactive'"));
%>

<%
String name = (String) session.getAttribute("name");
String role = (String) session.getAttribute("role");

if (name == null) name = "Demo User";

if (role == null || !role.equalsIgnoreCase("manager")) {
    response.sendRedirect("login.jsp?err=unauthorized");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>
  <title>Manager Dashboard | NAKHODA</title>

  <link rel="stylesheet" href="assets/css/dashboard.css">
  <script src="assets/js/dashboard.js"></script>

  <style>

  body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background: #f4f7fb;
  }

  .layout {
      display: flex;
      min-height: 100vh;
  }

  .content {
      flex: 1;
      padding: 20px;
  }

  /* TOPBAR */
  .topbar {
      background: linear-gradient(135deg, #0b2a4a, #1e88e5);
      color: white;
      padding: 15px 20px;
      border-radius: 12px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
  }

  .badge {
      background: #1e88e5;
      padding: 8px 12px;
      border-radius: 50%;
      font-weight: bold;
      color: white;
  }

  /* GRID */
  .grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 15px;
      margin-bottom: 20px;
  }

  /* CARD */
  .card {
      background: white;
      border-radius: 14px;
      padding: 18px;
      box-shadow: 0 6px 18px rgba(0,0,0,0.08);
      transition: 0.3s;
      text-align: center;
  }

  .card:hover {
      transform: translateY(-3px);
  }

  .card h3 {
      margin: 0;
      font-size: 14px;
      color: #777;
  }

  .value {
      font-size: 28px;
      font-weight: bold;
      color: #1e88e5;
      margin-top: 8px;
  }

  /* KPI ICON */
  .kpi-icon {
      font-size: 30px;
      margin-bottom: 5px;
  }

  /* TWO COL */
  .two-col {
      display: grid;
      grid-template-columns: 1.5fr 1fr;
      gap: 15px;
  }

  /* TABLE */
  table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
  }

  th {
      background: #1e88e5;
      color: white;
      padding: 12px;
      text-align: left;
  }

  td {
      padding: 12px;
      border-bottom: 1px solid #eee;
  }

  tr:hover {
      background: #f2f7ff;
  }

  /* PILL */
  .pill {
      display: inline-block;
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: bold;
      background: #e3f2fd;
      color: #1565c0;
  }

  .pill.success {
      background: #e8f5e9;
      color: #2e7d32;
  }

  .pill.danger {
      background: #ffebee;
      color: #c62828;
  }

  /* BUTTON */
  .link-btn {
      background: none;
      border: none;
      color: #1e88e5;
      font-weight: bold;
      cursor: pointer;
  }

  /* TOAST */
  .toast {
      visibility: hidden;
      min-width: 250px;
      background: #1e88e5;
      color: white;
      text-align: center;
      border-radius: 8px;
      padding: 12px;
      position: fixed;
      z-index: 9999;
      bottom: 30px;
      right: 30px;
      opacity: 0;
      transition: 0.4s;
  }

  .toast.show {
      visibility: visible;
      opacity: 1;
  }
  
  .form-card {
    text-align: left;
}

.modern-form {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
}

.input-group {
    display: flex;
    flex-direction: column;
}

.input-group.full {
    grid-column: 1 / -1;
}

.input-group label {
    font-size: 12px;
    font-weight: bold;
    color: #555;
    margin-bottom: 5px;
}

.input-group input,
.input-group select {
    padding: 10px 12px;
    border-radius: 10px;
    border: 1px solid #ddd;
    outline: none;
    transition: 0.2s;
    font-size: 14px;
}

.input-group input:focus,
.input-group select:focus {
    border-color: #1e88e5;
    box-shadow: 0 0 6px rgba(30,136,229,0.3);
}

.form-actions {
    grid-column: 1 / -1;
    display: flex;
    gap: 10px;
    margin-top: 5px;
}

/* BUTTON STYLE IMPROVED */
.btn.primary {
    background: linear-gradient(135deg, #1e88e5, #0b2a4a);
    color: white;
    border: none;
    padding: 10px 14px;
    border-radius: 10px;
    cursor: pointer;
    font-weight: bold;
}

.btn.secondary {
    background: #e0e0e0;
    color: #333;
    border: none;
    padding: 10px 14px;
    border-radius: 10px;
    cursor: pointer;
}

  </style>
</head>

<body>

<div class="layout">

  <aside class="sidebar">
    <%@ include file="includes/sidebar.jsp" %>
  </aside>

  <main class="content">

    <!-- TOAST -->
    <div id="toast" class="toast"></div>

    <!-- TOPBAR -->
    <div class="topbar">
      <div style="font-weight:900;">Operational Overview (Manager)</div>
      <div class="badge">M</div>
    </div>

    <!-- KPI -->
    <section class="grid">

      <div class="card">
        <div class="kpi-icon">👥</div>
        <h3>Total Operators</h3>
        <div class="value count" data-target="${totalOps}">0</div>
      </div>

      <div class="card">
        <div class="kpi-icon" style="color:#2e7d32;">🟢</div>
        <h3>Active Operators</h3>
        <div class="value count" data-target="${activeOps}">0</div>
      </div>

      <div class="card">
        <div class="kpi-icon" style="color:#c62828;">🔴</div>
        <h3>Inactive Operators</h3>
        <div class="value count" data-target="${inactiveOps}">0</div>
      </div>

      <div class="card">
        <div class="kpi-icon">⚙️</div>
        <h3>System Status</h3>
        <div class="value">ONLINE</div>
      </div>

    </section>

    <!-- CONTENT -->
    <section class="two-col">

      <!-- TABLE -->
      <div class="card">

        <h3 style="text-align:left;">Operators List</h3>

        <table>
          <thead>
            <tr>
              <th>User ID</th>
              <th>Name</th>
              <th>Status</th>
              <th>Action</th>
            </tr>
          </thead>

          <tbody>

            <c:forEach var="op" items="${operatorList}">
              <tr>

                <td>${op.userID}</td>
                <td>${op.name}</td>

                <td>
                  <span class="pill ${op.status == 'active' ? 'success' : 'danger'}">
                      ${op.status}
                  </span>
                </td>

                <td>
                  <form action="toggleUserStatus" method="post">
                    <input type="hidden" name="userID" value="${op.userID}">
                    <input type="hidden" name="status"
                           value="${op.status == 'active' ? 'inactive' : 'active'}">

                    <button class="link-btn" type="submit">
                      ${op.status == 'active' ? 'Deactivate' : 'Activate'}
                    </button>

                  </form>
                </td>

              </tr>
            </c:forEach>

          </tbody>
        </table>

      </div>

      <!-- FORM -->
      <div class="card form-card">

    <h3 style="text-align:left; margin-bottom:15px;">
        Add New Operator
    </h3>

    <form action="addUser" method="post" class="modern-form">

        <div class="input-group">
            <label>Full Name</label>
            <input name="name" placeholder="Enter full name" required>
        </div>

        <div class="input-group">
            <label>Email Address</label>
            <input name="email" type="email" placeholder="example@email.com" required>
        </div>

        <div class="input-group">
            <label>Phone Number</label>
            <input name="phoneNo" placeholder="e.g. 012-3456789" required>
        </div>

        <div class="input-group">
            <label>Role</label>
            <select name="role">
                <option value="operator">Operator</option>
                <option value="supervisor">Supervisor</option>
            </select>
        </div>

        <div class="input-group full">
            <label>Password</label>
            <input name="password" type="password" placeholder="Create secure password" required>
        </div>

        <div class="form-actions">
            <button class="btn primary" type="submit">➕ Create User</button>
            <button class="btn secondary" type="reset">Reset</button>
        </div>

    </form>

</div>

    </section>

    <!-- SUCCESS MESSAGE TRIGGER -->
    <c:if test="${param.msg == 'updated'}">
      <script>
        window.onload = function () {
            showToast("User status updated successfully");
        };
      </script>
    </c:if>

  </main>

</div>

<script>

// COUNTER ANIMATION
document.addEventListener("DOMContentLoaded", function () {

    const counters = document.querySelectorAll(".count");

    counters.forEach(counter => {
        const target = +counter.getAttribute("data-target");
        let current = 0;

        const step = Math.ceil(target / 60);

        const update = () => {
            current += step;

            if (current >= target) {
                counter.innerText = target;
            } else {
                counter.innerText = current;
                requestAnimationFrame(update);
            }
        };

        update();
    });

});

// TOAST
function showToast(message) {
    const toast = document.getElementById("toast");
    toast.innerText = message;
    toast.className = "toast show";

    setTimeout(() => {
        toast.className = toast.className.replace("show", "");
    }, 2500);
}

</script>

</body>
</html>