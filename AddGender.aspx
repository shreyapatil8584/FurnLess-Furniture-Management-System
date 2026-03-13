<%@ Page Title="Manage Gender" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true"
    CodeFile="AddGender.aspx.cs" Inherits="AddGender" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="dashboard-container">
            <h2 style="font-weight: 800; color: var(--text-primary); margin-bottom: 20px;">Manage Users / Target</h2>

            <div class="row">
                <!-- Form -->
                <div class="col-md-4">
                    <div
                        style="background: white; padding: 25px; border-radius: 15px; box-shadow: var(--card-shadow); margin-bottom: 20px;">
                        <h4 style="margin-top: 0; font-weight: 700; margin-bottom: 20px;">Add / Edit User Type</h4>

                        <asp:HiddenField ID="hfGenderID" runat="server" />

                        <div class="form-group">
                            <label>User Type</label>
                            <asp:TextBox ID="txtGender" CssClass="form-control" runat="server"
                                placeholder="Enter User Type"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorGender" runat="server"
                                ErrorMessage="Gender Name is required" CssClass="text-danger"
                                ControlToValidate="txtGender" ValidationGroup="Gender"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group" style="margin-top: 20px;">
                            <asp:Button ID="btnAddGender" CssClass="btn btn-success btn-block" runat="server"
                                Text="Add Gender" OnClick="btnAddGender_Click" ValidationGroup="Gender"
                                style="background: var(--admin-primary); border: none; padding: 10px; font-weight: 600;" />

                            <asp:Button ID="btnCancel" CssClass="btn btn-default btn-block" runat="server" Text="Cancel"
                                OnClick="btnCancel_Click" Visible="false"
                                style="border: 1px solid #ddd; padding: 10px; font-weight: 600;" />
                        </div>
                    </div>
                </div>

                <!-- List -->
                <div class="col-md-8">
                    <div
                        style="background: white; padding: 25px; border-radius: 15px; box-shadow: var(--card-shadow); overflow-x: auto;">
                        <div
                            style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; gap: 15px;">
                            <h4 style="margin: 0; font-weight: 700; flex-shrink: 0;">All Genders</h4>
                            <div style="display: flex; gap: 10px; flex-grow: 1; justify-content: flex-end;">
                                <div class="input-group" style="max-width: 250px;">
                                    <span class="input-group-addon"><i class="fa fa-search"></i></span>
                                    <input type="text" id="txtSearchTarget" class="form-control"
                                        placeholder="Search Gender..."
                                        onkeyup="filterTable('txtSearchTarget', '#tblTarget')" />
                                </div>
                                <button type="button" class="btn btn-info"
                                    onclick="exportTableToPDF('#tblTarget', 'Target/Gender List', 'TargetList.pdf', true)"
                                    style="border-radius: 5px;"><i class="fa fa-file-pdf-o"></i> Export PDF</button>
                            </div>
                        </div>

                        <table id="tblTarget" class="table" style="width: 100%;">
                            <thead>
                                <tr style="border-bottom: 2px solid #f1f2f6;">
                                    <th style="padding: 12px; color: var(--text-secondary);">#</th>
                                    <th style="padding: 12px; color: var(--text-secondary);">Gender Name</th>
                                    <th style="padding: 12px; color: var(--text-secondary); text-align: right;">Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptrGender" runat="server" OnItemCommand="rptrGender_ItemCommand">
                                    <ItemTemplate>
                                        <tr style="border-bottom: 1px solid #f8f9fa;">
                                            <td style="padding: 12px; font-weight: 600;">#<%# Eval("GenderID") %>
                                            </td>
                                            <td style="padding: 12px;">
                                                <%# Eval("GenderName") %>
                                            </td>
                                            <td style="padding: 12px; text-align: right;">
                                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditGender"
                                                    CommandArgument='<%# Eval("GenderID") %>'
                                                    CssClass="btn btn-primary btn-sm"
                                                    style="background: var(--admin-primary); border: none; border-radius: 50px; margin-right: 5px;">
                                                    <i class="fa fa-pencil"></i>
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteGender"
                                                    CommandArgument='<%# Eval("GenderID") %>'
                                                    CssClass="btn btn-danger btn-sm"
                                                    style="background: #ffe2e6; color: #ff7675; border: none; border-radius: 50px;"
                                                    CausesValidation="false"
                                                    OnClientClick="return confirm('Are you sure you want to delete this gender?');">
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