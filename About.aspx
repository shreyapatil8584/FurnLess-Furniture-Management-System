<%@ Page Language="C#" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head id="Head1" runat="server">
        <title>About Us | FurnLess</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="./CSS1/index.css" />
        <style>
    /* 1. Silk Flow Background Animation */
    @keyframes silkFlow {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    .navbar-fixed-top {
        /* Light 3D Mesh: Pearl, Soft Blue, and White */
        background: linear-gradient(-45deg, #ffffff, #f0f9ff, #e0f2fe, #ffffff) !important;
        background-size: 400% 400% !important;
        animation: silkFlow 12s ease infinite !important;
        
        /* Glassmorphism for Light Mode */
        backdrop-filter: blur(15px) saturate(150%);
        -webkit-backdrop-filter: blur(15px) saturate(150%);
        
        /* 3D Depth: Light borders and soft outer shadows */
        border-bottom: 1px solid rgba(255, 255, 255, 0.8);
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05), 
                    inset 0 -1px 0 rgba(0, 0, 0, 0.02);
        
        padding: 12px 0;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    }

    /* 2. Menu Links (Fixing Visibility for Light Theme) */
    .navbar-nav > li > a {
        color: #475569 !important; /* Professional Slate Grey */
        font-weight: 600;
        font-size: 13px;
        letter-spacing: 0.5px;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
    }

    /* 3D Icon Glow */
    .navbar-nav > li > a i {
        color: #0ea5e9; /* Sky Blue Icons */
        filter: drop-shadow(0 2px 3px rgba(14, 165, 233, 0.2));
    }

    .navbar-nav > li > a:hover {
        color: #0284c7 !important;
        transform: translateY(-3px) scale(1.05);
        text-shadow: 0 5px 15px rgba(2, 132, 199, 0.1);
    }

    /* Hover Underline (Modern Light Version) */
    .navbar-nav > li > a::after {
        content: '';
        position: absolute;
        bottom: 5px;
        left: 50%;
        width: 0;
        height: 3px;
        background: linear-gradient(90deg, #0ea5e9, #38bdf8);
        border-radius: 10px;
        transition: 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        transform: translateX(-50%);
    }

    .navbar-nav > li > a:hover::after {
        width: 60%;
    }

    /* 3. The 3D Cart Button for Light Theme */
    .btn-cart-modern {
        background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);
        color: white !important;
        border: none;
        border-radius: 12px;
        padding: 8px 18px;
        font-weight: 700;
        box-shadow: 0 8px 15px rgba(14, 165, 233, 0.25);
        transition: 0.3s;
    }

    .btn-cart-modern:hover {
        transform: translateY(-2px) rotate(-1deg);
        box-shadow: 0 12px 20px rgba(14, 165, 233, 0.4);
    }
</style>
        <style>
    /* 1. Main Footer Container */
    .modern-footer {
        background: #0f172a; /* Deep Midnight Blue */
        color: #94a3b8; /* Soft Slate Text */
        padding: 80px 0 30px 0;
        font-family: 'Segoe UI', sans-serif;
        position: relative;
        overflow: hidden;
    }

    /* 2. Brand & Description */
    .footer-brand {
        color: #ffffff;
        font-size: 28px;
        font-weight: 800;
        margin-bottom: 20px;
        letter-spacing: 1px;
    }
    
    .footer-brand::after {
        content: 'Less';
        color: #14cda8; /* Mint Accent */
    }

    .footer-description {
        line-height: 1.8;
        font-size: 15px;
    }

    /* 3. Social Icons with Floating Effect */
    .footer-social {
        margin-top: 25px;
        display: flex;
        gap: 15px;
    }

    .social-icon {
        width: 40px;
        height: 40px;
        background: rgba(255, 255, 255, 0.05);
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        color: #fff;
        font-size: 18px;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .social-icon:hover {
        background: #14cda8;
        color: #0f172a;
        transform: translateY(-8px) rotate(360deg);
        box-shadow: 0 10px 20px rgba(20, 205, 168, 0.3);
    }

    /* 4. Link Styling */
    .footer-heading {
        color: #ffffff;
        font-weight: 700;
        font-size: 18px;
        margin-bottom: 25px;
        position: relative;
    }

    .footer-heading::after {
        content: '';
        position: absolute;
        left: 0;
        bottom: -8px;
        width: 30px;
        height: 2px;
        background: #14cda8;
    }

    .footer-links {
        list-style: none;
        padding: 0;
    }

    .footer-links li {
        margin-bottom: 12px;
    }

    .footer-links a {
        color: #94a3b8;
        text-decoration: none;
        transition: 0.3s;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .footer-links a:hover {
        color: #14cda8;
        padding-left: 10px;
    }

    /* 5. Back to Top Button */
    .back-to-top {
        display: inline-block;
        background: rgba(20, 205, 168, 0.1);
        color: #14cda8;
        padding: 12px 20px;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 600;
        transition: 0.3s;
        border: 1px solid rgba(20, 205, 168, 0.3);
    }

    .back-to-top:hover {
        background: #14cda8;
        color: #fff;
        transform: scale(1.05);
    }

    /* 6. Footer Bottom Section */
    .footer-divider {
        border-top: 1px solid rgba(255, 255, 255, 0.05);
        margin: 50px 0 30px 0;
    }

    .footer-bottom {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
    }

    .heart {
        color: #ff7675;
        font-weight: bold;
        animation: heartbeat 1.5s ease infinite;
        display: inline-block;
    }

    @keyframes heartbeat {
        0% { transform: scale(1); }
        50% { transform: scale(1.2); }
        100% { transform: scale(1); }
    }

    @media (max-width: 768px) {
        .footer-bottom { text-align: center; justify-content: center; }
    }
</style>
        <script>
            window.onscroll = function() {
                var nav = document.querySelector('.navbar-fixed-top');
                if (window.pageYOffset > 50) {
                    nav.classList.add('navbar-shrink');
                } else {
                    nav.classList.remove('navbar-shrink');
                }
            };
</script>
    </head>

    <body>
        <form id="form1" runat="server">
            <!-- Navbar -->
            <div class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar" style="background-color:white;"></span>
                <span class="icon-bar" style="background-color:white;"></span>
                <span class="icon-bar" style="background-color:white;"></span>
            </button>
           <a class="navbar-brand" href="index.aspx" style="display: flex; align-items: center;">
    <div style="background: white; padding: 5px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); display: flex; align-items: center;">
        <img src="./IMAGES/logo.jpg" alt="Furnless" height="35" style="border-radius: 5px;" />
    </div>
    <span style="color: #0f172a; font-weight: 800; margin-left: 12px; letter-spacing: 1px;">
        Furn<span style="color: #0ea5e9;">Less</span>
    </span>
</a>
        </div>
        
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
               <li><a href="index.aspx"><i class="fa fa-home"></i> Home</a></li>
<li><a href="About.aspx"><i class="fa fa-info-circle"></i> About</a></li>
<li><a href="Contact.aspx"><i class="fa fa-phone"></i> Contact</a></li>
<li><a href="Blog.aspx"><i class="fa fa-newspaper"></i> Blog</a></li>
<li><a href="Developer.aspx"><i class="fa fa-code"></i> Developers</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-shopping-bag"></i> Shop <i class="fa fa-chevron-down" style="font-size: 10px; margin-left: 5px;"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="Product.aspx"><i class="fa fa-layer-group"></i> <b>View All Collection</b></a></li>
                        <li role="separator" class="divider"></li>
                        <li class="dropdown-header" style="color:#60a5fa;">LIVING</li>
                        <li><a href="Product.aspx"><i class="fa fa-couch"></i> Sofas & Lounge</a></li>
                        <li class="dropdown-header" style="color:#60a5fa;">BEDROOM</li>
                        <li><a href="Product.aspx"><i class="fa fa-bed"></i> Beds & Matress</a></li>
                        <li class="dropdown-header" style="color:#60a5fa;">KITCHEN</li>
                        <li><a href="Product.aspx"><i class="fa fa-utensils"></i> Dining Sets</a></li>
                    </ul>
                </li>

                <li>
                    <div style="padding: 10px 12px;">
                        <button id="btnCart" class="btn btn-cart-modern" type="button">
                            <i class="fa fa-shopping-cart"></i> Cart 
                            <span class="badge" style="background: white; color: #2563eb;" id="pCount" runat="server">0</span>
                        </button>
                    </div>
                </li>

                <li id="btnsignup" runat="server"><a href="signup.aspx"><i class="fa fa-user-plus"></i> Sign Up</a></li>
                <li id="btnsignin" runat="server"><a href="signin.aspx" style="color: #60a5fa !important;"><i class="fa fa-sign-in-alt"></i> Sign In</a></li>

                <li>
                    <div style="padding: 10px 12px;">
                        <asp:Button ID="btnlogout" CssClass="btn-logout-modern" runat="server" Text="Logout" OnClick="btnlogout_Click" />
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>

            <!-- Hero Section -->
            <section class="about-hero">
                <div class="container">
                    <div class="hero-content">
                        <span class="hero-subtitle">Our Journey</span>
                        <h1 class="hero-title" style="color: white;">Crafting Elegance <br /> Since 2015</h1>
                    </div>
                </div>
            </section>

            <!-- Our Story -->
            <section class="story-section">
                <div class="container">
                    <div class="row" style="display: flex; align-items: center; flex-wrap: wrap;">
                        <div class="col-md-6 reveal">
                            <img src="https://images.unsplash.com/photo-1540518614846-7eded433c457?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80"
                                alt="Our Workshop" class="story-image" />
                        </div>
                        <div class="col-md-6 reveal" style="padding: 40px;">
                            <span class="hero-subtitle" style="color: var(--primary);">Authentic Craftsmanship</span>
                            <h2 style="font-family: 'Playfair Display', serif; font-size: 3.5rem; margin-bottom: 25px;">
                                The FurnLess Story</h2>
                            <p style="font-size: 1.1rem; color: var(--text-muted); margin-bottom: 25px;">
                                Founded with a passion for quality and a vision for modern living, FurnLess began as a
                                small workshop dedicated to handcrafted excellence. Today, we stand as a beacon of
                                contemporary design, blending traditional techniques with modern aesthetics.
                            </p>
                            <p style="font-size: 1.1rem; color: var(--text-muted);">
                                Every piece we create is a testament to our commitment to durability, style, and
                                sustainable comfort for your home.
                            </p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Stats Section -->
            <section class="stats-container reveal">
                <div class="container">
                    <div class="row">
                        <div class="col-md-3 col-sm-6 stat-item">
                            <span class="stat-number">10k+</span>
                            <span class="stat-label">Happy Clients</span>
                        </div>
                        <div class="col-md-3 col-sm-6 stat-item">
                            <span class="stat-number">150+</span>
                            <span class="stat-label">Expert Craftsmen</span>
                        </div>
                        <div class="col-md-3 col-sm-6 stat-item">
                            <span class="stat-number">12</span>
                            <span class="stat-label">Global Awards</span>
                        </div>
                        <div class="col-md-3 col-sm-6 stat-item">
                            <span class="stat-number">8yrs</span>
                            <span class="stat-label">of Excellence</span>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Values Section -->
            <section class="feature-section">
                <div class="container">
                    <div class="section-title-wrapper center reveal">
                        <h2>Our Core Values</h2>
                    </div>
                    <div class="row">
                        <div class="col-md-4 reveal">
                            <div class="mission-card">
                                <h3 style="font-weight: 800; margin-bottom: 15px;">Quality First</h3>
                                <p style="color: var(--text-muted);">We never compromise on materials. Every screw,
                                    joint, and fabric is selected for longevity.</p>
                            </div>
                        </div>
                        <div class="col-md-4 reveal">
                            <div class="mission-card">
                                <h3 style="font-weight: 800; margin-bottom: 15px;">Smart Design</h3>
                                <p style="color: var(--text-muted);">Beauty meets functionality. Our designs are as
                                    practical as they are stunning.</p>
                            </div>
                        </div>
                        <div class="col-md-4 reveal">
                            <div class="mission-card">
                                <h3 style="font-weight: 800; margin-bottom: 15px;">Sustainability</h3>
                                <p style="color: var(--text-muted);">Committed to eco-friendly sourcing and minimal
                                    waste in our production process.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Footer -->
         <footer class="modern-footer">
    <div class="container">
      <div class="row">
        <div class="col-md-4">
          <h3 class="footer-brand">Furn</h3>
          <p class="footer-description">Crafting excellence in every piece. Your journey to a beautiful home starts here. Discover luxury that lasts a lifetime.</p>
          <div class="footer-social">
            <a href="#" class="social-icon"><i class="fa fa-facebook"></i></a>
            <a href="#" class="social-icon"><i class="fa fa-twitter"></i></a>
            <a href="#" class="social-icon"><i class="fa fa-instagram"></i></a>
            <a href="#" class="social-icon"><i class="fa fa-pinterest"></i></a>
          </div>
        </div>
        
        <div class="col-md-3">
          <h4 class="footer-heading">Quick Links</h4>
          <ul class="footer-links">
            <li><a href="index.aspx"><i class="fa fa-angle-right"></i> Home</a></li>
            <li><a href="About.aspx"><i class="fa fa-angle-right"></i> About Us</a></li>
            <li><a href="Product.aspx"><i class="fa fa-angle-right"></i> Products</a></li>
            <li><a href="Contact.aspx"><i class="fa fa-angle-right"></i> Contact</a></li>
          </ul>
        </div>
        
        <div class="col-md-3">
          <h4 class="footer-heading">Categories</h4>
          <ul class="footer-links">
            <li><a href="#"><i class="fa fa-couch"></i> Living Room</a></li>
            <li><a href="#"><i class="fa fa-bed"></i> Bedroom</a></li>
            <li><a href="#"><i class="fa fa-cutlery"></i> Dining</a></li>
            <li><a href="#"><i class="fa fa-briefcase"></i> Office</a></li>
          </ul>
        </div>
        
        <div class="col-md-2 text-right">
          <a href="#" class="back-to-top">
            <i class="fa fa-chevron-up"></i> Top
          </a>
        </div>
      </div>
      
      <hr class="footer-divider" />
      
      <div class="footer-bottom">
        <p class="copyright">&copy; 2026 <strong>FurnLess</strong> Furniture. All rights reserved.</p>
        <p class="developer">
            Developed with <span class="heart"><i class="fa fa-heart"></i></span> by 
            <strong>Shreya Patil & Rajnandini Patil</strong>
        </p>
      </div>
    </div>
</footer>
        </form>

        <script>
            // Use the same reveal logic as index.aspx
            document.querySelectorAll('.reveal').forEach(el => el.classList.add('reveal-init'));

            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.remove('reveal-init');
            entry.target.classList.add('active');
            }
            });
            }, observerOptions);

            document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

            window.addEventListener('load', () => {
                setTimeout(() => {
                    document.querySelectorAll('.reveal').forEach(el => {
                        const rect = el.getBoundingClientRect();
            if (rect.top < window.innerHeight) {
                el.classList.remove('reveal-init');
                el.classList.add('active');
            }
            });
            }, 500);
            });

            window.addEventListener('scroll', () => {
                const nav = document.querySelector('.navbar-fixed-top');
            if (window.scrollY > 50) {
                nav.classList.add('scrolled');
            } else {
                nav.classList.remove('scrolled');
            }
            });

            // Cart Redirection
            $(document).ready(function () {
                $("#btnCart").click(function () {
                    window.location.href = "Cart.aspx";
                });
            });
        </script>
    </body>

    </html>