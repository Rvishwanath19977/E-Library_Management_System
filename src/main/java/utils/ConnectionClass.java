/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author vishwanath
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.ResourceBundle;
  
public class ConnectionClass {
    public Connection getFileFromResources()
    {
        //Properties prop = new Properties();
        
        try {
            //prop.load(getClass().getResourceAsStream(
                //"/Users/michael/NetBeansProjects/ELibrary/src/main/resources/application.properties"));
            ResourceBundle resource = ResourceBundle.getBundle("application");
  
            String dname = resource.getString("ds.database-driver");
                //= (String)prop.get("ds.database-driver");
  
            String dbConnUrl = resource.getString("ds.url"); //(String)prop.get("ds.url");
            String dbUserName = resource.getString("ds.username");
                //= (String)prop.get("ds.username");
            String dbPassword = resource.getString("ds.password");
                //= (String)prop.get("ds.password");
  
            Class.forName(dname);
            Connection dbConn = DriverManager.getConnection(
                dbConnUrl, dbUserName, dbPassword);
  
            if (dbConn != null) {
                System.out.println("Connection Successful");
            }
            else {
                System.out.println(
                    "Failed to make connection!");
            }
            return dbConn;
        }
        catch (ClassNotFoundException e) {
  
            e.printStackTrace();
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
  
    public static void close(Connection conn)
    {
        if (conn != null) {
            try {
                conn.close();
            }
            catch (SQLException e) {
                System.out.println(
                    "SQL Exception in close connection method");
            }
        }
    }
  
    public static void close(Statement stmt)
    {
        if (stmt != null) {
            try {
                stmt.close();
            }
            catch (SQLException e) {
                System.out.println(
                    "SQL Exception in close statement method");
            }
        }
    }
  
    public static void close(ResultSet rSet)
    {
        if (rSet != null) {
            try {
                rSet.close();
            }
            catch (SQLException e) {
                System.out.println(
                    "SQL Exception in close resultset method");
            }
        }
    }
}
