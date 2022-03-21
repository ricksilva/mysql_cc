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
      String sql = "call p_get_mountain_by_loc(?)";
	  CallableStatement stmt = conn.prepareCall(sql);
      stmt.setString(1, "Asia");
      ResultSet rs = stmt.executeQuery();
      while (rs.next()) {
        System.out.println(
          rs.getString("mountain_name") + " | " +
          rs.getInt("height")
        );
      }	  
    } catch (Exception ex) {
      System.out.println(ex);
    }
  }
}



