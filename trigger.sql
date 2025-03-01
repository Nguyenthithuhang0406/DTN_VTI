use testingsystem;

-- cau 1
DROP TRIGGER IF EXISTS check_mail;
DELIMITER $$
CREATE TRIGGER check_createDate
   BEFORE INSERT ON `group`
   FOR EACH ROW
BEGIN
   IF NEW.CreateDate < curdate() - interval 1 year THEN
       SIGNAL SQLSTATE '12345'
       SET MESSAGE_TEXT = 'Khong duoc nhap vao group co ngay tao truoc 1 nam truoc';
   END IF;
END $$
DELIMITER ;

-- cau 2
DROP TRIGGER IF EXISTS check_departmentName;
DELIMITER $$
CREATE TRIGGER check_departmentName
   BEFORE INSERT ON `account`
   FOR EACH ROW
BEGIN
   IF new.DepartmentID = (select DepartmentID from department where DepartmentName = 'Sale') THEN
       SIGNAL SQLSTATE '12345'
       SET MESSAGE_TEXT = 'Department Sale cannot insert';
   END IF;
END $$
DELIMITER ;

-- cau 3: Cấu hình 1 group có nhiều nhất là 5 user => trigger danh cho insert va update (2 trigger)

DROP TRIGGER IF EXISTS check_countAccount;
DELIMITER $$
CREATE TRIGGER check_countAccount
   BEFORE INSERT ON `groupaccount`
   FOR EACH ROW
BEGIN
	declare count_user int;
    select count(AccountID) into count_user 
    from groupaccount
    where GroupID = new.GroupID;
    
   IF count_user >= 5  THEN
       SIGNAL SQLSTATE '12345'
       SET MESSAGE_TEXT = '1 group co nhieu nhat 5 user';
   END IF;
END $$
DELIMITER ;

-- cau 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question => trigger danh cho insert va update (2 trigger)

DROP TRIGGER IF EXISTS check_countQuestion;
DELIMITER $$
CREATE TRIGGER check_countQuestion
   BEFORE INSERT ON `examquestion`
   FOR EACH ROW
BEGIN
	declare count_question int;
    select count(QuestionID) into count_question 
    from examquestion
    where ExamID = new.ExamID;
    
   IF count_question >= 10  THEN
       SIGNAL SQLSTATE '12345'
       SET MESSAGE_TEXT = '1 bai thi co nhieu nhat 10 question';
   END IF;
END $$
DELIMITER ;

-- cau 5 :Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
-- tin liên quan tới user đó

DROP TRIGGER IF EXISTS check_deleteAccount;
DELIMITER $$
CREATE TRIGGER check_deleteAccount
   BEFORE DELETE ON `account`
   FOR EACH ROW
BEGIN
   IF old.Email = 'admin@gmail.com'  THEN
       SIGNAL SQLSTATE '12345'
       SET MESSAGE_TEXT = 'Day la tai khoan admin, khong cho phep xoa user';
	else
		delete from groupaccount where AccountID = old.AccountID;
        delete from question where CreatorID = old.AccountID;
        delete from exam where CreatorID = old.AccountID;
        delete from account where AccountID = old.AccountID;
   END IF;
END $$
DELIMITER ;

-- cau 6: Không sử dụng cấu hình default cho field DepartmentID của table
-- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"

DROP TRIGGER IF EXISTS check_departmentisNull;
DELIMITER $$
CREATE TRIGGER check_departmentisNull
   BEFORE INSERT ON `account`
   FOR EACH ROW
BEGIN
	declare departmentID_var int;
    declare count_waiting int;
    
    select count(DepartmentID) into count_waiting
    from department
    where DepartmentName = 'Waiting Department';
    
    if count_waiting = 0 then
		insert into department(DepartmentName)
        values ('Waiting Department');
	end if;
    
    select DepartmentID into departmentID_var
    from department
    where DepartmentName = 'Waiting Department';
    
   IF new.DepartmentID = null  THEN
       set new.DepartmentID = departmentID_var;
   END IF;
END $$
DELIMITER ;

-- cau 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.

DROP TRIGGER IF EXISTS check_countAnswer;
DELIMITER $$
CREATE TRIGGER check_countAnswer
   BEFORE INSERT ON `answer`
   FOR EACH ROW
BEGIN
	declare countAnswer int;
    declare countCorrect int;
    
    select count(AnswerID) into countAnswer
    from answer
    where QuestionID = new.QuestionID;
    
    -- nen tach ra, neu co nhieu hon 4 roi thi thong bao luon, neu khong moi dem so cau dung
    select count(AnswerID) into countCorrect
    from answer
    where QuestionID = new.QuestionID and isCorrect = true;
    
   IF countAnswer >= 4 or countCorrect >= 2  THEN
       SIGNAL SQLSTATE '12345'
       SET MESSAGE_TEXT = 'Moi cau hoi chi co toi da 4 cau tra loi, trong do co toi da 2 cau dung';
   END IF;
END $$
DELIMITER ;

-- cau 8:Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database

DROP TRIGGER IF EXISTS check_invalidGender;
DELIMITER $$
CREATE TRIGGER check_invalidGender
   BEFORE INSERT ON `account`
   FOR EACH ROW
BEGIN
   IF new.Gender = 'nam'  THEN
      set new.Gender = 'N';
   END IF;
    IF new.Gender = N'Nữ'  THEN
      set new.Gender = 'F';
   END IF;
    IF new.Gender = 'Chưa xác định'  THEN
      set new.Gender = 'U';
   END IF;
END $$
DELIMITER ;

-- cau 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS check_createDate;
DELIMITER $$
CREATE TRIGGER check_createDate
   BEFORE DELETE ON `exam`
   FOR EACH ROW
BEGIN
   if datediff(curdate() - old.CreateDate) <= 2 THEN
		SIGNAL SQLSTATE '12345'
       SET MESSAGE_TEXT = 'Khong duoc xoa bai thi moi tao duoc 2 ngay';
	end if;
END $$
DELIMITER ;

-- cau 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào
DELIMITER $$
CREATE TRIGGER check_createDate
   BEFORE UPDATE ON `question`
   FOR EACH ROW
BEGIN
   declare count_exam int;
   
   select count(*) into count_exam
   from examquestion
   where QuestionID = old.QuestionID;
   
   if count_exam > 0 then
	SIGNAL SQLSTATE '12345'
       SET MESSAGE_TEXT = 'Khong duoc xoa';
       end if;
END $$
DELIMITER ;

-- trigger delete nua

-- cau 11

-- cau 12

-- cau 13

-- cau 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    CASE 
        WHEN COUNT(a.AccountID) = 0 THEN 'Khong co User' 
        ELSE COUNT(a.AccountID) 
    END AS countUser
FROM Department d
LEFT JOIN Account a ON d.DepartmentID = a.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName;




