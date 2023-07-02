/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Favourite;

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
public class FavouriteDao {
        
    public int create(int userId, int bookId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        int generatedkey = 0;
 
        String query
                = "INSERT INTO favourites (user_id, book_id, date_created) "
                + "VALUES (?, ?, CURDATE())";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
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
    
    public int deleteFavourite(int userId, int bookId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "DELETE FROM favourites "
                + "WHERE user_id = ? and book_id = ?";
        try {
            connection.setAutoCommit(false); 
            ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
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
    
    public boolean favouriteExists(int userId, int bookId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
 
        String query = "SELECT * FROM favourites "
                + "WHERE user_id = ? and book_id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
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
    
    public List<Book> getUserFavourites(int userId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Book> list = new ArrayList();
        
        String query = "SELECT b.* FROM favourites f join books b on f.book_id = b.id where f.user_id = ? order by f.id desc";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            //ps.setString(2, author);
            rs = ps.executeQuery();
            Book book = null;
            while (rs.next()) {
                book = new Book();
                book.setId(rs.getInt("id"));
                book.setCategoryId(rs.getInt("category_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setDescription(rs.getString("description"));
                book.setIsbn(rs.getString("isbn"));
                book.setPublishedDate(rs.getString("published_date"));
                book.setPrice(rs.getString("price"));
                book.setQuantity(rs.getInt("quantity"));
                book.setTags(rs.getString("tags"));
                book.setDateCreated(rs.getDate("date_created"));
                book.setDateUpdated(rs.getDate("date_updated"));
                book.setThumbnail(rs.getBlob("thumbnail"));
                list.add(book);
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
    
    public List<UserFavourites> getUsersFavouritesCount() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<UserFavourites> list = new ArrayList();
        
        String query = "SELECT f.id, f.user_id, count(f.user_id) as count, u.full_name from favourites f join users u on u.id = f.user_id group by u.full_name order by u.full_name asc";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            UserFavourites userFavourites = null;
            while (rs.next()) {
                userFavourites = new UserFavourites();
                userFavourites.setId(rs.getInt("id"));
                userFavourites.setUserId(rs.getInt("user_id"));
                userFavourites.setCount(rs.getInt("count"));
                userFavourites.setFullName(rs.getString("full_name"));
                list.add(userFavourites);
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
