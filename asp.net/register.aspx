<%@ Page Title="" Language="C#" MasterPageFile="~/public.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="asp.net.register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <!-- ============ PAGE CONTENT ============ -->

    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - SIMS | Smart Student Internship Management System</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <div id="public-header-root"></div>


        <div class="login-page">
            <div class="login-main">

                <!-- ============ LEFT BRAND PANEL ============ -->
                <div class="login-left">



                    <h1 class="login-welcome-title">Start Your Journey with <span style="color: var(--blue-600)">SIMS</span></h1>
                    <p class="login-welcome-desc">
                        Create your account and explore thousands of internships from top companies.
                    </p>

                    <div class="login-features">
                        <div class="login-feature">
                            <span class="login-feature-icon icon-blue"><i class="fa-solid fa-briefcase"></i></span>
                            <div>
                                <h4>Discover Opportunities</h4>
                                <p>Find internships that match your skills and interests.</p>
                            </div>
                        </div>
                        <div class="login-feature">
                            <span class="login-feature-icon icon-green"><i class="fa-solid fa-chart-simple"></i></span>
                            <div>
                                <h4>Track &amp; Manage</h4>
                                <p>Track your applications and interview updates in one place.</p>
                            </div>
                        </div>
                        <div class="login-feature">
                            <span class="login-feature-icon icon-purple"><i class="fa-solid fa-user-group"></i></span>
                            <div>
                                <h4>Build Your Profile</h4>
                                <p>Showcase your skills and get noticed by top companies.</p>
                            </div>
                        </div>
                        <div class="login-feature">
                            <span class="login-feature-icon" style="background: #fef3c7; color: #d97706;"><i class="fa-solid fa-award"></i></span>
                            <div>
                                <h4>Grow Your Career</h4>
                                <p>Learn, grow and achieve your career goals.</p>
                            </div>
                        </div>
                    </div>



                    <div class="register-safe-box">
                        <span class="login-feature-icon icon-blue"><i class="fa-solid fa-shield-halved"></i></span>
                        <div>
                            <h4>Safe &amp; Secure</h4>
                            <p>Your information is protected and safe with us.</p>
                        </div>
                    </div>
                </div>

                <!-- ============ RIGHT REGISTER PANEL ============ -->
                <div class="login-right register-right">
                    <div class="login-card register-card">

                        <h2 class="login-card-title">Create Your Account</h2>
                        <p class="login-card-sub">Join SIMS and kickstart your career journey</p>

                        <!-- Hidden field for active role -->
                        <asp:HiddenField ID="hfSelectedRole" runat="server" ClientIDMode="Static" Value="student" />

                        <!-- Role tabs -->
                        <div class="role-tabs" id="roleTabs">
                            <div class="role-tab active" data-role="student">
                                <i class="fa-solid fa-user-graduate"></i>Student
                            </div>
                            <div class="role-tab" data-role="company">
                                <i class="fa-solid fa-building"></i>Company
                            </div>
                        </div>

                        <div id="registerForm">

                            <!-- ================= STUDENT FIELDS ================= -->
                            <div class="role-fields active" data-role-fields="student">
                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="s_fullname">Full Name</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-user input-icon"></i>
                                            <asp:TextBox ID="s_fullname" ClientIDMode="Static" runat="server" placeholder="Enter your full name"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your full name.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="s_dob">Date of Birth</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-regular fa-calendar input-icon"></i>
                                            <asp:TextBox ID="s_dob" ClientIDMode="Static" runat="server" TextMode="Date" placeholder="DD / MM / YYYY"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please select your date of birth.</span>
                                    </div>
                                </div>

                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="s_email">Email Address</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-envelope input-icon"></i>
                                            <asp:TextBox ID="s_email" ClientIDMode="Static" runat="server" TextMode="Email" placeholder="Enter your email address"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter a valid email address.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="s_mobile">Mobile Number</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-phone input-icon"></i>
                                            <asp:TextBox ID="s_mobile" ClientIDMode="Static" runat="server" TextMode="Phone" placeholder="Enter mobile number"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter a valid mobile number.</span>
                                    </div>
                                </div>

                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="s_enrollment">Enrollment Number</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-id-card input-icon"></i>
                                            <asp:TextBox ID="s_enrollment" ClientIDMode="Static" runat="server" placeholder="Enter your enrollment number"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your enrollment number.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="s_password">Password</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-lock input-icon"></i>
                                            <asp:TextBox ID="s_password" ClientIDMode="Static" runat="server" TextMode="Password" placeholder="Create a password"></asp:TextBox>
                                            <i class="fa-regular fa-eye toggle-password" data-target="s_password"></i>
                                        </div>
                                        <span class="field-error">Password must be at least 6 characters.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="s_confirm">Confirm Password</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-lock input-icon"></i>
                                            <asp:TextBox ID="s_confirm" ClientIDMode="Static" runat="server" TextMode="Password" placeholder="Confirm your password"></asp:TextBox>
                                            <i class="fa-regular fa-eye toggle-password" data-target="s_confirm"></i>
                                        </div>
                                        <span class="field-error">Passwords do not match.</span>
                                    </div>
                                </div>

                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="s_college">College / University</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-building-columns input-icon"></i>
                                            <asp:TextBox ID="s_college" ClientIDMode="Static" runat="server" placeholder="Enter your college or university name"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your college / university.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="s_course">Course / Degree</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-graduation-cap input-icon"></i>
                                            <asp:DropDownList ID="s_course" ClientIDMode="Static" runat="server">
                                                <asp:ListItem Value="">Select your course</asp:ListItem>
                                                <asp:ListItem>B.Tech / B.E.</asp:ListItem>
                                                <asp:ListItem>B.Sc</asp:ListItem>
                                                <asp:ListItem>B.Com</asp:ListItem>
                                                <asp:ListItem>BBA</asp:ListItem>
                                                <asp:ListItem>BCA</asp:ListItem>
                                                <asp:ListItem>M.Tech / M.E.</asp:ListItem>
                                                <asp:ListItem>MBA</asp:ListItem>
                                                <asp:ListItem>MCA</asp:ListItem>
                                                <asp:ListItem>M.Sc</asp:ListItem>
                                                <asp:ListItem>Other</asp:ListItem>
                                            </asp:DropDownList>
                                            <i class="fa-solid fa-chevron-down select-caret"></i>
                                        </div>
                                        <span class="field-error">Please select your course.</span>
                                    </div>
                                </div>

                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="s_gradyear">Graduation Year</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-regular fa-calendar input-icon"></i>
                                            <asp:DropDownList ID="s_gradeyear" ClientIDMode="Static" runat="server">
                                                <asp:ListItem Value="">Select year</asp:ListItem>
                                                <asp:ListItem>2024</asp:ListItem>
                                                <asp:ListItem>2025</asp:ListItem>
                                                <asp:ListItem>2026</asp:ListItem>
                                                <asp:ListItem>2027</asp:ListItem>
                                                <asp:ListItem>2028</asp:ListItem>
                                                <asp:ListItem>2029</asp:ListItem>
                                                <asp:ListItem>2030</asp:ListItem>
                                            </asp:DropDownList>
                                            <i class="fa-solid fa-chevron-down select-caret"></i>
                                        </div>
                                        <span class="field-error">Please select your graduation year.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="s_location">Location</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-location-dot input-icon"></i>
                                            <asp:TextBox ID="s_location" ClientIDMode="Static" runat="server" placeholder="Enter your city"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your city.</span>
                                    </div>
                                </div>
                            </div>

                            <!-- ================= COMPANY FIELDS ================= -->
                            <div class="role-fields" data-role-fields="company">
                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="c_company">Company Name</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-building input-icon"></i>
                                            <asp:TextBox ID="c_company" ClientIDMode="Static" runat="server" placeholder="Enter your company name"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your company name.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="c_contact">Contact Person Name</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-user input-icon"></i>
                                            <asp:TextBox ID="c_contact" ClientIDMode="Static" runat="server" placeholder="Enter HR / contact person name"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter the contact person's name.</span>
                                    </div>
                                </div>

                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="c_email">Email Address</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-envelope input-icon"></i>
                                            <asp:TextBox ID="c_email" ClientIDMode="Static" runat="server" TextMode="Email" placeholder="Enter your company email address"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter a valid email address.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="c_mobile">Mobile Number</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-phone input-icon"></i>
                                            <asp:TextBox ID="c_mobile" ClientIDMode="Static" runat="server" TextMode="Phone" placeholder="Enter mobile number"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter a valid mobile number.</span>
                                    </div>
                                </div>

                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="c_password">Password</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-lock input-icon"></i>
                                            <asp:TextBox ID="c_password" ClientIDMode="Static" runat="server" TextMode="Password" placeholder="Create a password"></asp:TextBox>
                                            <i class="fa-regular fa-eye toggle-password" data-target="c_password"></i>
                                        </div>
                                        <span class="field-error">Password must be at least 6 characters.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="c_confirm">Confirm Password</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-lock input-icon"></i>
                                            <asp:TextBox ID="c_confirm" ClientIDMode="Static" runat="server" TextMode="Password" placeholder="Confirm your password"></asp:TextBox>
                                            <i class="fa-regular fa-eye toggle-password" data-target="c_confirm"></i>
                                        </div>
                                        <span class="field-error">Passwords do not match.</span>
                                    </div>
                                </div>

                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="c_website">Company Website</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-globe input-icon"></i>
                                            <asp:TextBox ID="c_website" ClientIDMode="Static" runat="server" placeholder="www.yourcompany.com"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your company website.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="c_industry">Industry Type</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-industry input-icon"></i>
                                            <asp:DropDownList ID="c_industry" ClientIDMode="Static" runat="server">
                                                <asp:ListItem Value="">Select industry type</asp:ListItem>
                                                <asp:ListItem>IT / Software</asp:ListItem>
                                                <asp:ListItem>Finance</asp:ListItem>
                                                <asp:ListItem>Healthcare</asp:ListItem>
                                                <asp:ListItem>Education</asp:ListItem>
                                                <asp:ListItem>Manufacturing</asp:ListItem>
                                                <asp:ListItem>Retail</asp:ListItem>
                                                <asp:ListItem>E-commerce</asp:ListItem>
                                                <asp:ListItem>Other</asp:ListItem>
                                            </asp:DropDownList>
                                            <i class="fa-solid fa-chevron-down select-caret"></i>
                                        </div>
                                        <span class="field-error">Please select an industry type.</span>
                                    </div>
                                </div>

                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="c_size">Company Size</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-users input-icon"></i>
                                            <asp:DropDownList ID="c_size" ClientIDMode="Static" runat="server">
                                                <asp:ListItem Value="">Select company size</asp:ListItem>
                                                <asp:ListItem>1 - 10 Employees</asp:ListItem>
                                                <asp:ListItem>11 - 50 Employees</asp:ListItem>
                                                <asp:ListItem>51 - 200 Employees</asp:ListItem>
                                                <asp:ListItem>201 - 500 Employees</asp:ListItem>
                                                <asp:ListItem>500+ Employees</asp:ListItem>
                                            </asp:DropDownList>
                                            <i class="fa-solid fa-chevron-down select-caret"></i>
                                        </div>
                                        <span class="field-error">Please select your company size.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="c_location">Location</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-location-dot input-icon"></i>
                                            <asp:TextBox ID="c_location" ClientIDMode="Static" runat="server" placeholder="Enter your city"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your city.</span>
                                    </div>
                                </div>
                            </div>

                            <div class="terms-row" style="margin-top: 15px;">
                                <asp:CheckBox ID="agreeTerms" ClientIDMode="Static" runat="server" Checked="true" />
                                <label for="agreeTerms">I agree to the <a href="#">Terms &amp; Conditions</a> and <a href="#">Privacy Policy</a></label>
                            </div>

                            <div style="margin-top: 15px; margin-bottom: 20px;">
                                <%--            <asp:Button ID="btnRegister" ClientIDMode="Static" runat="server" Text="Register Now" CssClass="btn btn-primary btn-login" OnClick="btnRegister_Click" />--%>
                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/register.png" Width="650px" OnClick="ImageButton2_Click" />
                                <asp:Label ID="Label1" runat="server" Style="display: block; margin-top: 10px; font-weight: 600;"></asp:Label>
                            </div>
                        </div>

                        

                            <div class="login-divider">or</div>

                            <div class="social-row">
                                <asp:LinkButton ID="googleBtn" ClientIDMode="Static" runat="server" CssClass="btn-social" OnClientClick="return false;"><i class="fa-brands fa-google google"></i> Continue with Google</asp:LinkButton>
                                <asp:LinkButton ID="linkedinBtn" ClientIDMode="Static" runat="server" CssClass="btn-social" OnClientClick="return false;"><i class="fa-brands fa-linkedin linkedin"></i> Continue with LinkedIn</asp:LinkButton>
                            </div>

                            <p class="login-register-text">
                                Already have an account? <a href="login.aspx">Login Now</a>
                            </p>

                        </div>
                    </div>

                </div>
                                <!-- ================= GRIDVIEWS FOR DATABASE DATA ================= -->
        <div>

            <!-- Student Database Grid -->
            <div>
                <h3>Student GridView</h3>
                <div>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand">
                        <HeaderStyle BackColor="#2563eb" ForeColor="White" Font-Bold="True" HorizontalAlign="Left" Height="36px" />
                        <RowStyle BackColor="#f8fafc" ForeColor="#334155" Height="32px" />

                        <Columns>
                            <asp:TemplateField HeaderText="Id">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Full Name">
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("s_fullname") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date Of Birth">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("s_dob") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email">
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("s_email") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Contact No">
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("s_mobile") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Enrollment No">
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("s_enrollment") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Password">
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Eval("s_password") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Confirm Password">
                                <ItemTemplate>
                                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("s_confirm") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Collage">
                                <ItemTemplate>
                                    <asp:Label ID="Label10" runat="server" Text='<%# Eval("s_college") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Course">
                                <ItemTemplate>
                                    <asp:Label ID="Label11" runat="server" Text='<%# Eval("s_course") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Grade Year">
                                <ItemTemplate>
                                    <asp:Label ID="Label12" runat="server" Text='<%# Eval("s_gradeyear") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Location">
                                <ItemTemplate>
                                    <asp:Label ID="Label13" runat="server" Text='<%# Eval("s_location") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <%-- <asp:LinkButton ID="LinkButton3" runat="server" CommandName="cmd_edt_s"  CommandArgument='<%# Eval("Id") %>'>Edit</asp:LinkButton>--%>
                                    <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/edit.png" Width="100px" Height="45px" CommandName="cmd_edt_s" CommandArgument='<%# Eval("Id") %>' ToolTip="Edit" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <%-- <asp:LinkButton ID="LinkButton4" runat="server" CommandName="cmd_del_s" CommandArgument='<%# Eval("Id") %>' OnClientClick="return confirm('Are you sure you want to delete this student?');"> Delete</asp:LinkButton>--%>
                                    <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/delete.png" Width="100px" Height="42px" CommandName="cmd_del_s" CommandArgument='<%# Eval("Id") %>' ToolTip="Delete" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <br />
            <br />
            <!-- Company Database Grid -->
            <div>
                <h3>Company GridView</h3>
                <%--   <div style="overflow-x: auto; max-height: 300px; border: 1px solid #cbd5e1; border-radius: 8px;">--%>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" OnRowCommand="GridView2_RowCommand">
                   <HeaderStyle BackColor="#059669" ForeColor="White" Font-Bold="True" HorizontalAlign="Left" Height="36px" />
