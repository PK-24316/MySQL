-- 1. Create Database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- 2. Create Books Table
CREATE TABLE Books
(
	BookID INT PRIMARY KEY auto_increment,
    Title VARCHAR(225) NOT NULL,
    Author VARCHAR(225) NOT NULL,
    Genre VARCHAR(50),
    PublishedYear INT,
    Available BOOLEAN DEFAULT TRUE
);

-- 3. Create Members Table
CREATE TABLE Members
(
	MemberID INT PRIMARY KEY auto_increment,
    Name VARCHAR(225) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    JoinDate DATE 
);

-- 4. Create Borrowed Books table
CREATE TABLE BorrowedBooks
(
	BorrowID INT PRIMARY KEY auto_increment,
    MemberID INT,
    BookID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- 5. Insert Sample Data into books table
INSERT INTO Books(Title, Author, Genre, PublishedYear, Available)
VALUES
('Flow In the Anointing', 'Dag Heward-Mills', 'Christian Literature', 2015, TRUE),
('The Sweet Influences of the Anointing', 'Dag Heward-Mills', 'Christian Literature', 2014, TRUE),
('The Anointed and His Anointing', 'Dag Heward-Mills', 'Christian Literature', 2015, TRUE),
('The Art of Hearing', 'Dag Heward-Mills', 'Christian Literature', 2008, TRUE),
('Faith Secrets', 'Dag Heward-Mills', 'Christian Literature', 2015, TRUE);

-- 6. Insert Sample Data into Members Table
INSERT INTO Members(Name, Email, Phone, JoinDate)
VALUES
('Pholosho Kwetepane', 'Pholosho.K@gmail.com', '067-938-5302', curdate());
-- ('Mpho Carlos Mofokeng', 'Mpho.CM@gmail.com', '071-598-1125', curdate()); 
-- ('Mehlo Bennet Nkolele', 'Mehlo.BN@gmail.com', '081-552-2255', curdate()),
-- ('Mvelaphanda Given Muruba', 'Mvelaphanda.GM@gmail.com', '082-115-6655', curdate()),
-- ('Xitsundzuxo Remember Madzhasi' 'Xitsundzuxo.RM@gmail.com', '064-339-4519', curdate());

-- Borrow a Book (Member 1 borrows Book 2)
INSERT INTO BorrowedBooks (MemberID, BookID, BorrowDate)
VALUES (1, 2, CURDATE());

UPDATE Books 
SET Available = FALSE 
WHERE BookID = 2;

-- Return a Book (Member 1 returns Book 2)
UPDATE BorrowedBooks 
SET ReturnDate = CURDATE() 
WHERE BorrowID = 1;

UPDATE Books 
SET Available = TRUE 
WHERE BookID = 2;

-- Retrieve Available Books
SELECT * FROM Books WHERE Available = TRUE;

-- View Members Who Borrowed Books
SELECT Members.Name, Books.Title, BorrowedBooks.BorrowDate 
FROM BorrowedBooks
JOIN Members ON BorrowedBooks.MemberID = Members.MemberID
JOIN Books ON BorrowedBooks.BookID = Books.BookID
WHERE BorrowedBooks.ReturnDate IS NULL;

-- Delete a Member
DELETE FROM Members WHERE MemberID = 2;