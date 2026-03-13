<%@ Page Title="Manage Categories" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true"
    CodeFile="AddCategory.aspx.cs" Inherits="AddCategory" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <style>
    /* 1. The Breathing Pulse Animation */
    @keyframes glowPulse {
        0% { box-shadow: 0 5px 15px rgba(15, 23, 42, 0.4); }
        50% { box-shadow: 0 5px 25px rgba(59, 130, 246, 0.6); transform: scale(1.01); }
        100% { box-shadow: 0 5px 15px rgba(15, 23, 42, 0.4); }
    }

    /* 2. The Shimmer Swipe Animation */
    @keyframes shimmer {
        0% { left: -100%; }
        100% { left: 100%; }
    }

    .btn-category-animated {
        background: linear-gradient(135deg, #0f172a 0%, #2563eb 100%);
        color: white !important;
        border: none;
        border-radius: 16px !important;
        padding: 14px 30px !important;
        font-weight: 800 !important;
        font-size: 13px !important;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 12px;
        position: relative;
        overflow: hidden;
        cursor: pointer;
        transition: all 0.4s ease;
        animation: glowPulse 3s infinite ease-in-out; /* Continuous breathing */
    }

    /* The Shimmer Layer */
    .btn-category-animated::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 50%;
        height: 100%;
        background: linear-gradient(
            to right, 
            transparent, 
            rgba(255, 255, 255, 0.2), 
            transparent
        );
        transform: skewX(-25deg);
        animation: shimmer 4s infinite; /* Periodic light swipe */
    }

    .btn-category-animated:hover {
        background: linear-gradient(135deg, #1e293b 0%, #3b82f6 100%);
        transform: translateY(-4px);
        animation: none; /* Stops pulse so user has total control */
        box-shadow: 0 15px 30px rgba(37, 99, 235, 0.4);
    }

    .btn-category-animated i {
        font-size: 16px;
        transition: 0.4s;
    }

    .btn-category-animated:hover i {
        transform: rotate(90deg);
    }
</style>
        <style>
    /* 1. Subtle Border Glow Animation */
    @keyframes borderGlow {
        0% { border-color: #e2e8f0; box-shadow: 0 0 0 rgba(0,0,0,0); }
        50% { border-color: #cbd5e1; box-shadow: 0 0 10px rgba(0,0,0,0.05); }
        100% { border-color: #e2e8f0; box-shadow: 0 0 0 rgba(0,0,0,0); }
    }

    .btn-cancel-animated {
        background: rgba(255, 255, 255, 0.6);
        backdrop-filter: blur(5px);
        color: #64748b !important;
        border: 2px solid #e2e8f0 !important;
        border-radius: 16px !important; /* Matches Category button */
        padding: 14px 25px !important;
        font-weight: 700 !important;
        font-size: 13px !important;
        text-transform: uppercase;
        letter-spacing: 1.2px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        position: relative;
        overflow: hidden;
        transition: all 0.4s cubic-bezier(0.23, 1, 0.32, 1);
        animation: borderGlow 4s infinite ease-in-out;
    }

    /* The "Slide-in Red" background effect on hover */
    .btn-cancel-animated::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(239, 68, 68, 0.08), transparent);
        transition: 0.5s;
    }

    .btn-cancel-animated:hover {
        color: #ef4444 !important; /* Turns red on hover */
        border-color: #fca5a5 !important;
        background: #fff5f5;
        transform: translateY(-2px);
    }

    .btn-cancel-animated:hover::before {
        left: 100%;
    }

    /* Icon Animation: Spins and scales up */
    .btn-cancel-animated i {
        transition: all 0.5s ease;
    }

    .btn-cancel-animated:hover i {
        transform: rotate(-180deg) scale(1.3);
    }
</style>
        <style>
    /* 1. Floating & Scribble Animation */
    @keyframes iconScribble {
        0% { transform: translate(0, 0) rotate(0deg); }
        25% { transform: translate(2px, -2px) rotate(5deg); }
        50% { transform: translate(-1px, -3px) rotate(-5deg); }
        75% { transform: translate(3px, -1px) rotate(3deg); }
        100% { transform: translate(0, 0) rotate(0deg); }
    }

    /* 2. Soft Aura Pulse */
    @keyframes auraGlow {
        0% { box-shadow: 0 0 0px rgba(99, 102, 241, 0); }
        50% { box-shadow: 0 0 15px rgba(99, 102, 241, 0.4); }
        100% { box-shadow: 0 0 0px rgba(99, 102, 241, 0); }
    }

    .btn-edit-category-modern {
        background: #ffffff;
        color: #6366f1 !important; /* Indigo Modern Tone */
        border: 1px solid #e0e7ff;
        border-radius: 12px !important;
        padding: 10px 14px !important;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        cursor: pointer;
        position: relative;
        overflow: hidden;
        animation: auraGlow 3s infinite;
    }

    .btn-edit-category-modern:hover {
        background: #6366f1;
        color: #ffffff !important;
        border-color: #6366f1;
        transform: translateY(-3px) scale(1.1);
        box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
    }

    .btn-edit-category-modern i {
        font-size: 15px;
        transition: color 0.3s ease;
    }

    /* Trigger scribble on hover */
    .btn-edit-category-modern:hover i {
        animation: iconScribble 0.6s infinite linear;
    }

    /* Tooltip styling if needed */
    .btn-edit-category-modern::after {
        content: 'Edit';
        position: absolute;
        bottom: -30px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 10px;
        font-weight: 800;
        color: #6366f1;
        opacity: 0;
        transition: 0.3s;
    }

    .btn-edit-category-modern:hover::after {
        opacity: 1;
        bottom: -20px;
    }
</style>
        <div class="dashboard-container">
            <h2 style="font-weight: 800; color: var(--text-primary); margin-bottom: 20px;">Manage Categories</h2>

            <div class="row">
                <!-- Form -->
                <div class="col-md-4">
                    <div
                        style="background: white; padding: 25px; border-radius: 15px; box-shadow: var(--card-shadow); margin-bottom: 20px;">
                        <h4 style="margin-top: 0; font-weight: 700; margin-bottom: 20px;">Add / Edit Category</h4>

                        <asp:HiddenField ID="hfCatID" runat="server" />

                        <div class="form-group">
                            <label>Category Name</label>
                            <asp:TextBox ID="txtCategory" CssClass="form-control" runat="server"
                                placeholder="Enter Category Name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorCategory" runat="server"
                                ErrorMessage="Category Name is required" CssClass="text-danger"
                                ControlToValidate="txtCategory" ValidationGroup="Category"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group" style="margin-top: 20px;">
                            <asp:LinkButton ID="btnAddCategory" runat="server" 
    OnClick="btnAddCategory_Click" 
    ValidationGroup="Category"
    CssClass="btn-category-animated">
    <i class="fa fa-folder-plus"></i>
    <span>Create New Category</span>
</asp:LinkButton>
<br /><br />
                           <asp:LinkButton ID="btnCancel" runat="server" 
    OnClick="btnCancel_Click" 
    Visible="false"
    CssClass="btn-cancel-animated">
    <i class="fa fa-times-circle"></i>
    <span>Discard Changes</span>
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
                            <h4 style="margin: 0; font-weight: 700; flex-shrink: 0;">All Categories</h4>
                            <div style="display: flex; gap: 10px; flex-grow: 1; justify-content: flex-end;">
                                <div class="input-group" style="max-width: 250px;">
                                    <span class="input-group-addon"><i class="fa fa-search"></i></span>
                                    <input type="text" id="txtSearchCategory" class="form-control"
                                        placeholder="Search Category..."
                                        onkeyup="filterTable('txtSearchCategory', '#tblCategories')" />
                                </div>
                                <button type="button" class="btn btn-info"
                                    onclick="exportTableToPDF('#tblCategories', 'Category List', 'Categories.pdf', true)"
                                    style="border-radius: 5px;"><i class="fa fa-file-pdf-o"></i> Export PDF</button>
                            </div>
                        </div>

                        <table id="tblCategories" class="table" style="width: 100%;">
                            <thead>
                                <tr style="border-bottom: 2px solid #f1f2f6;">
                                    <th style="padding: 12px; color: var(--text-secondary);">#</th>
                                    <th style="padding: 12px; color: var(--text-secondary);">Category Name</th>
                                    <th style="padding: 12px; color: var(--text-secondary); text-align: right;">Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptrCategory" runat="server" OnItemCommand="rptrCategory_ItemCommand">
                                    <ItemTemplate>
                                        <tr style="border-bottom: 1px solid #f8f9fa;">
                                            <td style="padding: 12px; font-weight: 600;">#<%# Eval("CatID") %>
                                            </td>
                                            <td style="padding: 12px;">
                                                <%# Eval("CatName") %>
                                            </td>
                                            <td style="padding: 12px; text-align: right;">
                                                <asp:LinkButton ID="btnEdit" runat="server" 
    CommandName="EditCategory"
    CommandArgument='<%# Eval("CatID") %>'
    CssClass="btn-edit-category-modern"
    ToolTip="Edit Category Information">
    <i class="fa fa-pencil"></i>
</asp:LinkButton>

                                                <asp:LinkButton ID="btnDelete" runat="server"
                                                    CommandName="DeleteCategory" CommandArgument='<%# Eval("CatID") %>'
                                                    CssClass="btn btn-danger btn-sm"
                                                    style="background: #ffe2e6; color: #ff7675; border: none; border-radius: 50px;"
                                                    CausesValidation="false"
                                                    OnClientClick="return confirm('Are you sure you want to delete this category?');">
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