<RowStyle BackColor="#f8fafc" ForeColor="#334155" Height="32px" />

                    <Columns>
                        <asp:TemplateField HeaderText="Id">
                            <ItemTemplate>
                                <asp:Label ID="Label14" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Company">
                            <ItemTemplate>
                                <asp:Label ID="Label15" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Contact">
                            <ItemTemplate>
                                <asp:Label ID="Label16" runat="server" Text='<%# Eval("c_contact") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate>
                                <asp:Label ID="Label17" runat="server" Text='<%# Eval("c_email") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mobile">
                            <ItemTemplate>
                                <asp:Label ID="Label18" runat="server" Text='<%# Eval("c_mobile") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Password">
                            <ItemTemplate>
                                <asp:Label ID="Label23" runat="server" Text='<%# Eval("c_password") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Confirm Password">
                            <ItemTemplate>
                                <asp:Label ID="Label24" runat="server" Text='<%# Eval("c_confirm") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Website">
                            <ItemTemplate>
                                <asp:Label ID="Label19" runat="server" Text='<%# Eval("c_website") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Industry">
                            <ItemTemplate>
                                <asp:Label ID="Label20" runat="server" Text='<%# Eval("c_industry") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Size">
                            <ItemTemplate>
                                <asp:Label ID="Label21" runat="server" Text='<%# Eval("c_size") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Location">
                            <ItemTemplate>
                                <asp:Label ID="Label22" runat="server" Text='<%# Eval("c_location") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <%--  <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("id") %>' CommandName="cmd_edt_c">Edit</asp:LinkButton>--%>
                                <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/edit.png" Width="100px" Height="45px" CommandName="cmd_edt_c" CommandArgument='<%# Eval("Id") %>' ToolTip="Edit" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <%--    <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("id") %>' CommandName="cmd_dlt_c">Delete</asp:LinkButton>--%>
                                <asp:ImageButton ID="ImageButton6" runat="server" ImageUrl="~/delete.png" Width="100px" Height="42px" CommandName="cmd_dlt_c" CommandArgument='<%# Eval("Id") %>' ToolTip="Delete"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

                <div id="public-footer-root"></div>

            </div>

            <!-- Toast notification -->
            <div class="login-toast" id="loginToast">
                <i class="fa-solid fa-circle-check"></i>
                <span id="loginToastMsg">Registration successful!</span>
            </div>

            <script src="js/global-store.js"></script>
            <script src="js/public-layout.js"></script>
            <script src="js/script.js"></script>
            <script src="js/register.js"></script>
    </body>
    </html>

    </div>

