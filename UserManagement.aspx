<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true"
    CodeFile="UserManagement.aspx.cs" Inherits="UserManagement" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="dashboard-container">
            <div
                style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; gap: 15px;">
                <h2 style="font-weight: 800; color: var(--text-primary); margin: 0; flex-shrink: 0;">Customer Details
                </h2>
                <div style="display: flex; gap: 10px; flex-grow: 1; justify-content: flex-end;">
                    <div class="input-group" style="max-width: 300px;">
                        <span class="input-group-addon"><i class="fa fa-search"></i></span>
                        <input type="text" id="txtSearchUsers" class="form-control" placeholder="Search customers..."
                            onkeyup="filterTable('txtSearchUsers', '#tblUsers')" />
                    </div>
                    <button type="button" class="btn btn-info"
                        onclick="exportTableToPDF('#tblUsers', 'Customer Details Report', 'CustomerReport.pdf', false)"
                        style="border-radius: 5px;"><i class="fa fa-file-pdf-o"></i> Export PDF</button>
                </div>
            </div>

            <div
                style="background: white; padding: 25px; border-radius: 15px; box-shadow: var(--card-shadow); overflow-x: auto;">
                <table id="tblUsers" class="table" style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="border-bottom: 2px solid #f1f2f6; text-align: left;">
                            <th style="padding: 15px; color: var(--text-secondary);">User ID</th>
                            <th style="padding: 15px; color: var(--text-secondary);">Name</th>
                            <th style="padding: 15px; color: var(--text-secondary);">Username</th>
                            <th style="padding: 15px; color: var(--text-secondary);">Email</th>
                            <th style="padding: 15px; color: var(--text-secondary);">User Type</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptrUsers" runat="server">
                            <ItemTemplate>
                                <tr style="border-bottom: 1px solid #f8f9fa;">
                                    <td style="padding: 15px; font-weight: 700;">#<%# Eval("Uid") %>
                                    </td>
                                    <td style="padding: 15px; font-weight: 600;">
                                        <%# Eval("Name") %>
                                    </td>
                                    <td style="padding: 15px; color: #666;">
                                        <%# Eval("Username") %>
                                    </td>
                                    <td style="padding: 15px; color: var(--admin-primary);">
                                        <%# Eval("Email") %>
                                    </td>
                                    <td style="padding: 15px;"><span class="badge"
                                            style="background:#e8f5e9; color:#4caf50; padding:5px 10px; border-radius:4px;">
                                            <%# Eval("Usertype") %>
                                        </span></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>
    </asp:Content>