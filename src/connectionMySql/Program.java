package connectionMySql;

import com.company.TypeQuestion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Program {
    public static void main(String[] args) {
        try {
            String user = "root";
            String password = "root";
            String url = "jdbc:mysql://localhost:3307/testingsystem";
            String driver = "com.mysql.cj.jdbc.Driver";

            Class.forName(driver);
            Connection connection = DriverManager.getConnection(url, user, password);

            if (connection != null) {
                System.out.println("Ket noi thanh cong");
            } else {
                System.out.println("Ket noi that bai");
            }

            // thuc hanh viet cau lenh tĩnh
            // taọ đối tượng statement để làm việc với câu lệnh tĩnh
            Statement statement = connection.createStatement();
            // sd đối tượng resultSet để hứng kết quả trả về từ câu lệnh sql trả về, kq ở dạng bảng
            ResultSet resultSet = statement.executeQuery("select * from typequestion");

            List<TypeQuestion> typeQuestions = new ArrayList<>();
            // duyệt qua từng dòng của bảng kết quả trả về để ghi nhận và gán giá trị vào trong đối tượng
            while (resultSet.next()) {
                TypeQuestion typeQuestion = new TypeQuestion();
                int typeId = resultSet.getInt("TypeID"); // lấy giá trị từ cột TypeID, truyền vào tên cột trong sql
                String typeName = resultSet.getString("TypeName");
                typeQuestion.setTypeId(typeId);
                typeQuestion.setTypeName(typeName);
                typeQuestions.add(typeQuestion);
            }

            System.out.println(typeQuestions);
        } catch (ClassNotFoundException e) {
           System.err.println("Khong tim thay driver");
        }catch (SQLException e){
            // vao day khi url, user, password sai
            System.err.println("Khong the ket noi den database");
        }
    }
}
