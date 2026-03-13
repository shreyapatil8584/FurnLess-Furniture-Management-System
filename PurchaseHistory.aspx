<%@ Page Title="Purchase History" Language="C#" MasterPageFile="~/User.master" AutoEventWireup="true"
    CodeFile="PurchaseHistory.aspx.cs" Inherits="PurchaseHistory" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <link rel="stylesheet" href="./CSS1/PurchaseHistory.css" />
        <style>
            @media print {
                body {
                    background: white;
                    color: black;
                }

                .navbar,
                .footer-pos,
                .noprint,
                .purchase-hero,
                .purchase-section,
                .footer-bottom,
                .modal,
                .footer-widget,
                .footer-newsletter {
                    display: none !important;
                }

                #export-section {
                    display: block !important;
                    width: 100%;
                    position: absolute;
                    top: 0;
                    left: 0;
                }

                /* Ensure footer is definitely gone as per request */
                footer {
                    display: none !important;
                }
            }

            .export-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                font-family: Arial, sans-serif;
            }

            .export-table th {
                background: #f4f4f4;
                padding: 12px;
                text-align: left;
                border-bottom: 2px solid #ddd;
                font-weight: bold;
            }

            .export-table td {
                padding: 12px;
                border-bottom: 1px solid #eee;
            }

            .export-title {
                text-align: center;
                margin-bottom: 30px;
                color: #2c3e50;
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <!-- Page Header -->
        <section class="purchase-hero">
            <div class="container">
                <div class="hero-content">
                    <h1 class="hero-title" style="color: white;">My Orders</h1>
                    <p class="hero-description" style="color: rgba(255,255,255,0.9);">
                        Track and manage your purchase history
                    </p>
                    <div class="noprint" style="margin-top: 25px;">
                        <button type="button" onclick="window.print()" class="btn"
                            style="background: rgba(255,255,255,0.2); color: white; border: 1px solid rgba(255,255,255,0.4); border-radius: 50px; padding: 10px 25px; font-weight: 600; transition: all 0.3s;">
                            <i class="fa fa-file-pdf-o"></i> Export All Orders
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Purchase History Section -->
        <section class="purchase-section">
            <div class="container">
                <asp:Label ID="lblMessage" runat="server" CssClass="alert-message"></asp:Label>

                <asp:Repeater ID="rptrOrders" runat="server">
                    <ItemTemplate>
                        <div class="order-card reveal">
                            <div class="order-header">
                                <div class="order-info">
                                    <h3 class="order-number">Order #<%# Eval("PurchaseID") %>
                                    </h3>
                                    <p class="order-date">
                                        <i class="fa fa-calendar"></i>
                                        <%# Convert.ToDateTime(Eval("DateOfPurchase")).ToString("MMM dd, yyyy") %>
                                    </p>
                                </div>
                                <div class="order-status-badge <%# GetStatusClass(Eval(" PaymentStatus").ToString()) %>
                                    ">
                                    <%# GetStatusText(Eval("PaymentStatus").ToString()) %>
                                </div>
                            </div>

                            <div class="order-body">
                                <div class="order-details-grid">
                                    <div class="detail-item">
                                        <span class="detail-label">Payment Method</span>
                                        <span class="detail-value">
                                            <%# Eval("PaymentType") %>
                                        </span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-label">Total Amount</span>
                                        <span class="detail-value amount">&#8377;<%# Eval("TotalPayed", "{0:0}" ) %>
                                                </span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-label">Discount</span>
                                        <span class="detail-value discount">-&#8377;<%# Eval("CartDiscount", "{0:0}" )
                                                %>
                                        </span>
                                    </div>
                                </div>

                                <div class="shipping-info">
                                    <h4><i class="fa fa-map-marker"></i> Shipping Address</h4>
                                    <p class="address-text">
                                        <%# Eval("Name") %><br />
                                            <%# Eval("Address") %><br />
                                                PIN: <%# Eval("PinCode") %> | Mobile: <%# Eval("MobileNumber") %>
                                    </p>
                                </div>
                            </div>

                            <div class="order-footer">
                                <asp:Button ID="btnViewDetails" runat="server" Text="View Details"
                                    CssClass="btn-order-action" CommandArgument='<%# Eval("PurchaseID") %>'
                                    OnClick="btnViewDetails_Click" />

                                <asp:Button ID="btnCancelOrder" runat="server" Text="Cancel Order"
                                    CssClass="btn-order-cancel" CommandArgument='<%# Eval("PurchaseID") %>'
                                    OnClick="btnCancelOrder_Click" CausesValidation="false"
                                    Visible='<%# Eval("PaymentStatus").ToString() != "Cancelled" && Eval("PaymentStatus").ToString() != "Delivered" %>' />

                                <asp:Button ID="btnDeleteOrder" runat="server" Text="Delete Order"
                                    CssClass="btn-order-delete" CommandArgument='<%# Eval("PurchaseID") %>'
                                    OnClick="btnDeleteOrder_Click" CausesValidation="false"
                                    OnClientClick="return confirm('Are you sure you want to delete this order permanently?');"
                                    Visible='<%# Eval("PaymentStatus").ToString() == "Cancelled" || Eval("PaymentStatus").ToString() == "Delivered" %>' />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Panel ID="pnlNoOrders" runat="server" Visible="false" CssClass="no-orders-panel">
                    <div class="no-orders-content">
                        <i class="fa fa-shopping-bag"></i>
                        <h3>No Orders Yet</h3>
                        <p>You haven't placed any orders. Start shopping now!</p>
                        <a href="Product.aspx" class="btn-shop-now">Browse Products</a>
                    </div>
                </asp:Panel>
            </div>
        </section>

        <!-- Export Section -->
        <div id="export-section" style="display: none;">
            <div style="padding: 40px;">
                <div class="export-title">
                    <h2 style="font-weight: 800; margin: 0; color: #14cda8;">FURNLESS</h2>
                    <h3 style="margin-top: 10px;">Order History Report</h3>
                    <p>Generated on: <%= DateTime.Now.ToString("MMM dd, yyyy") %>
                    </p>
                </div>

                <table class="export-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th>Items</th>
                            <th>Payment Method</th>
                            <th>Status</th>
                            <th style="text-align: right;">Total Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptrExportOrders" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>#<%# Eval("PurchaseID") %>
                                    </td>
                                    <td>
                                        <%# Convert.ToDateTime(Eval("DateOfPurchase")).ToString("MMM dd, yyyy") %>
                                    </td>
                                    <td>
                                        <%# Eval("PIDSizeID").ToString().Split(',').Length %> Items
                                    </td>
                                    <td>
                                        <%# Eval("PaymentType") %>
                                    </td>
                                    <td>
                                        <%# Eval("PaymentStatus") %>
                                    </td>
                                    <td style="text-align: right; font-weight: bold;">&#8377;<%#
                                            Eval("TotalPayed", "{0:0}" ) %>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <div style="margin-top: 40px; text-align: center; color: #7f8c8d; font-size: 12px;">
                    Confidential - Internal Use Only
                </div>
            </div>
        </div>

        <script>
            // Scroll animations
            document.querySelectorAll('.reveal').forEach(el => el.classList.add('reveal-init'));

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.remove('reveal-init');
                        entry.target.classList.add('active');
                    }
                });
            }, { threshold: 0.1 });

            document.querySelectorAll('.reveal').forEach(el => observer.observe(el));
        </script>
    </asp:Content>