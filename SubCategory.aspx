<%@ Page Title="Manage Sub-Categories" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true"
    CodeFile="SubCategory.aspx.cs" Inherits="SubCategory" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <style>
    /* 1. The "Assembling" Animation */
    @keyframes layerAssemble {
        0% { box-shadow: 0 0 0 rgba(0,0,0,0); }
        100% { box-shadow: 5px 5px 0px var(--accent-gold), 10px 10px 20px rgba(0,0,0,0.1); }
    }

    .btn-subcat-premium {
        background: #0f172a; /* Deep Navy */
        color: #ffffff !important;
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 14px !important;
        padding: 12px 28px !important;
        font-weight: 700 !important;
        font-size: 13px !important;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 12px;
        transition: all 0.4s cubic-bezier(0.25, 1, 0.5, 1);
        cursor: pointer;
        position: relative;
        width: 100%;
    }

    .btn-subcat-premium:hover {
        background: #1e293b;
        transform: translate(-4px, -4px); /* Moves up and left */
        animation: layerAssemble 0.3s forwards;
        color: var(--accent-gold) !important;
    }

    /* Icon Animation: The 'Plus' expands and glows */
    .btn-subcat-premium i {
        font-size: 16px;
        transition: all 0.3s ease;
    }

    .btn-subcat-premium:hover i {
        transform: scale(1.3);
        text-shadow: 0 0 8px var(--accent-gold);
    }

    /* Subtle internal shine */
    .btn-subcat-premium::after {
        content: '';
        position: absolute;
        top: 0; left: 0;
        width: 100%; height: 50%;
        background: linear-gradient(to bottom, rgba(255,255,255,0.05), transparent);
        border-radius: 14px 14px 0 0;
    }
</style>
        <style>
    /* 1. Page Load Animation: "The Unblur Slide" */
    @keyframes unblurSlide {
        0% { 
            opacity: 0; 
            transform: translateX(30px) scale(0.9); 
            filter: blur(8px); 
        }
        100% { 
            opacity: 1; 
            transform: translateX(0) scale(1); 
            filter: blur(0); 
        }
    }

    .btn-cancel-unique {
        background: rgba(241, 245, 249, 0.5); /* Semi-transparent Slate */
        backdrop-filter: blur(4px);
        color: #94a3b8 !important; /* Muted Slate text */
        border: 1.5px dashed #cbd5e1 !important; /* Unique dashed border */
        border-radius: 14px !important;
        padding: 12px 25px !important;
        font-weight: 700 !important;
        font-size: 13px !important;
        text-transform: uppercase;
        letter-spacing: 1.2px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        cursor: pointer;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        width: 100%;
        
        /* Apply the page load animation */
        animation: unblurSlide 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
        animation-delay: 0.2s; /* Slight delay to feel 'staggered' after main content */
    }

    .btn-cancel-unique:hover {
        background: #fff1f2; /* Soft Red tint */
        color: #e11d48 !important; /* Rose Red text */
        border: 1.5px solid #fecdd3 !important; /* Switch to solid on hover */
        transform: translateY(-2px);
        box-shadow: 0 10px 15px -3px rgba(225, 29, 72, 0.1);
    }

    /* Icon Animation: The "Shake of Doubt" */
    .btn-cancel-unique:hover i {
        animation: shakeRotate 0.4s ease-in-out infinite alternate;
    }

    @keyframes shakeRotate {
        from { transform: rotate(-10deg); }
        to { transform: rotate(10deg); }
    }
</style>
        <style>
    /* 1. The Border Trace Animation */
    @keyframes borderTrace {
        0%, 100% { clip-path: inset(0 0 95% 0); }
        25% { clip-path: inset(0 95% 0 0); }
        50% { clip-path: inset(95% 0 0 0); }
        75% { clip-path: inset(0 0 0 95%); }
    }

    .btn-edit-subcat-unique {
        background: #1e293b; /* Dark slate */
        color: #adff2f !important; /* Cyber Lime */
        border: 1px solid rgba(173, 255, 47, 0.3);
        border-radius: 12px !important;
        padding: 10px 14px !important;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        cursor: pointer;
        position: relative;
        overflow: hidden;
    }

    /* The glowing trace effect that appears on hover */
    .btn-edit-subcat-unique::before {
        content: '';
        position: absolute;
        top: 0; left: 0; right: 0; bottom: 0;
        border: 2px solid #adff2f;
        border-radius: 12px;
        opacity: 0;
        transition: opacity 0.3s;
    }

    .btn-edit-subcat-unique:hover {
        background: #0f172a;
        transform: scale(1.15) rotate(3deg);
        color: #ffffff !important;
        border-color: #adff2f;
        box-shadow: 0 0 20px rgba(173, 255, 47, 0.4);
    }

    .btn-edit-subcat-unique:hover::before {
        opacity: 1;
        animation: borderTrace 2s linear infinite;
    }

    /* Icon Animation: The "Floating Tool" */
    .btn-edit-subcat-unique i {
        transition: all 0.4s ease;
    }

    .btn-edit-subcat-unique:hover i {
        transform: translateY(-2px) rotate(-15deg);
        text-shadow: 0 4px 8px rgba(0,0,0,0.5);
    }
