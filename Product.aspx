<%@ Page Title="" Language="C#" MasterPageFile="~/User.master" AutoEventWireup="true" CodeFile="Product.aspx.cs"
    Inherits="Product" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <link rel="stylesheet" href="./CSS1/index.css" />
        <style>
            /** View All product Css styling*/
            .probrand {
                font-size: 15px;
                font-weight: 600;
                line-height: 15px;
                text-transform: uppercase;
                font-family: sans-serif;
                color: #2d3436;
            }

            .proName {
                font-size: 13px;
                line-height: 17px;
                font-family: sans-serif;
                color: #636e72;
                margin-top: 5px;
            }

            .proPrice {
                font-size: 16px;
                line-height: 17px;
                font-family: sans-serif;
                font-weight: 800;
                color: #14cda8;
                margin-top: 10px;
            }

            .proOgPrice {
                font-size: 13px;
                line-height: 17px;
                font-family: sans-serif;
                font-weight: 400;
                text-decoration: line-through;
                color: #b2bec3;
                margin-right: 5px;
            }

            .proPriceDiscount {
                font-size: 12px;
                font-family: sans-serif;
                font-weight: 600;
                color: #ff7675;
                margin-left: 5px;
            }

            .thumbnail {
                border: none;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                border-radius: 12px;
                padding: 15px;
                transition: all 0.3s ease;
                margin-bottom: 30px;
            }

            .thumbnail:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            }

            .thumbnail img {
                border-radius: 8px;
                width: 100%;
                height: 250px;
                object-fit: cover;
            }

            .page-title {
                margin-bottom: 20px;
              
                font-weight: 800;
                color: #2d3436;
                text-align: center;
            }
        </style>
          <br /><br />
        <div class="container">
          
            <h3 class="page-title">Explore Our Collection</h3>

            <!-- Search Bar -->
            <div class="search-container" style="max-width: 600px; margin: 0 auto 40px;">
                <div class="input-group"
                    style="box-shadow: 0 4px 20px rgba(0,0,0,0.08); border-radius: 50px; overflow: hidden;">
                    <span class="input-group-addon" style="background: white; border: none; padding-left: 20px;"><i
                            class="fa fa-search" style="color: #14cda8;"></i></span>
                    <input type="text" id="txtSearchUserProducts" class="form-control"
                        placeholder="Search for furniture, brands, categories..."
                        style="border: none; height: 50px; font-size: 1.1rem; padding-left: 10px;"
                        onkeyup="filterUserProducts()" />
                </div>
            </div>

            <div class="row" id="productContainer">
                <asp:Repeater ID="rptrProducts" runat="server">
                    <ItemTemplate>
                        <div class="col-sm-4 col-md-3 product-item-wrapper">
                            <a href="ProductView.aspx?PID=<%# Eval(" PID") %>" style="text-decoration:none;">
                                <div class="thumbnail">
                                    <%-- Standardized path to IMAGES (uppercase) and verified ImageName/Name binding
                                        --%>
                                        <img src='<%# "IMAGES/Pimages/" + Eval("PID") + "/" + (Eval("ImageName") ?? Eval("Name")) + Eval("Extension") %>'
                                            alt='<%# Eval("PName") %>' onerror="this.src='IMAGES/furnless.png';" />
                                        <div class="caption">
                                            <div class="probrand">
                                                <%# Eval("BrandName") %>
                                            </div>
                                            <div class="proName">
                                                <%# Eval("PName") %>
                                            </div>
                                            <div class="proPrice">
                                                <span class="proOgPrice">&#8377;<%# Eval("PPrice", "{0:0}" ) %></span>
                                                &#8377;<%# Eval("PSelPrice", "{0:0}" ) %>
                                                    <span class="proPriceDiscount">(<%# Eval("DiscAmount") %>
                                                            Off)</span>
                                            </div>
                                        </div>
                                </div>
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <script>
            function filterUserProducts() {
                var input = document.getElementById('txtSearchUserProducts');
                var filter = input.value.toUpperCase();
                var container = document.getElementById('productContainer');
                var items = container.getElementsByClassName('product-item-wrapper');

                for (var i = 0; i < items.length; i++) {
                    var txtValue = items[i].textContent || items[i].innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        items[i].style.display = "";
                    } else {
                        items[i].style.display = "none";
                    }
                }
            }
        </script>
    </asp:Content>