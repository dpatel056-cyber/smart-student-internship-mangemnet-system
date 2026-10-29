-- Migration: Alter CompanyCertificates Table for Verification, Revocation and Soft Delete
-- Safe to re-run multiple times

IF COL_LENGTH('CompanyCertificates', 'CertificateNo') IS NULL
BEGIN
    ALTER TABLE CompanyCertificates ADD CertificateNo NVARCHAR(30) NULL;
END

IF COL_LENGTH('CompanyCertificates', 'VerificationCode') IS NULL
BEGIN
    ALTER TABLE CompanyCertificates ADD VerificationCode NVARCHAR(20) NULL;
END

IF COL_LENGTH('CompanyCertificates', 'RevokeReason') IS NULL
BEGIN
    ALTER TABLE CompanyCertificates ADD RevokeReason NVARCHAR(500) NULL;
END

IF COL_LENGTH('CompanyCertificates', 'RevokedBy') IS NULL
BEGIN
    ALTER TABLE CompanyCertificates ADD RevokedBy NVARCHAR(150) NULL;
END

IF COL_LENGTH('CompanyCertificates', 'RevokedDate') IS NULL
BEGIN
    ALTER TABLE CompanyCertificates ADD RevokedDate DATETIME NULL;
END

IF COL_LENGTH('CompanyCertificates', 'IsDeleted') IS NULL
BEGIN
    ALTER TABLE CompanyCertificates ADD IsDeleted BIT NULL;
END

-- Backfill existing certificates with CertificateNo and VerificationCode if NULL
UPDATE CompanyCertificates
SET
    CertificateNo = 'CERT-' + CAST(YEAR(ISNULL(CreatedDate, GETDATE())) AS VARCHAR(4)) + '-' + RIGHT('0000' + CAST(CertificateId AS VARCHAR(10)), 4)
WHERE CertificateNo IS NULL OR CertificateNo = '';

UPDATE CompanyCertificates
SET
    VerificationCode = UPPER(SUBSTRING(REPLACE(CAST(NEWID() AS VARCHAR(36)), '-', ''), 1, 8))
WHERE VerificationCode IS NULL OR VerificationCode = '';

UPDATE CompanyCertificates
SET
    Status = 'Issued'
WHERE Status IS NULL OR Status = '';
