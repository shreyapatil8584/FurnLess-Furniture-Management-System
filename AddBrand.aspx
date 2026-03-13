<%@ Page Title="Manage Brands" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true"
    CodeFile="AddBrand.aspx.cs" Inherits="AddBrand" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <style>
    .btn-edit-premium {
        background: #f5f3ff; /* Very soft lavender */
        color: #7c3aed !important; /* Vivid indigo/purple text */
        border: 1px solid #ddd6fe;
        border-radius: 12px !important; /* Matches your Update/Delete buttons */
        padding: 8px 12px !important;
        font-size: 14px !important;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        cursor: pointer;
        text-decoration: none !important;
        box-shadow: 0 2px 4px rgba(124, 58, 237, 0.05);
    }

    .btn-edit-premium:hover {
        background: #7c3aed; /* Switches to solid Indigo */
        color: white !important;
        border-color: #7c3aed;
        transform: translateY(-2px) scale(1.05);
        box-shadow: 0 8px 15px rgba(124, 58, 237, 0.25);
    }

    /* Icon Animation: Slight tilt when hovering */
    .btn-edit-premium:hover i {
        transform: rotate(-15deg) scale(1.2);
        transition: 0.3s ease;
    }

    .btn-edit-premium i {
        transition: 0.3s ease;
    }
</style>
        <style>
    .btn-add-brand-premium {
        background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
        color: white !important;
        border: none;
        border-radius: 14px !important;
        padding: 12px 25px !important;
        font-weight: 700 !important;
        font-size: 14px !important;
        text-transform: uppercase;
        letter-spacing: 1px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        cursor: pointer;
        box-shadow: 0 10px 20px -5px rgba(15, 23, 42, 0.3);
        width: 100%; /* Keeps the btn-block behavior but looks better */
    }

    .btn-add-brand-premium:hover {
        background: linear-gradient(135deg, #1e293b 0%, var(--accent-gold) 200%);
        transform: translateY(-3px);
        box-shadow: 0 15px 25px -5px rgba(15, 23, 42, 0.4);
        color: #fff !important;
    }

    .btn-add-brand-premium:active {
        transform: translateY(-1px);
    }

    /* Add a subtle shine animation */
    .btn-add-brand-premium::after {
        content: '';
        position: absolute;
        top: 0; left: -100%;
        width: 100%; height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
        transition: 0.5s;
    }

    .btn-add-brand-premium:hover::after {
        left: 100%;
    }
</style>
        <style>
    .btn-cancel-premium {
        background: transparent;
        color: #64748b !important; /* Elegant slate grey */
        border: 2px solid #e2e8f0 !important;
        border-radius: 14px !important;
        padding: 10px 25px !important;
        font-weight: 700 !important;
        font-size: 14px !important;
        text-transform: uppercase;
        letter-spacing: 1px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        cursor: pointer;
        width: 100%;
        position: relative;
        overflow: hidden;
    }

    .btn-cancel-premium:hover {
        background: #f8fafc;
        color: #0f172a !important;
        border-color: #cbd5e1 !important;
        transform: translateY(-2px);
    }

    /* Red "X" icon animation on hover */
    .btn-cancel-premium:hover i {
        color: #ef4444;
        transform: scale(1.2) rotate(90deg);
        transition: 0.3s ease;
    }

    .btn-cancel-premium i {
        transition: 0.3s ease;
    }
</style>
        <div class="dashboard-container">
            <h2 style="font-weight: 800; color: var(--text-primary); margin-bottom: 20px;">Manage Brands</h2>

            <div class="row">
                <!-- Add Brand Form -->
                <div class="col-md-4">
                    <div
                        style="background: white; padding: 25px; border-radius: 15px; box-shadow: var(--card-shadow); margin-bottom: 20px;">
                        <h4 style="margin-top: 0; font-weight: 700; margin-bottom: 20px;">Add / Edit Brand</h4>

                        <asp:HiddenField ID="hfBrandID" runat="server" />

                        <div class="form-group">
                            <label>Brand Name</label>
                            <asp:TextBox ID="txtBrand" CssClass="form-control" runat="server"
                                placeholder="Enter Brand Name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvBrand" runat="server" ControlToValidate="txtBrand"
                                ErrorMessage="Brand Name is required" CssClass="text-danger" Display="Dynamic"
                                ValidationGroup="Brand"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group" style="margin-top: 20px;">
                           <asp:LinkButton ID="btnAddBrand" runat="server" 
    OnClick="btnAddBrand_Click" 
    ValidationGroup="Brand"
    CssClass="btn-add-brand-premium">
    <i class="fa fa-plus-square"></i>
    <span>Confirm & Add Brand</span>
</asp:LinkButton>
<br /><br />
                            <asp:LinkButton ID="btnCancel" runat="server" 
    OnClick="btnCancel_Click" 
    Visible="false"
    CssClass="btn-cancel-premium">
    <i class="fa fa-times"></i>
    <span>Discard Changes</span>
</asp:LinkButton>
                        </div>
                    </div>
                </div>

                <!-- Brands List -->
                <div class="col-md-8">
                    <div
                        style="background: white; padding: 25px; border-radius: 15px; box-shadow: var(--card-shadow); overflow-x: auto;">
                        <div
                            style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; gap: 15px;">
                            <h4 style="margin: 0; font-weight: 700; flex-shrink: 0;">All Brands</h4>
                            <div style="display: flex; gap: 10px; flex-grow: 1; justify-content: flex-end;">
                                <div class="input-group" style="max-width: 250px;">
                                    <span class="input-group-addon"><i class="fa fa-search"></i></span>
                                    <input type="text" id="txtSearchBrand" class="form-control"
                                        placeholder="Search Brand..."
                                        onkeyup="filterTable('txtSearchBrand', '#tblBrands')" />
                                </div>
                                <button type="button" class="btn btn-info"
                                    onclick="exportTableToPDF('#tblBrands', 'Brand List', 'Brands.pdf', true)"
                                    style="border-radius: 5px;"><i class="fa fa-file-pdf-o"></i> Export PDF</button>
                            </div>
                        </div>

                        <table id="tblBrands" class="table" style="width: 100%;">
                            <thead>
                                <tr style="border-bottom: 2px solid #f1f2f6;">
                                    <th style="padding: 12px; color: var(--text-secondary);">#</th>
                                    <th style="padding: 12px; color: var(--text-secondary);">Brand Name</th>
                                    <th style="padding: 12px; color: var(--text-secondary); text-align: right;">Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptrBrands" runat="server" OnItemCommand="rptrBrands_ItemCommand">
                                    <ItemTemplate>
                                        <tr style="border-bottom: 1px solid #f8f9fa;">
                                            <td style="padding: 12px; font-weight: 600;">#<%# Eval("BrandID") %>
                                            </td>
                                            <td style="padding: 12px;">
                                                <%# Eval("Name") %>
                                            </td>
                                            <td style="padding: 12px; text-align: right;">
                                               <asp:LinkButton ID="btnEdit" runat="server" 
    CommandName="EditBrand"
    CommandArgument='<%# Eval("BrandID") %>'
    CssClass="btn-edit-premium"
    ToolTip="Modify Brand Details">
    <i class="fa fa-pencil"></i>
</asp:LinkButton>

                                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteBrand"
                                                    CommandArgument='<%# Eval("BrandID") %>'
                                                    CssClass="btn btn-danger btn-sm"
                                                    style="background: #ffe2e6; color: #ff7675; border: none; border-radius: 50px;"
                                                    CausesValidation="false"
                                                    OnClientClick="return confirm('Are you sure you want to delete this brand?');">
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