<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NAKHODA | Port Resource Allocation System</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

:root{
    --primary:#0d47a1;
    --secondary:#1976d2;
    --accent:#42a5f5;
    --dark:#081937;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:#f4f7fa;
}

/* NAVBAR */
.navbar{
    position:fixed;
    top:0;
    width:100%;
    z-index:1000;

    display:flex;
    justify-content:space-between;
    align-items:center;

    padding:18px 60px;

    background:linear-gradient(90deg,var(--dark),var(--primary));
}

.logo{
    color:white;
    font-size:22px;
    font-weight:700;
    letter-spacing:1px;
}

.nav-links a{
    color:white;
    text-decoration:none;
    margin-left:15px;
    padding:10px 16px;
    border-radius:8px;
    transition:.3s;
}

.nav-links a:hover{
    background:rgba(255,255,255,0.15);
}

.login-btn{
    background:linear-gradient(90deg,var(--secondary),var(--accent));
}

/* HERO */
.hero{
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;

    padding:120px 80px;

    background:
    linear-gradient(120deg, rgba(8,25,55,0.92), rgba(16,78,139,0.85)),
    url("assets/img/port.jpg");

    background-size:cover;
    background-position:center;
    background-attachment:fixed;

    color:white;
    text-align:center;
}

.hero h1{
    font-size:64px;
    font-weight:700;
    margin-bottom:20px;
}

.hero p{
    max-width:800px;
    margin:auto;
    font-size:18px;
    line-height:1.7;
    opacity:0.9;
}

.hero-buttons{
    margin-top:30px;
}

.btn{
    text-decoration:none;
    padding:14px 26px;
    border-radius:10px;
    font-weight:600;
    margin:0 8px;
    display:inline-block;
}

.btn-primary{
    background:linear-gradient(90deg,var(--secondary),var(--accent));
    color:white;
}

.btn-outline{
    border:2px solid white;
    color:white;
}

/* STATS */
.stats{
    padding:70px 80px;
    margin-top:-80px;
}

.stats-grid{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:20px;
}

.stat-card{
    background:white;
    padding:30px;
    border-radius:16px;
    text-align:center;
    box-shadow:0 10px 25px rgba(0,0,0,0.08);
    transition:.3s;
}

.stat-card:hover{
    transform:translateY(-8px);
}

.stat-icon{
    font-size:32px;
    color:var(--secondary);
}

.stat-number{
    font-size:32px;
    font-weight:700;
    margin-top:10px;
    color:var(--primary);
}

.stat-title{
    color:#666;
}

/* SECTIONS */
.section{
    padding:90px 80px;
}

.section-title{
    text-align:center;
    margin-bottom:50px;
}

.section-title h2{
    font-size:40px;
    color:var(--dark);
}

/* FEATURES */
.features-grid{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:20px;
}

.feature-card{
    background:white;
    padding:25px;
    border-radius:14px;
    box-shadow:0 8px 20px rgba(0,0,0,0.06);
    transition:.3s;
}

.feature-card:hover{
    transform:translateY(-6px);
}

.feature-icon{
    font-size:28px;
    color:var(--secondary);
    margin-bottom:10px;
}

/* WORKFLOW */
.workflow{
    background:var(--dark);
    color:white;
    text-align:center;
}

.workflow-container{
    display:flex;
    justify-content:center;
    align-items:center;
    flex-wrap:wrap;
    gap:20px;
}

.step{
    padding:20px;
}

.step i{
    font-size:40px;
    color:var(--accent);
}

/* ROLES */
.role-grid{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:20px;
}

.role-card{
    background:white;
    padding:25px;
    border-radius:14px;
    box-shadow:0 8px 20px rgba(0,0,0,0.06);
}

/* CTA */
.cta{
    background:linear-gradient(90deg,var(--primary),var(--secondary));
    color:white;
    text-align:center;
    padding:70px 20px;
}

footer{
    background:var(--dark);
    color:white;
    text-align:center;
    padding:25px;
}

