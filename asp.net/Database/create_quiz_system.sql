-- Create CompanyQuizzes Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CompanyQuizzes')
BEGIN
    CREATE TABLE CompanyQuizzes (
        QuizId INT IDENTITY(1,1) PRIMARY KEY,
        CompanyId INT NULL, -- NULL means Global / Standard SIMS Quiz available to all companies
        QuizTitle NVARCHAR(200) NOT NULL,
        Topic NVARCHAR(100) NOT NULL,
        DurationMinutes INT NOT NULL,
        PassingScore INT NOT NULL,
        TotalQuestions INT NOT NULL,
        TotalPoints INT NOT NULL,
        CreatedDate DATETIME,
        IsActive BIT
    );
END

-- Create QuizQuestions Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'QuizQuestions')
BEGIN
    CREATE TABLE QuizQuestions (
        QuestionId INT IDENTITY(1,1) PRIMARY KEY,
        QuizId INT NOT NULL,
        QuestionText NVARCHAR(MAX) NOT NULL,
        OptionA NVARCHAR(500) NOT NULL,
        OptionB NVARCHAR(500) NOT NULL,
        OptionC NVARCHAR(500) NOT NULL,
        OptionD NVARCHAR(500) NOT NULL,
        CorrectOption VARCHAR(5) NOT NULL, -- 'A', 'B', 'C', 'D'
        Points INT
    );
END

-- Create StudentQuizAssignments Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'StudentQuizAssignments')
BEGIN
    CREATE TABLE StudentQuizAssignments (
        AssignmentId INT IDENTITY(1,1) PRIMARY KEY,
        QuizId INT NOT NULL,
        CompanyId INT NOT NULL,
        ApplicationId INT NOT NULL,
        StudentId INT NOT NULL,
        AssignedDate DATETIME,
        Status VARCHAR(50), -- 'Assigned', 'InProgress', 'Passed', 'Failed'
        Score INT, -- Percentage Score (0 - 100)
        CorrectCount INT,
        TotalQuestions INT,
        CompletedDate DATETIME NULL,
        CertificateIssued BIT
    );
END

