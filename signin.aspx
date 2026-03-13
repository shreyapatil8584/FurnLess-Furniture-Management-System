<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signin.aspx.cs" Inherits="signin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sign In | FurnLess</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
    <style>
    /* 1. Entrance Animation */
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(40px); }
        to { opacity: 1; transform: translateY(0); }
    }

    body {
        /* USE A HIGH-RES WOOD TEXTURE */
        background: url('https://png.pngtree.com/thumb_back/fh260/background/20230718/pngtree-contemporary-3d-rendering-of-wooden-wallpaper-design-image_3909882.jpg');
        background-size: cover;
        background-position: center;
        background-attachment: fixed; /* Keeps wood still while card floats */
        background-repeat: no-repeat;
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        overflow: hidden;
    }

    /* 2. Dark Overlay to make the text readable */
    body::before {
        content: "";
        position: absolute;
        top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0, 0, 0, 0.1); /* Darkens the wood so UI pops */
        z-index: 1;
    }

    /* Navbar Styling */
    .navbar-custom {
        background: rgba(0, 0, 0, 0.5) !important;
        backdrop-filter: blur(10px);
        border: none;
        z-index: 1000;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    /* Card Adjustments for Desktop */
    .auth-card {
        background: rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.15);
        border-radius: 30px;
        padding: 50px;
        width: 100%;
        max-width: 480px;
        box-shadow: 0 40px 100px rgba(0, 0, 0, 0.8);
        color: white;
        animation: fadeInUp 0.8s ease-out;
        position: relative;
        z-index: 10; /* Ensures it is above the body overlay */
    }

    .auth-header h2 {
        font-size: 36px;
        font-weight: 800;
        text-align: center;
        margin-bottom: 5px;
        color: #f1c40f;
        text-shadow: 0 2px 10px rgba(0,0,0,0.5);
    }

    .auth-input {
        width: 100%;
        background: rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 15px;
        padding: 15px 20px;
        color: white;
        font-size: 16px;
        transition: 0.3s;
    }

    .auth-input:focus {
        border-color: #f1c40f;
        background: rgba(0, 0, 0, 0.5);
        outline: none;
        box-shadow: 0 0 15px rgba(241, 196, 15, 0.3);
    }

    .auth-btn {
        width: 100%;
        padding: 18px;
        background: #f1c40f;
        border: none;
        border-radius: 15px;
        color: #000;
        font-weight: 800;
        font-size: 18px;
        margin-top: 30px;
        transition: 0.3s;
        text-transform: uppercase;
        box-shadow: 0 10px 30px rgba(241, 196, 15, 0.3);
    }

    .auth-btn:hover {
        background: #fff;
        transform: translateY(-5px);
        box-shadow: 0 20px 40px rgba(241, 196, 15, 0.5);
    }
</style>
    <style>
    /* 1. Navbar Container: Floating Glassmorphism */
    .navbar-custom {
        background: rgba(255, 255, 255, 0.05) !important;
        backdrop-filter: blur(15px) saturate(180%);
        -webkit-backdrop-filter: blur(15px) saturate(180%);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important;
        padding: 12px 0;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    }

    /* 2. Brand/Logo 3D Pop */
    .navbar-custom .navbar-brand {
        display: flex;
        align-items: center;
        font-size: 26px;
        font-weight: 800;
        letter-spacing: 1px;
        color: #ffffff !important;
        transition: 0.3s;
    }
    
    .navbar-custom .navbar-brand img {
        transition: transform 0.4s ease;
        box-shadow: 0 4px 15px rgba(0,0,0,0.3);
    }

    .navbar-custom .navbar-brand:hover img {
        transform: rotate(-10deg) scale(1.1);
    }

    /* 3. Modern Menu Items & Icons */
    .navbar-custom .nav li a {
        color: rgba(255, 255, 255, 0.85) !important;
        font-weight: 600;
        font-size: 14px;
        padding: 10px 20px !important;
        display: flex;
        align-items: center;
        gap: 10px; /* Space for icons */
        transition: all 0.3s ease;
        position: relative;
    }

    /* Icon Accent Color */
    .navbar-custom .nav li a i {
        color: #f1c40f; /* Gold Icons */
        font-size: 16px;
        transition: 0.3s;
    }

    /* 4. Unique Hover Animation (Lift & Underline) */
    .navbar-custom .nav li a:hover {
        color: #fff !important;
        transform: translateY(-3px);
    }

    .navbar-custom .nav li a:hover i {
        transform: scale(1.2);
        text-shadow: 0 0 10px rgba(241, 196, 15, 0.5);
    }

    /* Animated Border-Bottom (Underline) */
    .navbar-custom .nav li a::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        width: 0;
        height: 3px;
        background: #f1c40f;
        border-radius: 10px;
        transition: 0.3s ease;
        transform: translateX(-50%);
    }

    .navbar-custom .nav li a:hover::after {
        width: 60%;
    }

    /* Active State Styling */
    .navbar-custom .nav li.active a {
        background: rgba(255, 255, 255, 0.1) !important;
        border-radius: 12px;
        color: #f1c40f !important;
    }
    
    .navbar-custom .nav li.active a::after {
        width: 60%;
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
        
       <nav class="navbar navbar-default navbar-fixed-top navbar-custom" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar" style="background-color: #f1c40f;"></span>
                <span class="icon-bar" style="background-color: #f1c40f;"></span>
                <span class="icon-bar" style="background-color: #f1c40f;"></span>
            </button>
            <a class="navbar-brand" href="index.aspx">
                <img src="./IMAGES/logo.jpg" alt="Logo" height="35" style="margin-right:12px; border-radius: 5px;"/>
                <span>Furn<span style="color:#f1c40f;">Less</span></span>
            </a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="index.aspx"><i class="fa fa-home"></i> Home</a></li>
                <li ><a href="signup.aspx"><i class="fa fa-user-plus"></i> Sign Up</a></li>
                <li class="active"><a href="signin.aspx"><i class="fa fa-sign-in"></i> Sign In</a></li>
            </ul>
        </div>
    </div>
</nav>

        <div class="auth-card">
            <div class="auth-header">
                <h2>Welcome Back</h2>
                <p>Please enter your details to sign in</p>
            </div>

            <div class="form-group">
                <label class="auth-label"><i class="fa fa-user"></i> Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="auth-input" placeholder="Your username"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="txtUsername" 
                    ErrorMessage="* Username is required" CssClass="validator-error" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label class="auth-label"><i class="fa fa-lock"></i> Password</label>
                <asp:TextBox ID="txtPass" runat="server" CssClass="auth-input" TextMode="Password" placeholder="Your password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfv2" runat="server" ControlToValidate="txtPass" 
                    ErrorMessage="* Password is required" CssClass="validator-error" Display="Dynamic" />
            </div>

            <div style="display:flex; justify-content: space-between; align-items: center; font-size: 14px; margin-top: 15px;">
                <label class="remember-me">
                    <asp:CheckBox ID="CheckBox1" runat="server" /> Remember Me
                </label>
                <a href="ForgotPassword.aspx" class="auth-link">Forgot Password?</a>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="auth-btn" OnClick="btnLogin_Click" />
             <div style="text-align:center; margin-top:15px;">
                    <asp:Label ID="lblError" CssClass="text-danger" runat="server" style="font-weight:600;"></asp:Label>
                </div>

            <div class="auth-footer">
                New to FurnLess? <a href="signup.aspx" class="auth-link">Create an Account</a>
            </div>
        </div>
    </form>
</body>
</html>