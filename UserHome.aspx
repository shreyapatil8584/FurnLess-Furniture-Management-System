<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserHome.aspx.cs" Inherits="UserHome" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>User Home Page | FurnLess</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
    <style>
        body, html {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            overflow-x: hidden;
        }

        /* Updated Hero Container with Background Image */
        .hero-section {
            position: relative;
            width: 100%;
            height: 100vh; 
            display: flex;
            align-items: center;
            justify-content: center;
            /* Replace the URL below with your actual image path */
            background-image: url('DashboardImages/dash.png'); 
            background-size: cover;
            background-position: center;
            background-attachment: fixed; /* Parallax effect */
        }
<a href="">DashboardImages/3.jfif</a>
        /* Dark Overlay for better text contrast */
        .video-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4); /* Adjust opacity for darkness */
            z-index: 1;
        }

        /* Text Content Styling */
        .content-overlay {
            position: relative;
            text-align: center;
            color: white;
            z-index: 2;
            padding: 40px;
            /* Adds a subtle dark glow behind text for maximum readability */
            background: rgba(0, 0, 0, 0.2); 
            border-radius: 15px;
            backdrop-filter: blur(3px); /* Modern glass-morphism effect */
        }

        .success-label {
            font-size: 55px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 10px;
            text-shadow: 0px 4px 15px rgba(0,0,0,0.9);
            display: block;
        }

        .welcome-subtext {
            font-size: 22px;
            font-weight: 300;
            margin-top: 10px;
            opacity: 1;
            text-shadow: 1px 1px 5px rgba(0,0,0,0.8);
        }

        @media (max-width: 768px) {
            .success-label { font-size: 32px; }
            .welcome-subtext { font-size: 18px; }
        }

        #btnCart { margin-right:6px; }
    </style>
    <style>
    /* 1. Navbar Container: Floating Glassmorphism */
    .navbar-fixed-top {
        background: rgba(255, 255, 255, 0.08) !important;
        backdrop-filter: blur(15px) saturate(180%);
        -webkit-backdrop-filter: blur(15px) saturate(180%);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important;
        padding: 10px 0;
        transition: all 0.4s ease;
    }

    /* 2. Brand/Logo Animation */
    .navbar-brand {
        display: flex !important;
        align-items: center;
        font-weight: 800;
        letter-spacing: 1px;
        color: #fff !important;
        transition: 0.3s;
    }
    .navbar-brand img {
        border-radius: 6px;
        margin-right: 12px;
        transition: transform 0.4s ease;
    }
    .navbar-brand:hover img {
        transform: rotate(-10deg) scale(1.1);
    }

    /* 3. Link Styling & Animated Underline */
    .navbar-nav > li > a {
        color: rgba(255, 255, 255, 0.85) !important;
        font-weight: 600;
        font-size: 14px;
        padding: 15px 20px !important;
        position: relative;
        transition: 0.3s;
    }

    .navbar-nav > li > a:hover {
        color: #14cda8 !important; /* Mint Green Accent */
        transform: translateY(-2px);
    }

    /* Modern Underline Animation */
    .navbar-nav > li > a::after {
        content: '';
        position: absolute;
        bottom: 8px;
        left: 50%;
        width: 0;
        height: 2px;
        background: #14cda8;
        transition: 0.3s ease;
        transform: translateX(-50%);
    }

    .navbar-nav > li > a:hover::after {
        width: 60%;
    }

    /* 4. Cart & Auth Button Modernization */
    #btnCart {
        background: rgba(20, 205, 168, 0.15) !important;
        border: 1px solid #14cda8 !important;
        color: #14cda8 !important;
        border-radius: 12px !important;
        font-weight: 700;
        padding: 8px 18px !important;
        transition: 0.3s;
    }

    #btnCart:hover {
        background: #14cda8 !important;
        color: #fff !important;
        box-shadow: 0 8px 20px rgba(20, 205, 168, 0.3);
    }

    /* Custom classes for the ASP buttons */
    .btn-auth-modern {
        padding: 8px 20px !important;
        font-weight: 700 !important;
        border: none !important;
        transition: 0.3s !important;
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    }

    .btn-signin { background: #14cda8 !important; color: white !important; }
    .btn-logout { background: #ff7675 !important; color: white !important; }

    .btn-auth-modern:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.4);
        filter: brightness(1.1);
    }

    /* 5. Mobile Toggle Styling */
    .navbar-toggle {
        border: none;
        background: rgba(255, 255, 255, 0.1);
    }
    .navbar-toggle .icon-bar {
        background-color: #14cda8 !important;
    }
