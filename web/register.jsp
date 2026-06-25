<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>NAKHODA Register</title>
        <link rel="stylesheet" href="assets/css/register.css">

        <style>
            .strength-box{
                margin-top:5px;
            }

            #strengthText{
                font-size:12px;
                margin-bottom:3px;
            }
        </style>
    </head>

    <body>

        <div class="container">

            <div class="left">
                <div class="brand">
                    <div class="brand-icon">⚓</div>
                    <div class="brand-text">NAKHODA</div>
                </div>
            </div>

            <div class="right">
                <div class="form-card">

                    <div class="top-link">
                        Already have an account? <a href="login.jsp">Log In</a>
                    </div>

                    <h1>Create Your Account</h1>

                    <!-- FORM START -->
                    <form action="<%=request.getContextPath()%>/register"
                          method="post"
                          onsubmit="return validateForm()">

                        <!-- NAME -->
                        <label>Full Name</label>
                        <div class="input-wrap">
                            <span class="icon">👤</span>
                            <input type="text" name="name" placeholder="John Doe" required>
                        </div>

                        <!-- EMAIL -->
                        <label>Email Address</label>
                        <div class="input-wrap">
                            <span class="icon">✉</span>
                            <input type="email" name="email" placeholder="name@port-authority.com" required>
                        </div>

                        <!-- PHONE -->
                        <label>Phone No</label>
                        <div class="input-wrap">
                            <span class="icon">📱</span>
                            <input type="text" name="phoneNo" placeholder="01X-XXXXXXX" required>
                        </div>

                        <!-- PASSWORD -->
                        <label>Password</label>
                        <div class="input-wrap">
                            <span class="icon">🔒</span>

                            <input type="password"
                                   id="pwd"
                                   name="password"
                                   placeholder="Create password"
                                   required
                                   minlength="8"
                                   onkeyup="checkStrength()"
                                   pattern="^(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+=!]).{8,}$"
                                   title="Min 8 chars, 1 uppercase, 1 number, 1 symbol">

                            <button type="button" class="eye" onclick="togglePwd()">👁</button>
                        </div>

                        <!-- PASSWORD STRENGTH -->
                        <div class="strength-box">
                            <div id="strengthText"></div>
                            <progress id="strengthBar" value="0" max="100" style="width:100%;"></progress>
                        </div>

                        <!-- ROLE -->
                        <label>Professional Role</label>

                        <input type="hidden" id="roleInput" name="role">

                        <div class="role-grid">

                            <button type="button" class="role-card"
                                    onclick="pickRole('Manager', this)">
                                <div class="role-icon">📋</div>
                                <div class="role-title">Manager</div>
                            </button>

                            <button type="button" class="role-card"
                                    onclick="pickRole('Supervisor', this)">
                                <div class="role-icon">📈</div>
                                <div class="role-title">Supervisor</div>
                            </button>

                            <button type="button" class="role-card"
                                    onclick="pickRole('Operator', this)">
                                <div class="role-icon">⚙</div>
                                <div class="role-title">Operator</div>
                            </button>

                        </div>

                        <p class="hint" id="roleHint">Please select a role.</p>

                        <!-- SUBMIT -->
                        <button class="btn" type="submit">
                            Create Account →
                        </button>

                        <!-- ERROR MESSAGE -->
                        <% if (request.getParameter("err") != null) { %>
                        <p class="error">Registration failed. Email may already exist.</p>
                        <% }%>

                    </form>
                    <!-- FORM END -->

                </div>
            </div>

        </div>

        <!-- SCRIPT -->
        <script>

            function togglePwd() {
                const pwd = document.getElementById('pwd');
                pwd.type = (pwd.type === "password") ? "text" : "password";
            }

            function pickRole(role, el) {
                document.getElementById('roleInput').value = role;
                document.getElementById('roleHint').textContent = "Selected role: " + role;

                document.querySelectorAll('.role-card')
                        .forEach(x => x.classList.remove('active'));

                el.classList.add('active');
            }

            function checkStrength() {

                let password = document.getElementById("pwd").value;
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

            function validateForm() {

                let role = document.getElementById('roleInput').value;
                let strength = document.getElementById("strengthBar").value;

                if (!role) {
                    document.getElementById('roleHint').textContent =
                            "Please select a role before creating account.";
                    document.getElementById('roleHint').style.color = "red";
                    return false;
                }

                if (strength < 75) {
                    alert("Password is too weak. Please use a stronger password.");
                    return false;
                }

                return true;
            }

        </script>

    </body>
</html>