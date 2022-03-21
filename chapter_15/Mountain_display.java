import java.sql.*;

/* To run this program, rename it to Mountain.java and run these commands at the command line:
       javac Mountain.java
       java Mountain
*/
public class Mountain {
  public static void main(String args[]) {
    String url = "jdbc:mysql://localhost:3306/topography";
    String username = "top_app";
    String password = "pQ3fgR5u5";
	
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection(url, username, password);
      Statement stmt = conn.createStatement();
      String sql = "select mountain_name, location, height from mountain";
      ResultSet rs = stmt.executeQuery(sql);
      while (rs.next()) {
        System.out.println(
          rs.getString("mountain_name") + " | " +
          rs.getString("location") + " | " +
          rs.getInt("height")
        );
      }
    } catch (Exception ex) {
      System.out.println(ex);
    }
  }
}



