/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Book;

import Request.MonthlyRequestCount;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.ConnectionClass;
import utils.ConnectionPool;
import utils.DBUtil;

/**
 *
 * @author vishwanath
 */
public class BookDao {
    
    public static List<Book> getBooks(int categoryId, int limit, int start) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Book> list = new ArrayList();
        
        String query = "SELECT * FROM books where category_id = "+ categoryId +" LIMIT "+ start +", "+ limit;
        try {
            ps = connection.prepareStatement(query);
                        //ps.setString(1, title);
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
    
        public static List<Book> searchBooks(String query, String searchPhrase, boolean contains, boolean repeat) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Book> list = new ArrayList();
        
        try {

            ps = connection.prepareStatement(query);
            if(contains) {
                searchPhrase = searchPhrase
                    .replace("!", "!!")
                    .replace("%", "!%")
                    .replace("_", "!_")
                    .replace("[", "![");
                ps.setString(1, "%"+searchPhrase+"%");
            }
            else {
                ps.setString(1, searchPhrase);
            }
            if(repeat){
                ps.setString(2, searchPhrase);
            }
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
    
    public List<Book> getAllBooks() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        //ConnectionClass pool = new ConnectionClass();
        //Connection connection = pool.getFileFromResources();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Book> list = new ArrayList();
 
        String query = "SELECT * FROM books order by id desc";
        try {
            ps = connection.prepareStatement(query);
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
    
    public Book getBookById(int id) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Book> list = new ArrayList();
 
        String query = "SELECT * FROM books where id = " + id;
        try {
            ps = connection.prepareStatement(query);
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
            if(list.size() < 1) {
                return null;
            }
            return list.get(0);
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
        
    public static List<MonthlyRequestCount> getNumRequestPerMonth() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<MonthlyRequestCount> list = new ArrayList();
 
        String query = "SELECT Months.m AS month, COUNT(requests.date_created) AS total FROM ( SELECT 1 as m UNION SELECT 2 as m UNION SELECT 3 as m UNION SELECT 4 as m UNION SELECT 5 as m UNION SELECT 6 as m UNION SELECT 7 as m UNION SELECT 8 as m UNION SELECT 9 as m UNION SELECT 10 as m UNION SELECT 11 as m UNION SELECT 12 as m ) as Months LEFT JOIN requests on Months.m = MONTH(requests.date_created) AND YEAR(requests.date_created) = '2023' GROUP BY Months.m";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            MonthlyRequestCount monthlyRequestCount = null;
            while (rs.next()) {
                monthlyRequestCount = new MonthlyRequestCount();
                monthlyRequestCount.setMonth(rs.getInt("month"));
                monthlyRequestCount.setTotal(rs.getInt("total"));
                list.add(monthlyRequestCount);
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
    
    public int updateBookDetails(int quantity, String price, int id, String tags) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "UPDATE books SET date_updated = CURDATE(),"
                + "quantity = ?, price = ?, tags = ?"
                + "WHERE id = ?";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query);
            ps.setInt(1, quantity);
            ps.setString(2, price);
            ps.setString(3, tags);
            ps.setInt(4, id);
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
    
    public int deleteBook(int bookid) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "DELETE FROM book "
                + "WHERE id = ?";
        try {
            connection.setAutoCommit(false); 
            ps = connection.prepareStatement(query);
            ps.setInt(1, bookid);
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
    
    public int createBook(String title, String author, String isbn, String description, String price, InputStream image, String published_date, int quantity, int categoryId, String tags) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        int generatedkey = 0;
 
        String query
                = "INSERT INTO books (title, author, isbn, description, price, thumbnail, published_date, quantity, category_id, tags, date_created) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURDATE())";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, title);
            ps.setString(2, author);
            ps.setString(3, isbn);
            ps.setString(4, description);
            ps.setString(5, price);
            ps.setBlob(6, image);
            ps.setString(7, published_date);
            ps.setInt(8, quantity);
            ps.setInt(9, categoryId);
            ps.setString(10, tags);
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
    
        public int createRequest(String price, int userId, int bookId, String returningDate) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        int generatedkey = 0;
 
        String query
                = "INSERT INTO requests (user_id, book_id, price_paid, date_to_be_returned, date_created) "
                + "VALUES (?, ?, ?, ?, CURDATE())";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            ps.setString(3, price);
            ps.setString(4, returningDate);
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
    
    public int getCountofBooks() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT count(*) FROM books";
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
    
    public int getTotalCountForPagination(int categoryId) {
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
    
}
