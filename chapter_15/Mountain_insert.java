import java.sql.*;

/* To run this program, rename it to Mountain.java and run these commands at the command line:
       javac Mountain.java
       java Mountain
*/
public class Mountain {
  public static void main(String args[]) {
    String url = "jdbc:mysql://localhost/topography";
    String username = "top_app";
    String password = "pQ3fgR5u5";
	
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection(url, username, password);
      String sql = "insert into mountain(mountain_name, location, height) " +
	                "values (?,?,?)";	
      PreparedStatement preparedStmt = conn.prepareStatement(sql);
      preparedStmt.setString(1, "Kangchenjunga");
      preparedStmt.setString(2, "Asia");
      preparedStmt.setInt(3, 28169);
      preparedStmt.executeUpdate();
      conn.close();
    } catch (Exception ex) {
      System.out.println(ex);
    }
  }
}

