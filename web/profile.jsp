<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>

<%
    User u = (User) request.getAttribute("user");
    if (u == null) {
        u = (User) session.getAttribute("user");
    }

    String userId = (u != null && u.getUserID() != null) ? u.getUserID() : "---";
    String name = (u != null && u.getName() != null) ? u.getName() : "";
    String email = (u != null && u.getEmail() != null) ? u.getEmail() : "";
    String phone = (u != null && u.getPhoneNo() != null) ? u.getPhoneNo() : "";
    String rawRole = (u != null && u.getRole() != null) ? u.getRole() : "operator";

    String dashboardPage = "operatorDashboard";

    if (rawRole.equalsIgnoreCase("manager"))
        dashboardPage = "managerDashboard";
    else if (rawRole.equalsIgnoreCase("supervisor"))
        dashboardPage = "supervisorDashboard";
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>NAKHODA | Profile</title>

        <style>

            /* GLOBAL */
            body{
                margin:0;
                font-family:'Segoe UI',sans-serif;
                background:#f4f7fb;
            }

            /* TOP BAR */
            .header-nav{
                background:linear-gradient(135deg,#0b2a4a,#1e88e5);
                color:white;
                padding:15px 25px;
                display:flex;
                justify-content:space-between;
                align-items:center;
            }

            /* LAYOUT */
            .main-content{
                max-width:1100px;
                margin:40px auto;
                padding:0 20px;
            }

            .profile-grid{
                display:grid;
                grid-template-columns:320px 1fr;
                gap:25px;
            }

            /* SIDEBAR CARD */
            .profile-sidebar{
                background:white;
                padding:30px;
                border-radius:14px;
                text-align:center;
                box-shadow:0 6px 18px rgba(0,0,0,0.08);
            }

            .avatar-circle{
                width:100px;
                height:100px;
                background:#1e88e5;
                color:white;
                font-size:40px;
                line-height:100px;
                border-radius:50%;
                margin:0 auto 15px;
                font-weight:bold;
            }

            .info-badge{
                background:#e3f2fd;
                color:#1e88e5;
                padding:6px 14px;
                border-radius:20px;
                font-size:13px;
                display:inline-block;
                margin-top:10px;
            }

            /* FORM CARD */
            .form-container{
                background:white;
                padding:30px;
                border-radius:14px;
                box-shadow:0 6px 18px rgba(0,0,0,0.08);
            }

            /* SECTION TITLE */
            .section-title{
                font-weight:800;
                color:#0b2a4a;
                margin-bottom:18px;
                font-size:18px;
                border-bottom:2px solid #f1f1f1;
                padding-bottom:10px;
            }

            /* INPUT */
            label{
                font-size:13px;
                color:#666;
            }

            input{
                width:100%;
                padding:12px;
                border-radius:10px;
                border:1px solid #ddd;
                margin-top:5px;
                margin-bottom:15px;
                outline:none;
            }

            input:focus{
                border-color:#1e88e5;
            }

            /* GRID */
            .input-group{
                display:grid;
                grid-template-columns:1fr 1fr;
                gap:15px;
            }

            /* BUTTONS */
            .btn{
                background:linear-gradient(135deg,#1e88e5,#0b2a4a);
                color:white;
                border:none;
                padding:12px 18px;
                border-radius:10px;
                cursor:pointer;
                font-weight:bold;
                transition:0.2s;
            }

            .btn:hover{
                opacity:0.9;
            }

            /* BACK BUTTON */
            .btn-outline{
                border:1px solid white;
                background:transparent;
                color:white;
                padding:8px 15px;
                border-radius:8px;
                text-decoration:none;
            }

            /* FOOTER */
            .footer{
                margin-top:40px;
                text-align:center;
                font-size:13px;
                color:#888;
            }

        </style>
    </head>

    <body>

        <!-- TOP BAR -->
        <div class="header-nav">
            <div style="font-weight:800;">
                ⚓ NAKHODA SYSTEM
            </div>

            <a href="<%=dashboardPage%>" class="btn-outline">
                Back to Dashboard
            </a>
        </div>

        <!-- MAIN -->
        <div class="main-content">

            <div class="profile-grid">

                <!-- LEFT -->
                <div class="profile-sidebar">

                    <div class="avatar-circle">
                        <%= name.length() > 0 ? name.substring(0, 1).toUpperCase() : "U"%>
                    </div>

                    <h3 style="margin:10px 0 5px;"><%=name%></h3>
                    <div style="color:#777;font-size:14px;"><%=email%></div>

                    <div class="info-badge"><%=rawRole%></div>

                    <hr style="margin:20px 0;border:1px solid #eee;">

                    <div style="text-align:left;">
                        <div style="font-size:12px;color:#888;">User ID</div>
                        <div style="font-weight:700;">#<%=userId%></div>
                    </div>

                    <div style="margin-top:15px;text-align:left;">
                        <div style="font-size:12px;color:#888;">Status</div>
                        <div style="color:#2e7d32;font-weight:700;">Active</div>
                    </div>

                </div>

                <!-- RIGHT -->
                <div class="form-container">

                    <!-- PROFILE FORM -->
                    <div class="section-title">👤 Personal Information</div>

                    <form action="<%=request.getContextPath()%>/updateProfile" method="post">

                        <label>Name</label>
                        <input type="text" name="name" value="<%=name%>" required>

                        <div class="input-group">

                            <div>
                                <label>Email</label>
                                <input type="email" name="email" value="<%=email%>" required>
                            </div>

                            <div>
                                <label>Phone</label>
                                <input type="text" name="phoneNo" value="<%=phone%>">
                            </div>

                        </div>

                        <button class="btn" type="submit">
                            Save Changes
                        </button>

                    </form>

                    <br><br>

                    <!-- PASSWORD -->
                    <div class="section-title">🔒 Security</div>

                    <form action="<%=request.getContextPath()%>/changePassword" method="post">

                        <label>Current Password</label>
                        <input type="password" name="currentPassword" required>

                        <div class="input-group">

                            <div>
                                <label>New Password</label>
                                <input type="password"
                                       id="newPassword"
                                       name="newPassword"
                                       required
                                       onkeyup="checkStrength()"
                                       pattern="^(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+=!]).{8,}$"
                                       title="Min 8 characters, 1 uppercase, 1 number, 1 symbol">

                                <div id="strengthText"></div>
                                <progress id="strengthBar" value="0" max="100" style="width:100%;"></progress>
                            </div>

                            <div>
                                <label>Confirm Password</label>
                                <input type="password" name="confirmPassword" required>
                            </div>

                        </div>

                        <button class="btn" type="submit">
                            Update Password
                        </button>

                    </form>

                </div>

            </div>

            <div class="footer">
                Need help? Contact system administrator.
            </div>

        </div>

        <script>
            function checkStrength() {

                let password = document.getElementById("newPassword").value;
                let strengthBar = document.getElementById("strengthBar");
                let strengthText = document.getElementById("strengthText");

                let strength = 0;

                if (password.length >= 8)
                    strength += 25;
                if (password.match(/[A-Z]/))
                    strength += 25;
                if (password.match(/[0-9]/))
                    strength += 25;
                if (password.match(/[@#$%^&+=!]/))
                    strength += 25;

                strengthBar.value = strength;

                if (strength <= 25) {
                    strengthText.innerHTML = "Weak";
                    strengthText.style.color = "red";
                } else if (strength <= 50) {
                    strengthText.innerHTML = "Fair";
                    strengthText.style.color = "orange";
                } else if (strength <= 75) {
                    strengthText.innerHTML = "Good";
                    strengthText.style.color = "blue";
                } else {
                    strengthText.innerHTML = "Strong";
                    strengthText.style.color = "green";
                }
            }
        </script>

    </body>
</html>