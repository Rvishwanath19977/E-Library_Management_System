/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.ConnectionPool;
import utils.DBUtil;

/**
 *
 * @author vishwanath
 */
public class UserDao {
    
        public int insert(String name, String email, String address, String phone, String password, String country) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        int generatedkey = 0;
 
        String query
                = "INSERT INTO users (full_name, email, phone_number, password, address, country, date_created) "
                + "VALUES (?, ?, ?, ?, ?, ?, CURDATE())";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, password);
            ps.setString(5, address);
            ps.setString(6, country);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
               generatedkey=rs.getInt(1);
            }
 
            if (generatedkey > 0) {
 
            } else {
                connection.rollback();
                return 0;
            }
            connection.commit(); //transaction block end
            return generatedkey;
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public List<User> login(String email, String password) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<User> list = new ArrayList();
 
        String query = "SELECT * FROM users where email = ? and password = ? and active = true";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            User user = null;
            while (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setDateCreated(rs.getDate("date_created"));
                user.setDateUpdated(rs.getDate("date_updated"));
                user.setActive(rs.getBoolean("active"));
                user.setCountry(rs.getString("country"));
                list.add(user);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public boolean UserExists(String email) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
 
        String query = "SELECT email FROM users "
                + "WHERE email = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public List<User> getAllUsers() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<User> list = new ArrayList();
 
        String query = "SELECT * FROM users order by id desc ";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            User user = null;
            while (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setDateCreated(rs.getDate("date_created"));
                user.setDateUpdated(rs.getDate("date_updated"));
                user.setActive(rs.getBoolean("active"));
                user.setCountry(rs.getString("country"));
                list.add(user);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public int getCountofUsers() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT count(*) FROM users";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public int deactivateUser(int id) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "UPDATE users SET date_updated = CURDATE(), active = false WHERE id = ?";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
            connection.commit(); //transaction block end
            return 1;
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public int activateUser(int id) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "UPDATE users SET date_updated = CURDATE(), active = true WHERE id = ?";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
            connection.commit(); //transaction block end
            return 1;
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
}
