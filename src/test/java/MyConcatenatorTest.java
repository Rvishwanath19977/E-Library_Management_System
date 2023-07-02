
import Book.Book;
import Book.BookDao;
import java.util.List;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import static junit.framework.Assert.assertEquals;
import static junit.framework.Assert.assertNotNull;
import org.junit.Test;
import static org.mockito.Mockito.*;
import utils.ConnectionPool;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author vishwanath
 */
public class MyConcatenatorTest {
    
    
    //BookDao bookDao = new BookDao();
    
    
    @Test
    public void testConcatenate(){
        String concatenated = "man";

        assertEquals("man", concatenated);
    }
    
    @Test
    public void TestGetBooks() {
        
        //List<Book> book = bookDao.getBooks(1, 1, 1);
        //InitialContext ic = new InitialContext();
        //dataSource ;
        //DataSource datasource = (DataSource) ic.lookup("java:/comp/env/jdbc/elibrary"); //;mock(DataSource.class);
        //ConnectionPool pool =  mock(ConnectionPool.class);
        //List<Book> book = bookDao.getAllBooks();
        
        //assertNotNull(book);
    }
}
