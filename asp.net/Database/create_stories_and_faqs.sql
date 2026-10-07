IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Stories')
BEGIN
    CREATE TABLE Stories (
        StoryId INT IDENTITY(1,1) PRIMARY KEY,
        StudentName NVARCHAR(150) NOT NULL,
        StudentRole NVARCHAR(150) NOT NULL,
        StudentAvatar NVARCHAR(500) NULL,
        Quote NVARCHAR(MAX) NOT NULL,
        PlacedAt NVARCHAR(150) NULL,
        CompanyLogo NVARCHAR(500) NULL,
        Category NVARCHAR(200) NOT NULL,
        BadgeType NVARCHAR(100) NULL,
        BadgeClass NVARCHAR(50) NULL,
        IsActive BIT NOT NULL,
        SortOrder INT NOT NULL,
        CreatedDate DATETIME NOT NULL
    );

    -- Seed initial 8 stories
    INSERT INTO Stories (StudentName, StudentRole, StudentAvatar, Quote, PlacedAt, CompanyLogo, Category, BadgeType, BadgeClass, SortOrder, IsActive, CreatedDate)
    VALUES
    ('Riya Patel', 'Web Development Intern', 'https://randomuser.me/api/portraits/women/68.jpg', 'SIMS helped me find the perfect internship where I learned so much and grew my skills. The platform made the whole process so easy!', 'TCS', '~/assets/logo-tcs.svg', 'students experiences', 'Full-time Offer', 'badge-fulltime', 1, 1, GETDATE()),
    ('Devansh Shah', 'Data Analyst Intern', 'https://randomuser.me/api/portraits/men/32.jpg', 'Thanks to SIMS, I got an opportunity to work with amazing team and real-time projects. It was a turning point in my career.', 'Deloitte', '~/assets/logo-deloitte.svg', 'students growth', 'Pre-Placement Offer', 'badge-ppo', 2, 1, GETDATE()),
    ('Neha Singh', 'UI/UX Design Intern', 'https://randomuser.me/api/portraits/women/65.jpg', 'The internship I found on SIMS helped me build my portfolio and confidence. I am now working as a designer at a great company!', 'Google', '~/assets/logo-google.png', 'students experiences', 'Full-time Offer', 'badge-fulltime', 3, 1, GETDATE()),
    ('Aman Verma', 'Marketing Intern', 'https://randomuser.me/api/portraits/men/45.jpg', 'The SIMS platform is user-friendly and has many opportunities. I found the right internship that matched my skills and goals.', 'Amazon', '~/assets/logo-amazon.png', 'students growth', 'Full-time Offer', 'badge-fulltime', 4, 1, GETDATE()),
    ('Priya Mehta', 'Software Engineer Intern', 'https://randomuser.me/api/portraits/women/50.jpg', 'SIMS made it simple to apply and track my applications. Within weeks I had an offer from a company I truly wanted to work at.', 'Infosys', '~/assets/logo-infosys.png', 'students companies', 'Full-time Offer', 'badge-fulltime', 5, 1, GETDATE()),
    ('Karan Joshi', 'Business Analyst Intern', 'https://randomuser.me/api/portraits/men/76.jpg', 'The mentorship and real project exposure I got through my SIMS internship gave my career the head start I was looking for.', 'Wipro', '~/assets/logo-wipro.svg', 'companies growth', 'Pre-Placement Offer', 'badge-ppo', 6, 1, GETDATE()),
    ('Sanya Kapoor', 'Content Writer Intern', 'https://randomuser.me/api/portraits/women/33.jpg', 'My SIMS internship experience taught me discipline and creativity. It shaped the way I approach every project even today.', 'Flipkart', '~/assets/logo-flipkart.svg', 'experiences growth', 'Full-time Offer', 'badge-fulltime', 7, 1, GETDATE()),
    ('Rohan Iyer', 'Backend Developer Intern', 'https://randomuser.me/api/portraits/men/86.jpg', 'I applied through SIMS on a whim and it changed everything. The internship turned into a full-time offer within three months.', 'Microsoft', '~/assets/logo-microsoft.png', 'students experiences', 'Full-time Offer', 'badge-fulltime', 8, 1, GETDATE());
