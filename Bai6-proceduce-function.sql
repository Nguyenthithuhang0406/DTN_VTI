use testingsystem;

-- store procedure

DELIMITER $$
CREATE PROCEDURE procedure_not_param()
	BEGIN
		SELECT * from Account;
	END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procedure_not_param2()
	BEGIN
		SELECT * from Account;
        select * from answer;
	END $$
DELIMITER ;

CALL procedure_not_param2(); # Sử dụng hàm vừa tạo

DELIMITER $$
CREATE PROCEDURE procedure_param_input(IN account_id int)
BEGIN
   SELECT * from Account
   WHERE AccountID = account_id;
END $$
DELIMITER ;

CALL procedure_param_input(1);

DELIMITER $$
CREATE PROCEDURE procedure_param_output(OUT count_account int)
BEGIN
   SELECT COUNT(*) INTO count_account from Account;
END $$
DELIMITER ;

# tao 1 bien
set @count_account_var = 0;
# goi cau lenh store
call procedure_param_output(@count_account_var);
# kiem tra lai gia tri cua bien
select @count_account_var;

# cau lenh 1: sd va thay doi bien @x

# cau lenh 2: su dung va thay doi bien @x

-- function
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$
CREATE FUNCTION calculateTotalPrice(quantity INT, unitPrice DECIMAL(10,2))
   RETURNS DECIMAL(10,2)
BEGIN
   DECLARE totalPrice DECIMAL(10,2); # Tạo 1 biến để trả về
   SET totalPrice = quantity * unitPrice; # Câu lệnh SQL để gán giá trị cho biến vừa tạo
   RETURN totalPrice;
END $$
DELIMITER ;


# Gọi hàm
SELECT calculateTotalPrice(2, 2.2);

-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
-- account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS question1;

DELIMITER $$
CREATE PROCEDURE question1(in department_name varchar(50))
BEGIN
	select * 
    from department
    where DepartmentName = department_name;
END $$
DELIMITER ;

call question1('Sale');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DELIMITER $$
CREATE PROCEDURE question2()
BEGIN
   select a.*, count(b.AccountID) as sl_account
   from `group` a
   inner join groupaccount b
   on a.GroupID = b.GroupID
   group by a.GroupID;
END $$
DELIMITER ;

call question2();

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại
DELIMITER $$
CREATE PROCEDURE question3()
BEGIN
   select a.*, count(QuestionID) as sl_question
   from typequestion a
   left join question b
   on a.TypeID = b.TypeID
   where month(b.CreateDate) = MONTH(CURRENT_DATE()) and year(b.CreateDate) = year(CURRENT_DATE())
   group by a.TypeID;
END $$
DELIMITER ;

call question3();

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS question4;

DELIMITER $$
CREATE PROCEDURE question4(out typeId_var int)
BEGIN
   DECLARE max_count INT;  -- Biến lưu số lượng câu hỏi lớn nhất

    -- Lấy giá trị MAX(COUNT(QuestionID))
    SELECT MAX(question_count) 
    INTO max_count
    FROM (
        SELECT COUNT(QuestionID) AS question_count
        FROM question
        GROUP BY TypeID
    ) AS subquery;

    -- Lấy TypeID có số câu hỏi nhiều nhất
    SELECT TypeID 
    INTO typeId_var
    FROM question
    GROUP BY TypeID
    HAVING COUNT(QuestionID) = max_count;
END $$
DELIMITER ;


-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
set @typeId_var = 0;
call question4(@typeId_var);

DROP PROCEDURE IF EXISTS question5;

DELIMITER $$
CREATE PROCEDURE question5()
BEGIN
   select TypeName
   from typequestion
   where TypeID = @typeId_var;
END $$
DELIMITER ;

call question5();

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào
DELIMITER $$
CREATE PROCEDURE question6(in name varchar(50))
BEGIN
   select * 
   from `group`
   where GroupName like '%name%';
   
   select * 
   from account
   where UserName like '%name%';
END $$
DELIMITER ;