/* MOBILE */
@media(max-width:900px){
    .stats-grid,
    .features-grid,
    .role-grid{
        grid-template-columns:1fr;
    }

    .hero h1{
        font-size:40px;
    }
}

</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">⚓ NAKHODA SYSTEM</div>
    <div class="nav-links">
        <a href="#features">Features</a>
        <a href="#roles">Roles</a>
        <a class="login-btn" href="login.jsp">Login</a>
    </div>
</div>

<!-- HERO -->
<section class="hero">
    <div>
        <h1>NAKHODA</h1>
        <p>
            Smart Port Resource Allocation & Operational Management System
            for workforce scheduling, task allocation, equipment tracking
            and operational reporting.
        </p>

        <div class="hero-buttons">
            <a href="login.jsp" class="btn btn-primary">Login</a>
            <a href="#features" class="btn btn-outline">Explore</a>
        </div>
    </div>
</section>

<!-- STATS (DYNAMIC FROM SERVLET) -->
<section class="stats">
    <div class="stats-grid">

        <div class="stat-card">
            <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
            <div class="stat-number">${totalOperators}</div>
            <div class="stat-title">Operators</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon"><i class="fa-solid fa-list-check"></i></div>
            <div class="stat-number">${totalTasks}</div>
            <div class="stat-title">Tasks</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon"><i class="fa-solid fa-truck-ramp-box"></i></div>
            <div class="stat-number">${totalEquipment}</div>
            <div class="stat-title">Equipment</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon"><i class="fa-solid fa-calendar-days"></i></div>
            <div class="stat-number">${totalRosters}</div>
            <div class="stat-title">Rosters</div>
        </div>

    </div>
</section>

<!-- FEATURES -->
<section class="section" id="features">
    <div class="section-title">
        <h2>System Features</h2>
    </div>

    <div class="features-grid">

        <div class="feature-card">
            <i class="fa-solid fa-list-check feature-icon"></i>
            <h3>Task Management</h3>
        </div>

        <div class="feature-card">
            <i class="fa-solid fa-calendar-days feature-icon"></i>
            <h3>Roster Scheduling</h3>
        </div>

        <div class="feature-card">
            <i class="fa-solid fa-truck feature-icon"></i>
            <h3>Equipment Status</h3>
        </div>

        <div class="feature-card">
            <i class="fa-solid fa-chart-line feature-icon"></i>
            <h3>Reporting</h3>
        </div>

    </div>
</section>

<!-- WORKFLOW -->
<section class="section workflow">
    <h2>Operational Workflow</h2>

    <div class="workflow-container">
        <div class="step"><i class="fa-solid fa-user-tie"></i><p>Manager</p></div>
        <div>➜</div>
        <div class="step"><i class="fa-solid fa-user-shield"></i><p>Supervisor</p></div>
        <div>➜</div>
        <div class="step"><i class="fa-solid fa-user"></i><p>Operator</p></div>
        <div>➜</div>
        <div class="step"><i class="fa-solid fa-file"></i><p>Reports</p></div>
    </div>
</section>

<!-- ROLES -->
<section class="section" id="roles">
    <div class="section-title">
        <h2>User Roles</h2>
    </div>

    <div class="role-grid">

        <div class="role-card">
            <h3>Manager</h3>
            <p>Manage operators, and reporting</p>
        </div>

        <div class="role-card">
            <h3>Supervisor</h3>
            <p>Assign tasks, manage roster, and manage equipment.</p>
        </div>

        <div class="role-card">
            <h3>Operator</h3>
            <p>Execute tasks and update status</p>
        </div>

    </div>
</section>

<!-- CTA -->
<section class="cta">
    <h2>Ready to Start?</h2>
    <a href="login.jsp" class="btn btn-outline">Login Now</a>
</section>

<!-- FOOTER -->
<footer>
    <p>NAKHODA System © 2026</p>
    <p>Final Year Project</p>
</footer>

</body>
</html>