END
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Faqs')
BEGIN
    CREATE TABLE Faqs (
        FaqId INT IDENTITY(1,1) PRIMARY KEY,
        Category NVARCHAR(50) NOT NULL,
        CategoryName NVARCHAR(100) NOT NULL,
        CategoryIcon NVARCHAR(50) NOT NULL,
        CategoryColor NVARCHAR(50) NOT NULL,
        Question NVARCHAR(500) NOT NULL,
        Answer NVARCHAR(MAX) NOT NULL,
        SortOrder INT NOT NULL,
        IsActive BIT NOT NULL,
        CreatedDate DATETIME NOT NULL
    );

    -- Seed initial FAQs
    INSERT INTO Faqs (Category, CategoryName, CategoryIcon, CategoryColor, Question, Answer, SortOrder, IsActive)
    VALUES
    -- General
    ('general', 'General', 'fa-comments', 'cat-blue', 'What is SIMS?', 'SIMS (Smart Student Internship Management System) is a platform that connects students with verified companies offering internship opportunities. It helps students discover, apply, and manage internships while enabling companies to find and hire talented students.', 1, 1),
    ('general', 'General', 'fa-comments', 'cat-blue', 'How can I register on SIMS?', 'Click the "Register" button in the top-right corner, choose whether you are a student or a company, fill in your basic details, verify your email address, and your account will be ready to use.', 2, 1),
    ('general', 'General', 'fa-comments', 'cat-blue', 'Is SIMS free to use?', 'Yes, SIMS is completely free for students. Companies can post a limited number of internships for free, with optional premium plans for advanced hiring features.', 3, 1),
    ('general', 'General', 'fa-comments', 'cat-blue', 'How can I search for internships?', 'Use the "Browse Internships" page and filter by category, location, duration, or stipend to find internships that match your interests and skills.', 4, 1),
    ('general', 'General', 'fa-comments', 'cat-blue', 'Can I apply for multiple internships?', 'Yes, you can apply to as many internships as you like. Your applications are tracked in one place under "My Applications" so you can monitor their status.', 5, 1),
    ('general', 'General', 'fa-comments', 'cat-blue', 'How will I know if my application is shortlisted?', 'You will receive an in-app notification and an email as soon as a company updates your application status to shortlisted, rejected, or selected.', 6, 1),

    -- For Students
    ('students', 'For Students', 'fa-user-graduate', 'cat-green', 'Do I need to pay to create a student account?', 'No, creating and using a student account on SIMS is completely free, including applying to internships and downloading certificates.', 1, 1),
    ('students', 'For Students', 'fa-user-graduate', 'cat-green', 'How do I upload or update my resume?', 'Go to your Student Dashboard, open "Upload Resume", and either upload a new PDF or edit your existing one. Companies will always see your latest version.', 2, 1),
    ('students', 'For Students', 'fa-user-graduate', 'cat-green', 'Can I edit my profile after registration?', 'Yes, you can update your skills, education, portfolio links, and profile photo anytime from your Student Dashboard settings.', 3, 1),
    ('students', 'For Students', 'fa-user-graduate', 'cat-green', 'How do I know which internships match my skills?', 'SIMS highlights recommended internships on your dashboard based on the skills and interests listed in your profile.', 4, 1),
    ('students', 'For Students', 'fa-user-graduate', 'cat-green', 'What happens after I complete an internship?', 'Once a company marks your internship as completed, a verified certificate is automatically generated and added to your profile.', 5, 1),
    ('students', 'For Students', 'fa-user-graduate', 'cat-green', 'Can I withdraw an application after applying?', 'Yes, open "My Applications", select the internship, and click "Withdraw Application" before the company reviews it.', 6, 1),
    ('students', 'For Students', 'fa-user-graduate', 'cat-green', 'Will I get feedback if I am rejected?', 'Some companies share feedback directly on the application, while others may only update the status without additional comments.', 7, 1),
    ('students', 'For Students', 'fa-user-graduate', 'cat-green', 'Can I save internships to apply later?', 'Yes, click the bookmark icon on any internship listing to save it to your "Saved Internships" list for later.', 8, 1),

    -- For Companies
    ('companies', 'For Companies', 'fa-building', 'cat-purple', 'How do I post an internship?', 'Log in to your Company Dashboard, click "Post Internship", fill in the role details, required skills, duration, and stipend, then publish it live.', 1, 1),
    ('companies', 'For Companies', 'fa-building', 'cat-purple', 'Can I manage multiple internship postings at once?', 'Yes, the "Manage Internships" section lets you view, edit, pause, or close any of your active or past postings from one place.', 2, 1),
    ('companies', 'For Companies', 'fa-building', 'cat-purple', 'How do I view student applications?', 'Open "View Applications" from your dashboard to see every applicant for a specific internship, along with their resume and profile.', 3, 1),
    ('companies', 'For Companies', 'fa-building', 'cat-purple', 'Is there a limit on how many students I can hire?', 'No, there is no limit. You can shortlist and hire as many students as your internship positions require.', 4, 1),
    ('companies', 'For Companies', 'fa-building', 'cat-purple', 'How can I search for talented students directly?', 'Use the "Find Talents" tool to search the student database by skills, location, or course to proactively reach out to candidates.', 5, 1),
    ('companies', 'For Companies', 'fa-building', 'cat-purple', 'Can I see analytics on my postings?', 'Yes, the "Reports" section shows views, application counts, and conversion rates for each internship you post.', 6, 1),

    -- Internships
    ('internships', 'Internships', 'fa-briefcase', 'cat-orange', 'What types of internships are available on SIMS?', 'SIMS lists remote, hybrid, and on-site internships across technology, marketing, design, finance, and many other fields.', 1, 1),
    ('internships', 'Internships', 'fa-briefcase', 'cat-orange', 'Are internships on SIMS paid or unpaid?', 'Both paid and unpaid internships are listed. The stipend, if any, is always clearly mentioned on the internship details page.', 2, 1),
    ('internships', 'Internships', 'fa-briefcase', 'cat-orange', 'How long do internships typically last?', 'Duration varies by company, typically ranging from 4 weeks to 6 months, and is always specified in the internship listing.', 3, 1),
    ('internships', 'Internships', 'fa-briefcase', 'cat-orange', 'Can I filter internships by location?', 'Yes, you can filter by city, remote-only, or hybrid options using the filters on the "Browse Internships" page.', 4, 1),
    ('internships', 'Internships', 'fa-briefcase', 'cat-orange', 'Do internships offer a certificate on completion?', 'Most internships on SIMS provide a verified digital certificate once the company marks your internship as successfully completed.', 5, 1),
    ('internships', 'Internships', 'fa-briefcase', 'cat-orange', 'Can international students apply for internships?', 'Yes, remote internships are open to international students, though on-site roles may have location-based eligibility.', 6, 1),
    ('internships', 'Internships', 'fa-briefcase', 'cat-orange', 'What if an internship listing looks suspicious?', 'Use the "Report" button on the listing page, and our team will review and take action within 24 hours.', 7, 1),

    -- Applications
    ('applications', 'Applications', 'fa-file-lines', 'cat-pink', 'How do I apply for an internship?', 'Open the internship listing, click "Apply Now", attach your resume, add a short cover note, and submit your application.', 1, 1),
    ('applications', 'Applications', 'fa-file-lines', 'cat-pink', 'Can I track the status of my application?', 'Yes, "My Applications" shows a live status for each one — Applied, Under Review, Shortlisted, Selected, or Rejected.', 2, 1),
    ('applications', 'Applications', 'fa-file-lines', 'cat-pink', 'How long does it take to hear back?', 'Response times vary by company, but most update application status within 7 to 14 days of your submission.', 3, 1),
    ('applications', 'Applications', 'fa-file-lines', 'cat-pink', 'Can I edit my application after submitting it?', 'You can update your attached resume before the company reviews your application, but the cover note cannot be edited afterward.', 4, 1),
    ('applications', 'Applications', 'fa-file-lines', 'cat-pink', 'Will I be notified about interview calls?', 'Yes, interview schedules and messages from companies appear in your notifications and are also sent to your registered email.', 5, 1),

    -- Certificates
    ('certificates', 'Certificates', 'fa-certificate', 'cat-teal', 'How do I get my internship certificate?', 'Once a company marks your internship as completed, your certificate is generated automatically and appears under "Certificates" in your dashboard.', 1, 1),
    ('certificates', 'Certificates', 'fa-certificate', 'cat-teal', 'Can I download my certificate as a PDF?', 'Yes, every certificate can be downloaded as a high-quality PDF directly from your Student Dashboard.', 2, 1),
    ('certificates', 'Certificates', 'fa-certificate', 'cat-teal', 'Are SIMS certificates verified?', 'Yes, each certificate includes a unique verification ID that anyone can use to confirm its authenticity on our verification page.', 3, 1),
    ('certificates', 'Certificates', 'fa-certificate', 'cat-teal', 'Can I add my certificate to LinkedIn?', 'Yes, use the "Share" option on your certificate to add it directly as a LinkedIn certification with a verified link.', 4, 1),

    -- Account & Security
    ('security', 'Account & Security', 'fa-shield-halved', 'cat-skyblue', 'How do I reset my password?', 'Click "Forgot Password" on the login page, enter your registered email, and follow the reset link sent to your inbox.', 1, 1),
    ('security', 'Account & Security', 'fa-shield-halved', 'cat-skyblue', 'Is my personal data safe on SIMS?', 'Yes, SIMS uses encrypted storage and never shares your personal data with third parties without your consent.', 2, 1),
    ('security', 'Account & Security', 'fa-shield-halved', 'cat-skyblue', 'Can I delete my account permanently?', 'Yes, go to Account Settings and select "Delete Account". This action is permanent and removes all your data from SIMS.', 3, 1),
    ('security', 'Account & Security', 'fa-shield-halved', 'cat-skyblue', 'How do I enable two-factor authentication?', 'Go to Account Settings > Security, and toggle on Two-Factor Authentication to add an extra layer of protection to your login.', 4, 1),
    ('security', 'Account & Security', 'fa-shield-halved', 'cat-skyblue', 'Who can see my profile information?', 'Only verified companies you apply to, or those you make your profile visible to, can view your full profile details.', 5, 1);
END
GO