</asp:Content>
<asp:Content ID="Content6" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <!-- ============ HEADER ============ -->
    <header class="site-header">

        <!-- Top bar -->
        <div class="topbar">
            <div class="container topbar-inner">
                <p class="topbar-tagline">
                    <i class="fa-solid fa-graduation-cap"></i>Empowering Students. Connecting Companies. Building Careers.
                </p>
                <div class="topbar-right">
                    <a href="tel:+918849900762" class="topbar-link"><i class="fa-solid fa-phone"></i>88499 00762 </a><a href="mailto:support@sims.com" class="topbar-link"><i class="fa-solid fa-envelope"></i>support@sims.com </a>
                    <div class="topbar-socials">
                        <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a><a href="#" aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a><a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a><a href="#" aria-label="YouTube"><i class="fa-brands fa-youtube"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main nav -->
        <div class="navbar">
            <div class="container navbar-inner">
                <a href="index.aspx" class="brand"><span class="brand-icon"><i class="fa-solid fa-graduation-cap"></i></span><span class="brand-text"><span class="brand-name">SIMS</span> <span class="brand-sub">Smart Student Internship Management System</span> </span></a>
                <nav class="main-nav" id="mainNav">
                    <ul>
                        <li><a href="index.aspx" data-nav-page="index.aspx">Home</a></li>
                        <li><a href="internships.aspx" data-nav-page="internships.aspx">Internships</a></li>
                        <li><a href="companies.aspx" data-nav-page="companies.aspx">Companies</a></li>
                        <li><a href="stories.aspx" data-nav-page="stories.aspx">Success Stories</a></li>
                        <li><a href="about.aspx" data-nav-page="about.aspx">About Us</a></li>
                        <li><a href="contact.aspx" data-nav-page="contact.aspx">Contact Us</a></li>
                        <li><a href="faq.aspx" data-nav-page="faq.aspx">FAQ</a></li>
                    </ul>
                </nav>
                <div class="navbar-actions">
                    <button class="icon-btn" id="searchBtn" type="button" aria-label="Search">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                    <button class="icon-btn" id="notifBtn" type="button" aria-label="Notifications">
                        <i class="fa-regular fa-bell"></i><span class="badge">1</span>
                    </button>
                    <%--                                <a href="login.aspx" class="btn btn-primary">Login / Register</a>--%>
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/login register.png" PostBackUrl="~/login.aspx" Width="150px" />
                    <button class="hamburger" id="hamburgerBtn" type="button" aria-label="Menu">
                        <i class="fa-solid fa-bars"></i>
                    </button>
                </div>
            </div>

            <!-- Expandable search bar -->
            <div class="search-panel" id="searchPanel">
                <div class="container search-panel-inner">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <asp:TextBox ID="searchInput" ClientIDMode="Static" runat="server" placeholder="Search internships, companies, students..."></asp:TextBox>
                    <button class="search-close" id="searchClose" type="button" aria-label="Close search">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
            </div>

            <!-- Notification dropdown -->
            <div class="notif-panel" id="notifPanel">
                <div class="notif-header">
                    <h4>Notifications</h4>
                    <span class="notif-count">1 New</span>
                </div>
                <ul class="notif-list">
                    <li class="notif-item unread"><span class="notif-icon"><i class="fa-solid fa-briefcase"></i></span>
                        <div>
                            <p>
                                Your internship application at <strong>TechNova Pvt Ltd</strong> was shortlisted.
                            </p>
                            <span class="notif-time">2 hours ago</span>
                        </div>
                    </li>
                    <li class="notif-item"><span class="notif-icon"><i class="fa-solid fa-certificate"></i></span>
                        <div>
                            <p>
                                Your completion certificate is ready to download.
                            </p>
                            <span class="notif-time">Yesterday</span>
                        </div>
                    </li>
                    <li class="notif-item"><span class="notif-icon"><i class="fa-solid fa-building"></i></span>
                        <div>
                            <p>
                                New internship posted by <strong>Bright Solutions</strong>.
                            </p>
                            <span class="notif-time">2 days ago</span>
                        </div>
                    </li>
                </ul>
                <a href="#" class="notif-viewall">View All Notifications</a>
            </div>
        </div>
    </header>
</asp:Content>

