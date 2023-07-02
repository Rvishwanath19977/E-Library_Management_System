/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Rating;

import Book.Book;
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
public class RatingDao {
            
    public int create(int userId, int bookId, int score) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        int generatedkey = 0;
 
        String query
                = "INSERT INTO rating (user_id, book_id, score, date_created) "
                + "VALUES (?, ?, ?, CURDATE())";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            ps.setInt(3, score);
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
    
    public int getUserBookRatingScore(int userId, int bookId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT score FROM rating WHERE user_id = ? and book_id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
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
    
    public double getAverageBookRatingScore(int bookId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT AVG(score)FROM rating WHERE book_id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, bookId);
            rs = ps.executeQuery();
            rs.next();
            return rs.getDouble(1);
        } catch (SQLException e) {
            System.out.println(e);
            return 0.0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public int updateRatingScore(int userId, int bookId, int score) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "UPDATE rating SET score = ?, date_updated = CURDATE() WHERE user_id = ? and book_id = ?";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query);
            ps.setInt(1, score);
            ps.setInt(2, userId);
            ps.setInt(3, bookId);
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
    
    public static List<Rating> getAllRatings() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Rating> list = new ArrayList();
 
        String query = "SELECT r.id, b.category_id, b.author, b.title, b.thumbnail, count(*) as count, AVG(r.score) as score FROM rating r join books b on b.id = r.book_id group by book_id ORDER by AVG(r.score) desc, count(*) desc";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            Rating rating = null;
            while (rs.next()) {
                rating = new Rating();
                rating.setId(rs.getInt("id"));
                rating.setCategoryId(rs.getInt("category_id"));
                rating.setTitle(rs.getString("title"));
                rating.setAuthor(rs.getString("author"));
                rating.setThumbnail(rs.getBlob("thumbnail"));
                rating.setScore(rs.getDouble("score"));
                rating.setCount(rs.getInt("count"));
                list.add(rating);
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
    
    public int getCountofBookRatings(int bookId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT count(*) FROM rating where book_id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, bookId);
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
}