</style>
    <style>
    /* 1. The 3D Base Button */
    .btn-3d-premium {
        position: relative;
        display: inline-block;
        background: linear-gradient(135deg, #14cda8, #0ca688); /* Premium Mint Gradient */
        color: white !important;
        font-size: 18px;
        font-weight: 800;
        text-transform: uppercase;
        letter-spacing: 2px;
        padding: 15px 45px;
        border-radius: 15px;
        border: none;
        cursor: pointer;
        text-decoration: none !important;
        
        /* The 3D Depth (Bottom Shadow) */
        box-shadow: 0 6px 0 #087a63, 
                    0 12px 25px rgba(20, 205, 168, 0.4);
        
        transition: all 0.2s ease;
        overflow: hidden;
    }

    /* 2. The "Shine" Animation (Grabs User Focus) */
    .btn-3d-premium::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: rgba(255, 255, 255, 0.2);
        transform: rotate(45deg);
        transition: 0.5s;
        animation: shine-effect 3s infinite;
    }

    @keyframes shine-effect {
        0% { left: -150%; }
        100% { left: 150%; }
    }

    /* 3. Hover State: Lift Effect */
    .btn-3d-premium:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 0 #087a63, 
                    0 15px 30px rgba(20, 205, 168, 0.6);
        filter: brightness(1.1);
    }

    /* 4. Active State: The "Click" Effect */
    .btn-3d-premium:active {
        transform: translateY(4px); /* Moves down when clicked */
        box-shadow: 0 2px 0 #087a63, 
                    0 5px 10px rgba(0, 0, 0, 0.3);
    }

    /* 5. Border Pulse Animation (Unique Focus) */
    .btn-3d-premium {
        animation: pulse-border 2s infinite;
    }

    @keyframes pulse-border {
        0% { box-shadow: 0 6px 0 #087a63, 0 0 0 0px rgba(20, 205, 168, 0.7); }
        70% { box-shadow: 0 6px 0 #087a63, 0 0 0 15px rgba(20, 205, 168, 0); }
        100% { box-shadow: 0 6px 0 #087a63, 0 0 0 0px rgba(20, 205, 168, 0); }
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
        
     <div class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.aspx">
                <span><img src="./IMAGES/logo.jpg" alt="Furnless" height="40" /></span> 
                Furn<span style="color:#14cda8;">Less</span>
            </a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="index.aspx"><i class="fa fa-home"></i> Home</a></li>
                <li><a href="About.aspx"><i class="fa fa-info-circle"></i> About</a></li>
                <li><a href="Contact.aspx"><i class="fa fa-envelope"></i> Contact</a></li>
                
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-couch"></i> Product <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu" style="background: rgba(0,0,0,0.8); backdrop-filter: blur(10px); border-radius: 12px;">
                        <li><a href="Product.aspx" style="color: white !important;">All Products</a></li>
                    </ul>
                </li>

                <li>
                    <div style="padding-top: 10px; margin-left: 10px;">
                        <a href="Cart.aspx">
                            <button id="btnCart" class="btn navbar-btn" type="button">
                            <i class="fa fa-shopping-cart"></i> Cart <span class="badge" id="pCount" runat="server" style="background:#fff; color:#14cda8;">0</span>
                        </button>
                        </a>
                    </div>
                </li>

                <li style="padding-top: 10px; margin-left: 10px;">
                    <asp:Button ID="btnLogin" runat="server" Text="SignIn" CssClass="btn-auth-modern btn-signin" OnClick="btnLogin_Click" style="border-radius:12px; margin-right:5px;"/>
                    <asp:Button ID="btnlogout" runat="server" Text="Logout" CssClass="btn-auth-modern btn-logout" OnClick="btnlogout_Click" style="border-radius:12px;"/>
                </li>
            </ul>
        </div>
    </div>
</div>
        <div class="hero-section">
            <div class="video-overlay"></div> <div class="content-overlay">
                <asp:Label ID="lblSuccess" runat="server" CssClass="success-label" Text="Welcome Back!"></asp:Label>
                <p class="welcome-subtext">Premium Furniture for Modern Living</p>
                <hr style="width: 100px; border: 1px solid #fff; margin: 20px auto;" />
              <a href="Product.aspx" class="btn-3d-premium">
    <i class="fa fa-shopping-bag" style="margin-right: 10px;"></i> SHOP NOW
</a>
            </div>
        </div>

    </form>
</body>
</html>