-- Seed Standard / Pre-loaded Engaging Quizzes if empty
IF NOT EXISTS (SELECT * FROM CompanyQuizzes WHERE CompanyId IS NULL)
BEGIN
    -- Quiz 1: Full-Stack Web Development Challenge
    INSERT INTO CompanyQuizzes (CompanyId, QuizTitle, Topic, DurationMinutes, PassingScore, TotalQuestions, TotalPoints)
    VALUES (NULL, 'Full-Stack Web Development Challenge', 'Web Development', 10, 60, 5, 100);
    DECLARE @Q1 INT = SCOPE_IDENTITY();

    INSERT INTO QuizQuestions (QuizId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption, Points) VALUES
    (@Q1, 'Which HTTP status code signifies that a resource was successfully created on the server?', '200 OK', '201 Created', '204 No Content', '301 Moved Permanently', 'B', 20),
    (@Q1, 'In modern JavaScript (ES6+), what is the primary advantage of let/const over var?', 'Faster execution time', 'Block scoping preventing accidental leaks', 'Automatic garbage collection', 'Only work inside classes', 'B', 20),
    (@Q1, 'In relational SQL databases, which statement is used to combine rows from two or more tables based on a related column?', 'MERGE', 'UNION', 'JOIN', 'GROUP BY', 'C', 20),
    (@Q1, 'What does the "A" in the ACID database transaction principles stand for?', 'Accuracy', 'Atomicity', 'Authentication', 'Availability', 'B', 20),
    (@Q1, 'Which CSS layout module is best suited for one-dimensional layouts (either row or column)?', 'CSS Grid', 'CSS Flexbox', 'Float Layout', 'Absolute Positioning', 'B', 20);

    -- Quiz 2: Python & Data Engineering Arena
    INSERT INTO CompanyQuizzes (CompanyId, QuizTitle, Topic, DurationMinutes, PassingScore, TotalQuestions, TotalPoints)
    VALUES (NULL, 'Python & Problem Solving Arena', 'Python Programming', 10, 60, 5, 100);
    DECLARE @Q2 INT = SCOPE_IDENTITY();

    INSERT INTO QuizQuestions (QuizId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption, Points) VALUES
    (@Q2, 'In Python, which built-in data type is immutable?', 'List', 'Dictionary', 'Tuple', 'Set', 'C', 20),
    (@Q2, 'What keyword is used in Python to define an anonymous/one-line function?', 'def', 'lambda', 'inline', 'func', 'B', 20),
    (@Q2, 'What is the output of print(2 ** 3) in Python?', '6', '8', '9', '5', 'B', 20),
    (@Q2, 'Which library is the industry standard in Python for data manipulation and analysis using DataFrames?', 'Flask', 'Pandas', 'Requests', 'Pygame', 'B', 20),
    (@Q2, 'How do you catch exceptions in Python?', 'try / catch', 'try / except', 'do / catch', 'begin / rescue', 'B', 20);

    -- Quiz 3: React & Modern Frontend Quest
    INSERT INTO CompanyQuizzes (CompanyId, QuizTitle, Topic, DurationMinutes, PassingScore, TotalQuestions, TotalPoints)
    VALUES (NULL, 'React.js & UI/UX Mastery Quest', 'Frontend & React', 10, 60, 5, 100);
    DECLARE @Q3 INT = SCOPE_IDENTITY();

    INSERT INTO QuizQuestions (QuizId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption, Points) VALUES
    (@Q3, 'Which React hook is used to perform side-effects like data fetching and subscriptions in functional components?', 'useState', 'useEffect', 'useMemo', 'useRef', 'B', 20),
    (@Q3, 'What is the Virtual DOM in React?', 'A direct copy of the browser HTML document', 'A lightweight in-memory representation of real DOM', 'A special browser plugin', 'A database caching mechanism', 'B', 20),
    (@Q3, 'How are data and attributes passed downwards from parent to child components in React?', 'Via State', 'Via Props', 'Via Redux only', 'Via LocalStorage', 'B', 20),
    (@Q3, 'What is the purpose of the key prop when rendering lists of elements in React?', 'To style individual list items', 'To help React identify which items have changed, added, or removed', 'To bind click events', 'To make items sortable', 'B', 20),
    (@Q3, 'What tool is commonly used with modern React for bundling and lightning-fast local development?', 'Vite / Webpack', 'Apache', 'Docker', 'SQLite', 'A', 20);

    -- Quiz 4: Business Aptitude & Professional Ethics
    INSERT INTO CompanyQuizzes (CompanyId, QuizTitle, Topic, DurationMinutes, PassingScore, TotalQuestions, TotalPoints)
    VALUES (NULL, 'Professional Workplace Ethics & Agile Basics', 'Agile & Workplace', 10, 60, 5, 100);
    DECLARE @Q4 INT = SCOPE_IDENTITY();

    INSERT INTO QuizQuestions (QuizId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption, Points) VALUES
    (@Q4, 'In Agile / Scrum methodology, what is the short daily sync meeting called?', 'Sprint Retrospective', 'Daily Standup / Scrum', 'Sprint Planning', 'Demo Review', 'B', 20),
    (@Q4, 'What version control command is used to record staged changes to the repository with a descriptive message?', 'git add', 'git commit -m', 'git push', 'git branch', 'B', 20),
    (@Q4, 'When collaborating on Git, what is the best practice before merging new feature code into main?', 'Delete the branch', 'Create a Pull Request (PR) for code review', 'Directly force-push to main', 'Email code files to team', 'B', 20),
    (@Q4, 'Which metric evaluates the time between code deployment and customer issue resolution?', 'MTTR (Mean Time to Resolution)', 'KPI', 'ROI', 'CTR', 'A', 20),
    (@Q4, 'What is the most effective approach when facing an unexpected blocker during an internship project?', 'Wait silently until the deadline', 'Proactively communicate with your mentor/team with details of what was tried', 'Abandon the feature completely', 'Blame external tools', 'B', 20);
END
