/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Review;

import Book.Book;
import Request.Request;
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
public class ReviewDao {
    
    public int create(int userId, int bookId, String review) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        int generatedkey = 0;
 
        String query
                = "INSERT INTO reviews (user_id, book_id, review, date_created) "
                + "VALUES (?, ?, ?, CURDATE())";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            ps.setString(3, review);
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
        
    public List<Review> getBookReviews(int bookId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Review> list = new ArrayList();
 
        String query = "SELECT r.id, u.full_name, r.user_id, r.review, r.date_created FROM reviews r join users u on u.id = r.user_id where r.book_id = ? order by r.id desc";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, bookId);
            rs = ps.executeQuery();
            Review review = null;
            while (rs.next()) {
                review = new Review();
                review.setId(rs.getInt("id"));
                review.setFullname(rs.getString("full_name"));
                review.setUserId(rs.getInt("user_id"));
                review.setReview(rs.getString("review"));
                review.setDateCreated(rs.getDate("date_created"));
                list.add(review);
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
    
    public int deleteReview(int reviewId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "DELETE FROM reviews "
                + "WHERE id = ?";
        try {
            connection.setAutoCommit(false); 
            ps = connection.prepareStatement(query);
            ps.setInt(1, reviewId);
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
    
    public int getCountofBookReviews(int bookId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT count(*) FROM reviews where book_id = ?";
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
    
    public List<ReviewList> getAllBooksReviewWithCount() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<ReviewList> list = new ArrayList();
        
        String query = "SELECT b.*, count(r.book_id) as count from reviews r join books b on b.id = r.book_id group by b.title order by b.title asc";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            ReviewList reviewList = null;
            while (rs.next()) {
                reviewList = new ReviewList();
                reviewList.setId(rs.getInt("id"));
                reviewList.setCategoryId(rs.getInt("category_id"));
                reviewList.setTitle(rs.getString("title"));
                reviewList.setAuthor(rs.getString("author"));
                reviewList.setDescription(rs.getString("description"));
                reviewList.setIsbn(rs.getString("isbn"));
                reviewList.setPublishedDate(rs.getString("published_date"));
                reviewList.setPrice(rs.getString("price"));
                reviewList.setQuantity(rs.getInt("quantity"));
                reviewList.setTags(rs.getString("tags"));
                reviewList.setDateCreated(rs.getDate("date_created"));
                reviewList.setDateUpdated(rs.getDate("date_updated"));
                reviewList.setThumbnail(rs.getBlob("thumbnail"));
                reviewList.setCount(rs.getInt("count"));
                list.add(reviewList);
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
}
