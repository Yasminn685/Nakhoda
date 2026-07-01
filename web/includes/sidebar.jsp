<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String sidebarRole = (String) session.getAttribute("role");
    if (sidebarRole == null)
        sidebarRole = "operator";
%>

<style>
    @media screen and (max-width: 768px) {

        /* Paksa sidebar jadi bar atas (Topbar) */
        aside.sidebar {
            position: relative !important;
            width: 100% !important;
            height: auto !important;
            min-height: auto !important;
            top: 0 !important;
            left: 0 !important;
            padding: 15px !important;
            box-sizing: border-box !important;
            display: block !important;
        }

        /* Susun logo NAKHODA kat tengah-tengah skrin phone */
        aside.sidebar .brand {
            margin-bottom: 15px !important;
            display: flex !important;
            justify-content: center !important;
            align-items: center !important;
            gap: 10px !important;
            text-align: center !important;
        }

        /* Susun menu link (Dashboard, Roster dsb) melintang/berbaris */
        aside.sidebar .nav {
            display: flex !important;
            flex-wrap: wrap !important; /* Kalau tak muat, dia turun baris baru */
            gap: 8px !important;
            justify-content: center !important;
        }

        /* Ubah link/menu jadi bentuk butang supaya senang tekan guna jari */
        /* Ubah link/menu jadi bentuk butang supaya senang tekan guna jari */
        aside.sidebar .nav a {
            padding: 8px 12px !important;
            background-color: rgba(255, 255, 255, 0.15) !important;
            color: #ffffff !important; /* <--- TAMBAH BARIS NI UNTUK PASTIKAN TEKS WARNA PUTIH */
            border-radius: 5px !important;
            font-size: 13px !important;
            text-decoration: none !important;
            display: inline-block !important;
        }

        /* Sorokkan tulisan "ACCOUNT" sebab semak kalau kat phone */
        aside.sidebar .nav .spacer {
            display: none !important;
        }

        /* PENTING: Cari class main content fail utama awak, paksa rapat ke kiri */
        .main-content, main, .content, #content {
            margin-left: 0 !important;
            width: 100% !important;
            padding: 15px !important;
        }
    }
</style>

<aside class="sidebar">

    <div class="brand">
        <div class="logo">⚓</div>
        <div>
            <div class="title">NAKHODA</div>

            <div class="sub">
                <% if ("manager".equalsIgnoreCase(sidebarRole)) { %>
                Port Resource Allocation
                <% } else if ("supervisor".equalsIgnoreCase(sidebarRole)) { %>
                Supervisor Console
                <% } else { %>
                Operator Portal
                <% } %>
            </div>
        </div>
    </div>

    <nav class="nav">

        <%-- ================= MANAGER ================= --%>
        <% if ("manager".equalsIgnoreCase(sidebarRole)) { %>

        <a href="managerDashboard">📊 Dashboard</a>
        <a href="operators">👷 Operators List</a>
        <a href="report">📄 Reports</a>

        <%-- ================= SUPERVISOR ================= --%>
        <% } else if ("supervisor".equalsIgnoreCase(sidebarRole)) { %>

        <a href="supervisorDashboard">📊 Dashboard</a>
        <a href="equipmentList">🏗 Manage Equipment</a>
        <a href="taskList">🧩 Manage Tasks</a>
        <a href="rosterList">🗓 Manage Roster</a>
        <a href="report">📄 Reports</a>

        <%-- ================= OPERATOR ================= --%>
        <% } else { %>

        <a href="operatorDashboard">📊 Dashboard</a>
        <a href="myRoster">🗓 My Roster</a>
        <a href="myTask">🧩 My Tasks</a>

        <% }%>

        <div class="spacer">ACCOUNT</div>

        <a href="profile">👤 Profile</a>
        <a class="btn gray" href="<%=request.getContextPath()%>/logout">Logout</a>

    </nav>
</aside>
