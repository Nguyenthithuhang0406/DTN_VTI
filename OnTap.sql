-- 1. Lấy ra thông tin của các khách hàng sống tại các thành phố Nantes và Lyon.
select * 
from customers
where city = 'Nantes' or city = 'Lyon';

-- cach 2
select * 
from customers
where city in ('Nantes', 'Lyon');

-- 2. tìm các đơn hàng đã được chuyển trong khoảng thời gian từ ‘10/1/2003’ đến ‘10/3/2003’
select *
from orders
where shippedDate between '2003-01-10' and '2003-3-10';

-- 3. Lấy ra thông tin về các nhóm hàng hoá có chứa từ ‘CARS’.
select * 
from productlines
where productLine like '%CARS%';

-- 4. Truy vấn 10 sản phẩm có số lượng trong kho là lớn nhất.
select *
from products
order by quantityInStock desc
limit 10;

-- 5. Thống kê danh sách địa chỉ của khách hàng với định dạng: contactLastname + contactFirstname , addressLine1 + addressLine2 + country - postalCode city;
select distinct
		concat(contactLastName, ' ', contactFirstName) as customer_name,
        concat(addressLine1, ' ', addressLine2, ' ', country, '-', postalCode, ' ', city) as address
from customers;

-- 6. Lấy ra các đơn hàng đặt trong tháng 5 năm 2005
select * 
from orders
where orderDate >= '2005-05-01' and orderDate < '2005-06-01';

-- 7. Tìm 5 đơn hàng được vận chuyển sớm nhất so với ngày yêu cầu.
select *, datediff(requiredDate, shippedDate) as early_days
from orders
where shippedDate is not null
order by early_days desc
limit 5;

-- 8. Sử dụng 1 câu lệnh để thống kê số lượng đơn hàng đã vận chuyển, đã huỷ,... 
select 
		COUNT( case WHEN status = 'Shipped' THEN 1 END) AS count_shipped,
        COUNT( case WHEN status = 'Cancelled' THEN 1 END) AS count_cancelled
from orders;

-- cach 2
select status, count(*)
from orders
group by status;

-- 9. Thôgns kê tổng số tiền cho mỗi sản phẩm đã bán, số lương sp đã bán và sắp xếp theo thứ tự giảm dần
select productCode, sum(quantityOrdered) as sl, sum(priceEach * quantityOrdered) as tong_tien
from orderdetails
group by productCode
order by sum(quantityOrdered) desc;

-- 10. Đưa ra số lượng các đơn đặt hàng trong từng tháng của năm 2005
select month(orderDate) as month,
		count(orderNumber) as total_order
from orders
where year(orderDate) = 2005
group by month(orderDate);

-- 11. Thống kê các nhân viên và số lượng khách hàng đang chăm sóc, sắp xếp theo thứ tự giảm dần 
-- loi
select a.*, count(b.customerNumber) as sl
from employees a
     left join customers b
     on a.employeeNumber = b.salesRepEmployeeNumber
group by a.employeeNumber
order by count(b.customerNumber) desc;

-- cach khac
SELECT 
    a.employeeNumber,
    a.lastName,
    a.firstName,
    a.extension,
    a.email,
    a.officeCode,
    a.reportsTo,
    a.jobTitle,
    COUNT(b.customerNumber) AS sl
FROM employees a
LEFT JOIN customers b 
    ON a.employeeNumber = b.salesRepEmployeeNumber
GROUP BY 
    a.employeeNumber, 
    a.lastName, 
    a.firstName, 
    a.extension, 
    a.email, 
    a.officeCode, 
    a.reportsTo, 
    a.jobTitle
ORDER BY sl DESC;

-- 12. Đưa ra thông tin về các dòng sản phẩm và tổng số hàng có trong dòng sản phẩm đó.
select a.*, sum(quantityInStock) as tong_sl
from productlines a
    left join products b
    on a.productLine = b.productLine
group by a.productLine;

-- 13. Thống kê 10 KHách hàng đã mua hàng thành công tổng số tiền nhiều nhất
select a.*, sum(c.quantityOrdered * c.priceEach) as tong_tien
from customers a
	inner join orders b
    on a.customerNumber = b.customerNumber
    inner join orderdetails c
    on c.orderNumber = b.orderNumber
where b.status = 'Shipped'
group by a.customerNumber
order by tong_tien desc
limit 10;

-- 14. Thống kê 10 nhân viên có tổng doanh thu đơn hàng nhiều nhất
select a.*, sum(d.quantityOrdered * d.priceEach) as tong_doanh_thu
from employees a
	inner join customers b
    on a.employeeNumber = b.salesRepEmployeeNumber
    inner join orders c
    on b.customerNumber = c.customerNumber
    inner join orderdetails d
    on c.orderNumber = d.orderNumber
group by a.employeeNumber
order by tong_doanh_thu desc
limit 10;

-- 15. Đưa ra thông tin về các nhân viên và tên văn phòng nơi họ làm việc.
select *
from employees a
inner join offices b
on a.officeCode = b.officeCode;

-- 16. Đưa ra thông tin về tên khách hàng và tên các sản phẩm họ đã mua.
select distinct a.*, d.*
from customers a
	inner join orders b
    on a.customerNumber = b.customerNumber
    inner join orderdetails c
    on b.orderNumber = c.orderNumber
    inner join products d
    on c.productCode = d.productCode;

-- cah 2: nhom cac product theo ma khach hang
select distinct a.*, group_concat(d.productName SEPARATOR ', ') as sp_da_mua
from customers a
	inner join orders b
    on a.customerNumber = b.customerNumber
    inner join orderdetails c
    on b.orderNumber = c.orderNumber
    inner join products d
    on c.productCode = d.productCode
group by a.customerNumber;

-- 17. Đưa ra thông tin về các mặt hàng chưa có ai đặt mua.
select * 
from products
where productCode not in (select distinct productCode
						from orderdetails);
                        
-- 18. Đưa ra thông tin về các dòng sản phẩm và số lượng sản phẩm của dòng sản phẩm
-- đó. Sắp xếp theo thứ tự số lượng giảm dần.
select a.*, sum(quantityInStock) as tong_sl
from productlines a
    left join products b
    on a.productLine = b.productLine
group by a.productLine
order by tong_sl desc;