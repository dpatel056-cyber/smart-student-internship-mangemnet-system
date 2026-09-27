/* Add CGPA to existing student registrations. */
IF COL_LENGTH(N'dbo.s_registration', N's_cgpa') IS NULL
BEGIN
    ALTER TABLE dbo.s_registration
    ADD s_cgpa NVARCHAR(30) NULL;
END;
GO
