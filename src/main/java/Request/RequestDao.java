/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Request;

import User.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.ConnectionPool;
import utils.DBUtil;

/**
 *
 * @author vishwanath
 */
public class RequestDao {
    
        public static int getNumberOfRequestByCountry(String countryCode) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT COUNT(*) FROM requests WHERE user_id in (select id from users where country = ?)";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, countryCode);
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
        
    public int getNumberOfNewRequests() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT COUNT(*) FROM requests WHERE status = false";
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
    
    public static int getCountOfRequestsByDecision(String decision) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT COUNT(*) FROM requests WHERE decision = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, decision);
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
        
    public List<Request> getAllRequests() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Request> list = new ArrayList();
 
        String query = "SELECT r.*, u.full_name, b.title FROM requests r join users u on u.id = r.user_id JOIN books b on b.id = r.book_id order by r.id desc";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            Request request = null;
            while (rs.next()) {
                request = new Request();
                request.setId(rs.getInt("id"));
                request.setName(rs.getString("full_name"));
                request.setBook(rs.getString("title"));
                request.setDateCreated(rs.getDate("date_created"));
                request.setDateUpdated(rs.getDate("date_updated"));
                request.setDateToBeReturned(rs.getString("date_to_be_returned"));
                request.setStatus(rs.getBoolean("status"));
                request.setReturned(rs.getBoolean("returned"));
                request.setReturnedDate(rs.getString("returned_date"));
                request.setDisbursed(rs.getBoolean("disbursed"));
                request.setDisbursedDate(rs.getString("disbursed_date"));
                request.setAmount(rs.getString("price_paid"));
                request.setDecision(rs.getString("decision"));
                list.add(request);
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
    
    public List<Request> getAllUserRequests(int userId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Request> list = new ArrayList();
 
        String query = "SELECT r.*, b.thumbnail, b.title FROM requests r join users u on u.id = r.user_id JOIN books b on b.id = r.book_id where r.user_id = ? order by r.id desc";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            Request request = null;
            while (rs.next()) {
                request = new Request();
                request.setId(rs.getInt("id"));
                request.setBook(rs.getString("title"));
                request.setDateCreated(rs.getDate("date_created"));
                request.setDateUpdated(rs.getDate("date_updated"));
                request.setDateToBeReturned(rs.getString("date_to_be_returned"));
                request.setStatus(rs.getBoolean("status"));
                request.setReturned(rs.getBoolean("returned"));
                request.setReturnedDate(rs.getString("returned_date"));
                request.setDisbursed(rs.getBoolean("disbursed"));
                request.setDisbursedDate(rs.getString("disbursed_date"));
                request.setAmount(rs.getString("price_paid"));
                request.setDecision(rs.getString("decision"));
                request.setThumbnail(rs.getBlob("thumbnail"));
                list.add(request);
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
    
    public int declineRequest(int id) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "UPDATE requests SET status = true, decision = 'Declined' WHERE id = ?";
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
    
        public int acceptRequest(int id) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "UPDATE requests SET status = true, decision = 'Accepted' WHERE id = ?";
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
        
    public int disburseRequest(int id, String date) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "UPDATE requests SET disbursed = true, disbursed_date = ? WHERE id = ?";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query);
            ps.setString(1, date);
            ps.setInt(2, id);
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
    
        public int returnRequest(int id, String date) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "UPDATE requests SET returned = true, returned_date = ? WHERE id = ?";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query);
            ps.setString(1, date);
            ps.setInt(2, id);
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