call question6('Ha');

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
-- trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
DELIMITER $$
CREATE PROCEDURE question7(in fullName_var varchar(100), email_var varchar(100))
BEGIN
	declare username_var varchar(100);
    declare positionID_var int;
    declare departmentID_var int;
    
    set username_var = substring_index(email_var, '@', 1);
    
    select PositionID into positionID_var
    from position
    where PositionName = 'Developer';
    
    select DepartmentID into departmentID_var
    from department
    where DepartmentName = N'Phòng chờ';
    
    insert into account(Email, Username, FullName, DepartmentID, PositionID)
    value (email_var, username_var, fullName_var, departmentID_var, positionID_var);
    
    select 'Tạo thành công!' as message;
END $$
DELIMITER ;

call question7('Nguyen thi thu hang', 'hangnguyenthithu32@gmail.com');

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DELIMITER $$
CREATE PROCEDURE question8(in type varchar(50))
BEGIN
   select a.*
   from question a
   inner join typequestion b
   on a.TypeID = b.TypeID
   where b.TypeName = type and char_length(a.Content) = (select max(char_length(a.Content))
																from question a
                                                                inner join typequestion b
																on a.TypeID = b.TypeID
                                                                where b.TypeName = type);
END $$
DELIMITER ;

call question8('essay');

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DELIMITER $$
CREATE PROCEDURE question9(in examID_var int)
BEGIN
	delete from exam where ExamID = examID_var;
    select 'Xoa thanh cong' as message;
END $$
DELIMITER ;

call question9(1);

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
-- dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi
-- removing
DELIMITER $$
CREATE PROCEDURE question10()
BEGIN
	declare done int default false;
    declare exam_id int;
    declare count int default 0;
    
	declare exams cursor for
	select ExamID
    from exam
    where CreateDate <= curdate() - interval 3 year;
    
    declare continue handler for not found set done = true;
    
    open exams;
    
    read_loop: LOOP
		fetch exams into exam_id;
		if done then leave read_loop;
		end if;
        
        call question9(exam_id);
        set count = count +1;
	end loop;
	
    close exams;
END $$
DELIMITER ;

call question10();

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc
DELIMITER $$
CREATE PROCEDURE question9(in departmentName_var varchar(100))
BEGIN
	declare departmentID_var int;
    declare done int default false;
    declare phongChoID_var int;
	declare AccountID_var int;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    declare accounts cursor for
    select AccountID
    from account
    where DepartmentID = departmentID_var;
    
    select DepartmentID into departmentID_var
    from department
    where DepartmentName = departmentName_var;
    
    select DepartmentID into phongChoID_var
    from department
    where DepartmentName = N'Phòng chờ';
        
    open accounts;
    read_loop: LOOP
        fetch accounts into AccountID_var;
        
        if done then leave read_loop;
        end if;
        
        update account
        set DepartmentID = phongChoID_var
        where AccountID = AccountID_var;
	end loop;
    close accounts;
    
    delete from department
    where DepartmentName =  departmentName_var;
    
    select 'Cap nhat thanh cong' as message;
        
END $$
DELIMITER ;

call question11('Sale');

-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm
-- nay
DROP PROCEDURE IF EXISTS question12;

DELIMITER $$
CREATE PROCEDURE question12()
BEGIN
	select month(CreateDate) as month, count(QuestionID) as count_question
    from question
    where year(CreateDate) = year(curdate())
    group by month(CreateDate);
END $$
DELIMITER ;

call question12();
-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6
-- tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong
-- tháng")
DROP PROCEDURE IF EXISTS question13;
DELIMITER $$
CREATE PROCEDURE question13()
BEGIN
	declare month_num int default 0;
    declare count_question int default 0;
    
    drop table if exists result_table;
    CREATE TABLE result_table (
		month INT,
		message VARCHAR(255)
	);
    while month_num < 6 do
		select count(QuestionID) into count_question
		from question
		where CreateDate >= curdate() - interval (month_num+1) month and CreateDate < curdate() - interval month_num  month;
        
        if count_question = 0 then 
			insert into result_table(month, message)
            values (month(curdate() - interval (month_num + 1) month), 'Khong co cau hoi nao trong thang');
        else 
			insert into result_table(month, message)
            values (month(curdate() - interval (month_num + 1) month) , count_question);
        end if;
        
        set month_num = month_num + 1;
	end while;
    
    select * from result_table;
    drop table if exists result_table;
END $$
DELIMITER ;

call question13();


