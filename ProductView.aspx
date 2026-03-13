<%@ Page Title="" Language="C#" MasterPageFile="~/User.master" AutoEventWireup="true" CodeFile="ProductView.aspx.cs"
    Inherits="ProductView" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <style>
            .product-view-container {
                padding: 40px 0;
            }

            .product-main-card {
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                padding: 40px;
                overflow: hidden;
            }

            .proNameView {
                font-size: 2.5rem;
                font-weight: 800;
                color: #2d3436;
                margin-bottom: 15px;
            }

            .proPriceView {
                font-size: 2rem;
                font-weight: 800;
                color: #14cda8;
                margin: 15px 0;
            }

            .proOgPriceView {
                font-size: 1.2rem;
                color: #b2bec3;
                text-decoration: line-through;
                margin-right: 15px;
            }

            .proPriceDiscount {
                font-size: 1.1rem;
                color: #ff7675;
                font-weight: 700;
            }

            .mainButton {
                background: #14cda8;
                color: white;
                border: none;
                padding: 15px 40px;
                border-radius: 10px;
                font-weight: 700;
                font-size: 1.1rem;
                cursor: pointer;
                transition: all 0.3s;
                text-transform: uppercase;
                box-shadow: 0 4px 15px rgba(20, 205, 168, 0.3);
                width: 100%;
                margin-top: 20px;
            }

            .mainButton:hover {
                background: #0eb391;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(20, 205, 168, 0.4);
            }

            .h5size {
                font-size: 1rem;
                font-weight: 700;
                color: #636e72;
                text-transform: uppercase;
                margin: 25px 0 15px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .h5size i {
                color: #14cda8;
            }

            .description-text {
                color: #636e72;
                line-height: 1.8;
                font-size: 1.05rem;
            }

            .carousel-inner img {
                border-radius: 15px;
                width: 100%;
                height: 500px;
                object-fit: contain;
                background: #fdfdfd;
            }

            .size-selector {
                margin-bottom: 30px;
            }

            .radio-list label {
                margin-right: 20px;
                cursor: pointer;
                font-weight: 600;
                color: #2d3436;
            }

            .icon-style {
                color: #14cda8;
                margin-right: 10px;
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="container product-view-container">
            <div class="product-main-card">
                <div class="row">
                    <div class="col-md-6">
                        <!---Image slider start --->
                        <div id="carousel-product" class="carousel slide" data-ride="carousel">
                            <div class="carousel-inner" role="listbox">
                                <asp:Repeater ID="rptrImage" runat="server">
                                    <ItemTemplate>
                                        <div class="item <%# GetActiveImgClass(Container.ItemIndex) %>">
                                            <%-- Fixed path and removed ./ prefix --%>
                                                <img src='<%# "IMAGES/Pimages/" + Eval("PID") + "/" + Eval("Name") + Eval("Extension") %>'
                                                    alt='<%# Eval("Name") %>' onerror="this.src='IMAGES/furnless.png';">
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <a class="left carousel-control" href="#carousel-product" role="button" data-slide="prev"
                                style="background:none; color:#2d3436;">
                                <span class="glyphicon glyphicon-chevron-left"></span>
                            </a>
                            <a class="right carousel-control" href="#carousel-product" role="button" data-slide="next"
                                style="background:none; color:#2d3436;">
                                <span class="glyphicon glyphicon-chevron-right"></span>
                            </a>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <asp:Repeater ID="rptrProductDetails" runat="server"
                            OnItemDataBound="rptrProductDetails_ItemDataBound">
                            <ItemTemplate>
                                <asp:HiddenField ID="hfCatID" runat="server" Value='<%# Eval("PCategoryID") %>' />
                                <asp:HiddenField ID="hfSubCatID" runat="server" Value='<%# Eval("PSubCatID") %>' />
                                <asp:HiddenField ID="hfGenderID" runat="server" Value='<%# Eval("PGender") %>' />
                                <asp:HiddenField ID="hfBrandID" runat="server" Value='<%# Eval("PBrandID") %>' />

                                <h1 class="proNameView">
                                    <%# Eval("PName") %>
                                </h1>
                                <div class="price-box">
                                    <span class="proOgPriceView">&#8377;<%# Eval("PPrice", "{0:0}" ) %></span>
                                    <span class="proPriceDiscount">
                                        <%# string.Format("SAVE &#8377;{0}", Convert.ToDecimal(Eval("PPrice")) -
                                            Convert.ToDecimal(Eval("PSelPrice"))) %>
                                    </span>
                                    <p class="proPriceView">&#8377;<%# Eval("PSelPrice", "{0:0}" ) %>
                                    </p>
                                </div>

                                <div class="size-selector">
                                    <h5 class="h5size"><i class="fa fa-arrows-h"></i> SELECT SIZE</h5>
                                    <asp:RadioButtonList ID="rblSize" runat="server" RepeatDirection="Horizontal"
                                        CssClass="radio-list">
                                        <asp:ListItem Value="Small" Text="Small"></asp:ListItem>
                                        <asp:ListItem Value="Large" Text="Large"></asp:ListItem>
                                        <asp:ListItem Value="Big" Text="Big"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>

                                <asp:Button ID="btnAddtoCart" CssClass="mainButton" runat="server" Text="ADD TO CART"
                                    OnClick="btnAddtoCart_Click" />
                                <asp:Label ID="lblError" CssClass="text-danger" runat="server"
                                    style="display:block; margin-top:10px; font-weight:700;"></asp:Label>

                                <hr style="margin: 30px 0;" />

                                <h5 class="h5size"><i class="fa fa-align-left"></i> DESCRIPTION</h5>
                                <p class="description-text">
                                    <%# Eval("PDescription") %>
                                </p>

                                <h5 class="h5size"><i class="fa fa-list-alt"></i> PRODUCT DETAILS</h5>
                                <p class="description-text">
                                    <%# Eval("PProductDetails") %>
                                </p>

                                <h5 class="h5size"><i class="fa fa-leaf"></i> MATERIAL & CARE</h5>
                                <p class="description-text">
                                  <!--  <%# Eval("PMaterialCare") %> -->
                                    <ul>
                                        <li>Daily Care: Vacuum weekly using the upholstery attachment to prevent dirt from becoming "ground in" to the fibers.</li>
                                        <li>Spills: Blot, never rub. Rubbing pushes the liquid deeper into the padding. Use a clean, white cloth to soak up the spill.</li>
                                        <li>Cleaning Codes: Check the tag under the cushion:<br />
                                            <small>
                                                <ol>
                                                    <li>W: Use water-based cleaners.</li>
                                                    <li>S: Use solvent-based cleaners (dry clean only).</li>
                                                    <li>WS: Either water or solvent.</li>
                                                    <li>X: Vacuum only (no liquids).</li>

                                                </ol>
                                            </small>

                                        </li>
                                    </ul>
                                </p>

                                <div style="background: #f8f9fa; padding: 20px; border-radius: 12px; margin-top: 30px;">
                                    <p style="margin-bottom:10px;"><i class="fa fa-truck icon-style"></i>
                                        <%# ((int)Eval("FreeDelivery")==1)? "Free Delivery Available"
                                            : "Shipping Charges Apply" %>
                                    </p>
                                    <p style="margin-bottom:10px;"><i class="fa fa-refresh icon-style"></i>
                                        <%# ((int)Eval("30DayRet")==1)? "30 Days Easy Returns" : "" %>
                                    </p>
                                    <p style="margin-bottom:0;"><i class="fa fa-money icon-style"></i>
                                        <%# ((int)Eval("COD")==1)? "Cash on Delivery Available" : "" %>
                                    </p>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </asp:Content>