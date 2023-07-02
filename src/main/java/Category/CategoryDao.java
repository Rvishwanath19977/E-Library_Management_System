/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Category;

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
public class CategoryDao {
    public static List<Category> getList() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Category> list = new ArrayList();
 
        String query = "SELECT * FROM category ";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            Category category = null;
            while (rs.next()) {
                category = new Category();
                category.setId(rs.getInt("id"));
                category.setTitle(rs.getString("title"));
                category.setDateCreated(rs.getDate("date_created"));
                category.setDateUpdated(rs.getDate("date_updated"));
                list.add(category);
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
        
    public int deleteCategory(int categoryId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "DELETE FROM category "
                + "WHERE id = ?";
        try {
            connection.setAutoCommit(false); 
            ps = connection.prepareStatement(query);
            ps.setInt(1, categoryId);
            ps.executeUpdate();
            connection.commit();
            return 1;
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public int createCategory(String name) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        int generatedkey = 0;
 
        String query
                = "INSERT INTO category (title, date_created) "
                + "VALUES (?, CURDATE())";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, name);
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
    
    public int getCountofCategories() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT count(*) FROM category";
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
    
    public static int getCountofBooksInACategory(int categoryId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT count(*) FROM books where category_id = " + categoryId;
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
    
    public static int getCountofBooksRequestByCategory(int categoryId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT count(*) from requests where book_id in (select id from books where category_id = " +categoryId+")"; 
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
    
    
    public static String getCategoryNameById(int id) {
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Category> list = new ArrayList();
 
        String query = "SELECT title FROM category where id = " + id;
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            Category category = null;
            while (rs.next()) {
                category = new Category();
                category.setTitle(rs.getString("title"));
                list.add(category);
            }
            if(list.size() < 1) {
                return null;
            }
            return list.get(0).getTitle();
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
}