</style>
        <div class="dashboard-container">
            <h2 style="font-weight: 800; color: var(--text-primary); margin-bottom: 20px;">Manage Sub-Categories</h2>

            <div class="row">
                <!-- Form -->
                <div class="col-md-4">
                    <div
                        style="background: white; padding: 25px; border-radius: 15px; box-shadow: var(--card-shadow); margin-bottom: 20px;">
                        <h4 style="margin-top: 0; font-weight: 700; margin-bottom: 20px;">Add / Edit Sub-Category</h4>

                        <asp:HiddenField ID="hfSubCatID" runat="server" />

                        <div class="form-group">
                            <label>Main Category</label>
                            <asp:DropDownList ID="ddlMainCatID" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorMainCatID" runat="server"
                                ErrorMessage="Main Category is required" CssClass="text-danger"
                                ControlToValidate="ddlMainCatID" InitialValue="0" ValidationGroup="SubCat">
                            </asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <label>Sub-Category Name</label>
                            <asp:TextBox ID="txtSubCategory" CssClass="form-control" runat="server"
                                placeholder="Enter Sub-Category Name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorSubCategory" runat="server"
                                ErrorMessage="Sub-Category Name is required" CssClass="text-danger"
                                ControlToValidate="txtSubCategory" ValidationGroup="SubCat">
                            </asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group" style="margin-top: 20px;">
                           <asp:LinkButton ID="btnAddSubCategory" runat="server" 
    OnClick="btnAddSubCategory_Click" 
    ValidationGroup="SubCat"
    CssClass="btn-subcat-premium">
    <i class="fa fa-sitemap"></i>
    <span>Add Sub-Category</span>
</asp:LinkButton>
<br /><br />
                            <asp:LinkButton ID="btnCancel" runat="server" 
    OnClick="btnCancel_Click" 
    Visible="false"
    CssClass="btn-cancel-unique">
    <i class="fa fa-ban"></i>
    <span>Discard Entry</span>
</asp:LinkButton>
                        </div>
                    </div>
                </div>

                <!-- List -->
                <div class="col-md-8">
                    <div
                        style="background: white; padding: 25px; border-radius: 15px; box-shadow: var(--card-shadow); overflow-x: auto;">
                        <div
                            style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; gap: 15px;">
                            <h4 style="margin: 0; font-weight: 700; flex-shrink: 0;">All Sub-Categories</h4>
                            <div style="display: flex; gap: 10px; flex-grow: 1; justify-content: flex-end;">
                                <div class="input-group" style="max-width: 250px;">
                                    <span class="input-group-addon"><i class="fa fa-search"></i></span>
                                    <input type="text" id="txtSearchSubCategory" class="form-control"
                                        placeholder="Search Sub-Category..."
                                        onkeyup="filterTable('txtSearchSubCategory', '#tblSubCategories')" />
                                </div>
                                <button type="button" class="btn btn-info"
                                    onclick="exportTableToPDF('#tblSubCategories', 'Sub-Category List', 'SubCategories.pdf', true)"
                                    style="border-radius: 5px;"><i class="fa fa-file-pdf-o"></i> Export PDF</button>
                            </div>
                        </div>

                        <table id="tblSubCategories" class="table" style="width: 100%;">
                            <thead>
                                <tr style="border-bottom: 2px solid #f1f2f6;">
                                    <th style="padding: 12px; color: var(--text-secondary);">#</th>
                                    <th style="padding: 12px; color: var(--text-secondary);">Sub-Category</th>
                                    <th style="padding: 12px; color: var(--text-secondary);">Main Category</th>
                                    <th style="padding: 12px; color: var(--text-secondary); text-align: right;">Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptrSubCat" runat="server" OnItemCommand="rptrSubCat_ItemCommand">
                                    <ItemTemplate>
                                        <tr style="border-bottom: 1px solid #f8f9fa;">
                                            <td style="padding: 12px; font-weight: 600;">#<%# Eval("SubCatID") %>
                                            </td>
                                            <td style="padding: 12px;">
                                                <%# Eval("SubCatName") %>
                                            </td>
                                            <td style="padding: 12px;"><span class="label label-info">
                                                    <%# Eval("CatName") %>
                                                </span></td>
                                            <td style="padding: 12px; text-align: right;">
                                               <asp:LinkButton ID="btnEdit" runat="server" 
    CommandName="EditSubCategory"
    CommandArgument='<%# Eval("SubCatID") %>'
    CssClass="btn-edit-subcat-unique"
    ToolTip="Refine Sub-Category">
    <i class="fa fa-pencil"></i>
</asp:LinkButton>

                                                <asp:LinkButton ID="btnDelete" runat="server"
                                                    CommandName="DeleteSubCategory"
                                                    CommandArgument='<%# Eval("SubCatID") %>'
                                                    CssClass="btn btn-danger btn-sm"
                                                    style="background: #ffe2e6; color: #ff7675; border: none; border-radius: 50px;"
                                                    CausesValidation="false"
                                                    OnClientClick="return confirm('Are you sure you want to delete this sub-category?');">
                                                    <i class="fa fa-trash"></i>
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </asp:Content>