<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");

    if (name == null) {
        name = "Demo User";
    }

    if (role == null || !role.equalsIgnoreCase("manager")) {
        response.sendRedirect("login.jsp?err=unauthorized");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Operators | NAKHODA</title>

    <link rel="stylesheet" href="assets/css/dashboard.css">

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

    /* GRID */
    .grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 15px;
        margin-bottom: 20px;
    }

    .card {
        background: white;
        border-radius: 14px;
        padding: 18px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.08);
    }

    /* TABLE */
    table {
        width: 100%;
        border-collapse: collapse;
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
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: bold;
    }

    .success {
        background: #e8f5e9;
        color: #2e7d32;
    }

    .danger {
        background: #ffebee;
        color: #c62828;
    }

    /* BUTTONS */
    .btn-add {
        background: #1e88e5;
        color: white;
        border: none;
        padding: 8px 14px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: bold;
    }

    .btn-edit {
        background: #f9a825;
        color: white;
        border: none;
        padding: 6px 12px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: bold;
    }

    .btn-delete {
        background: #e53935;
        color: white;
        border: none;
        padding: 6px 12px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: bold;
    }

    .btn-delete:hover {
        background: #c62828;
    }

    .btn-edit:hover {
        background: #f57f17;
    }

    /* MODAL */
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.5);
        z-index: 9999;
    }

    .modal-content {
        width: 500px;
        background: white;
        margin: 80px auto;
        padding: 25px;
        border-radius: 12px;
        position: relative;
    }

    .close {
        position: absolute;
        right: 15px;
        top: 10px;
        font-size: 24px;
        cursor: pointer;
    }

    .input {
        margin-bottom: 12px;
    }

    .input input,
    .input select {
        width: 100%;
        padding: 10px;
        border-radius: 8px;
        border: 1px solid #ddd;
    }

    .btn-save {
        background: linear-gradient(135deg, #1e88e5, #0b2a4a);
        color: white;
        border: none;
        padding: 10px 14px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: bold;
        width: 100%;
    }

    </style>

</head>

<body>

<div class="layout">

    <aside class="sidebar">
        <%@ include file="includes/sidebar.jsp" %>
    </aside>

    <main class="content">

        <!-- TOPBAR -->
        <div class="topbar">
            <div style="font-weight:900;">Operators Management</div>
            <div>Welcome, <b><%=name%></b></div>
        </div>

        <!-- KPI -->
        <section class="grid">

            <div class="card">
                <h3>Total Operators</h3>
                <div class="value">${operatorList.size()}</div>
            </div>

        </section>

        <!-- TABLE -->
        <section class="card">

            <div style="display:flex;justify-content:space-between;align-items:center;">
                <h3>Operators List</h3>

                <button class="btn-add"
                        onclick="document.getElementById('addModal').style.display='block'">
                    + Add Operator
                </button>
            </div>

            <table>

                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach var="op" items="${operatorList}">
                        <tr>

                            <td>${op.userID}</td>
                            <td>${op.name}</td>
                            <td>${op.email}</td>
                            <td>${op.phoneNo}</td>

                            <td>
                                <span class="pill ${op.status == 'active' ? 'success' : 'danger'}">
                                    ${op.status}
                                </span>
                            </td>

                            <td style="display:flex; gap:8px;">

                                <button class="btn-edit"
                                        onclick="openEditModal('${op.userID}', '${op.name}', '${op.email}', '${op.phoneNo}', '${op.status}')">
                                    Edit
                                </button>

                                <form action="toggleUserStatus" method="post">
                                    <input type="hidden" name="userID" value="${op.userID}">
                                    <input type="hidden" name="status" value="inactive">

                                    <button class="btn-delete"
                                            onclick="return confirm('Delete this user?')">
                                        Delete
                                    </button>
                                </form>

                            </td>

                        </tr>
                    </c:forEach>

                </tbody>

            </table>

        </section>

    </main>

</div>

<!-- ADD MODAL -->
<div id="addModal" class="modal">

    <div class="modal-content">

        <span class="close"
              onclick="document.getElementById('addModal').style.display='none'">
            ×
        </span>

        <h2>Add Operator</h2>

        <form action="addUser" method="post">

            <input type="hidden" name="role" value="operator">

            <div class="input">
                <label>Name</label>
                <input name="name" required>
            </div>

            <div class="input">
                <label>Email</label>
                <input name="email" type="email" required>
            </div>

            <div class="input">
                <label>Phone</label>
                <input name="phoneNo" required>
            </div>

            <div class="input">
                <label>Password</label>
                <input name="password" type="password" required>
            </div>

            <button class="btn-save" type="submit">
                Save Operator
            </button>

        </form>

    </div>

</div>

<!-- EDIT MODAL -->
<div id="editModal" class="modal">

    <div class="modal-content">

        <span class="close"
              onclick="document.getElementById('editModal').style.display='none'">
            ×
        </span>

        <h2>Edit Operator</h2>

        <form action="updateUser" method="post">

            <input type="hidden" id="edit_userID" name="userID">

            <div class="input">
                <label>Name</label>
                <input id="edit_name" name="name">
            </div>

            <div class="input">
                <label>Email</label>
                <input id="edit_email" name="email">
            </div>

            <div class="input">
                <label>Phone</label>
                <input id="edit_phoneNo" name="phoneNo">
            </div>

            <div class="input">
                <label>Status</label>
                <select id="edit_status" name="status">
                    <option value="active">Active</option>
                    <option value="inactive">Inactive</option>
                </select>
            </div>

            <button class="btn-save" type="submit">
                Update
            </button>

        </form>

    </div>

</div>

<script>

function openEditModal(id, name, email, phone, status) {
    document.getElementById("edit_userID").value = id;
    document.getElementById("edit_name").value = name;
    document.getElementById("edit_email").value = email;
    document.getElementById("edit_phoneNo").value = phone;
    document.getElementById("edit_status").value = status;

    document.getElementById("editModal").style.display = "block";
}

window.onclick = function(event) {
    let add = document.getElementById("addModal");
    let edit = document.getElementById("editModal");

    if (event.target === add) add.style.display = "none";
    if (event.target === edit) edit.style.display = "none";
};

</script>

</body>
</html>