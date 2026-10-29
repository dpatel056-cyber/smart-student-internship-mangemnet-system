-- Add IsBlocked and Status columns to Students table if they don't exist
IF COL_LENGTH('Students', 'IsBlocked') IS NULL
BEGIN
    ALTER TABLE Students ADD IsBlocked BIT NULL;
END
GO

IF COL_LENGTH('Students', 'Status') IS NULL
BEGIN
    ALTER TABLE Students ADD Status NVARCHAR(50) NULL;
END
GO

-- Update existing students
UPDATE Students SET IsBlocked = 0 WHERE IsBlocked IS NULL;
UPDATE Students SET Status = 'Active' WHERE Status IS NULL OR Status = '';
GO

-- Add IsBlocked and Status columns to c_registration table if they don't exist
IF COL_LENGTH('c_registration', 'IsBlocked') IS NULL
BEGIN
    ALTER TABLE c_registration ADD IsBlocked BIT NULL;
END
GO

IF COL_LENGTH('c_registration', 'Status') IS NULL
BEGIN
    ALTER TABLE c_registration ADD Status NVARCHAR(50) NULL;
END
GO

-- Update existing companies
UPDATE c_registration SET IsBlocked = 0 WHERE IsBlocked IS NULL;
UPDATE c_registration SET Status = 'Active' WHERE Status IS NULL OR Status = '';
GO
