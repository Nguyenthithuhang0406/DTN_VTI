import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Date;

public class Main {
    public static void main(String[] args) {

//        System.out.printf("Hello and welcome!");

        // 2 loại kiểu dữ liệu: nguyên thuỷ, object
        // kiểu dữ liệu nguyên thuỷ (8 loại: boolean, char, byte, short, int, long, float, double): có thể gán được giá trị trực tiếp cho biến
        // kiểu object (String, Date, Enum, Array, Object): phải khởi tạo

        byte number1 = -11;
        short number2 = 288;
        int number3 = 9999;
        long number4 = 999999999;

        float number5 = 5.1f;
        double number6 = 5.1;

        char char1 = 'a';
        char char2 = 'b';
        // char + char => (int) + ASCII
//        System.out.println(char1 + char2);

        String s1 = "a";
//        System.out.println(s1);

        Date d = new Date();

//        System.out.println(d);

        LocalDate localDate = LocalDate.now();
        LocalDateTime lct = LocalDateTime.now();
        LocalTime lt = LocalTime.now();

        System.out.println(lt);
    }
}